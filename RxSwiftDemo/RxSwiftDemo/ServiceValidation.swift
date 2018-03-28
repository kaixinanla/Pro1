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
    
//    if usernameValid(username) {
//      return .just(.failed(message: "账户已存在"))
//    }
    
    return .just(.ok(message: "用户名可用"))
  }
}
