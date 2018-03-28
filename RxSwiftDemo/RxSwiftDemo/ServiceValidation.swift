//
//  ServiceValidation.swift
//  RxSwiftDemo
//
//  Created by 盛嘉 on 2018/3/28.
//  Copyright © 2018年 盛嘉. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class ValidationService {
  static let instance = ValidationService()
  
  private init() {}
  
  let minCharactersCount = 6
  
  func validateUsername(_ username: String) -> Observable<Result> {
    if username.count == 0 {
      return .just(.empty)
    }
    if username.count < minCharactersCount {
      return .just(.failed(message: "号码长度至少6个字符"))
    }
    
    return .just(.ok(message: "用户名可用"))
  }
  
  func validatePassword(_ password:String) -> Result {
    if password.count == 0 {
      return .empty
    }
    
    if password.count < minCharactersCount {
      return .failed(message: "密码长度至少6个字符")
    }
    
    return .ok(message: "密码可用")
  }
  
  func validateRepeatedPassword(_ password:String, _ repeatPassword:String) -> Result {
    if repeatPassword.count == 0 {
      return .empty
    }
    
    if repeatPassword == password {
      return .ok(message: "密码符合")
    }
    
    return .failed(message: "两次密码不一致")
  }
}
