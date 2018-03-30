//
//  LoginViewModel.swift
//  RxSwiftDemo
//
//  Created by idolplay-macpro on 2018/3/28.
//  Copyright © 2018年 sibada. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class loginViewModel {
  let usernameUnable:Driver<Result>
  let loginButtonEnabled: Driver<Bool>
  let loginResult: Driver<Result>
  
  init(input:(username:Driver<String>, password:Driver<String>, loginTap:Driver<Void>),service: ValidationService) {
    usernameUnable = input.username.flatMapLatest { username in
      return service.loginUsernameValid(username).asDriver(onErrorJustReturn: .failed(message: "连接失败"))
    }
    
    let usernameAndPassword = Driver.combineLatest(input.username, input.password) {
      ($0, $1)
    }
    
    loginResult = input.loginTap.withLatestFrom(usernameAndPassword).flatMapLatest {(username, password) in
      return service.login(username, password: password).asDriver(onErrorJustReturn: .failed(message: "失败了"))
    }
    
    loginButtonEnabled = input.password.map{$0.count > 0}.asDriver()
  }
}
