//
//  RegisterViewModel.swift
//  RxSwiftDemo
//
//  Created by 盛嘉 on 2018/3/28.
//  Copyright © 2018年 盛嘉. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class RegisterModel {
  
  let username = BehaviorSubject<String>(value: "")
  let password = BehaviorSubject<String>(value: "")
  let repeatPassword = BehaviorSubject<String>(value: "")
  let registerTap = PublishSubject<Void>()
  
  let usernameUnable: Observable<Result>
  let passwordUnable: Observable<Result>
  let repeatPasswordUnable: Observable<Result>
  let registerBttonUnable: Observable<Bool>
  
  let registerResult: Observable<Result>
  
  init() {
    let service = ValidationService.instance
    
    usernameUnable = username.asObservable().flatMapLatest{username in
      return service.validateUsername(username)
        .observeOn(MainScheduler.instance)
        .catchErrorJustReturn(.failed(message:"username错误"))
    }
      .share(replay: 1, scope: .forever)
    
    passwordUnable = password
      .asObservable()
      .map{password in
      return service.validatePassword(password)
    }
      .share(replay: 1, scope: .forever)
    
    repeatPasswordUnable = Observable
      .combineLatest(password.asObservable(), repeatPassword.asObservable()) {
      return service.validateRepeatedPassword($0, $1)
      }
      .share(replay: 1, scope: .forever)
    
    registerBttonUnable = Observable
      .combineLatest(usernameUnable, passwordUnable, repeatPasswordUnable) {
      (username, password, repeatPassword) in
      username.isValid && password.isValid && repeatPassword.isValid
      }
      .share(replay: 1, scope: .forever)
    
    let usernameAndPassword = Observable
      .combineLatest(username.asObservable(), password.asObservable()) {
      ($0, $1)
    }
    
    registerResult = registerTap
      .asObserver()
      .withLatestFrom(usernameAndPassword)
      .flatMapLatest { (username, password) in
        return service
          .register(username, password: password)
          .observeOn(MainScheduler.instance)
          .catchErrorJustReturn(.failed(message: "注册错误"))
    }
      .share(replay: 1, scope: .forever)
  }
}
