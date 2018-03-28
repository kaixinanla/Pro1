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
  
  let username = Variable<String>("")
  let password = Variable<String>("")
  let repeatPassword = Variable<String>("")
  let registerTap = PublishSubject<Void>()
  
  let usernameUnable: Observable<Result>
  let passwordUnable: Observable<Result>
  let repeatPasswordUnable: Observable<Result>
  let registerBttonUnable: Observable<Bool>
  
  let registerResult: Observable<Result>
  
  init() {
    
  }
}
