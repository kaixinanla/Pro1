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
  
  func register(_ username:String, password:String) -> Observable<Result> {
    let userDic = [username: password]
    let filePath = NSHomeDirectory() + "/Documents/users.plist"
    
    if (userDic as NSDictionary).write(toFile: filePath, atomically: true) {
      return .just(.ok(message:"注册成功"))
    }
    return .just(.failed(message:"注册失败"))
  }
  
  func usernameValid(_ username:String) -> Bool {
    let filePath = NSHomeDirectory() + "/Documents/users.plist"
    let userDic = NSDictionary(contentsOfFile: filePath)
    let usernameArray = userDic?.allKeys
    guard usernameArray != nil else {
      return false
    }
    
    if (usernameArray! as NSArray).contains(username) {
      return true
    } else {
      return false
    }
  }
  
  func loginUsernameValid(_ username:String) -> Observable<Result> {
    if username.count == 0 {
      return .just(.empty)
    }
    
    if usernameValid(username) {
      return .just(.ok(message:"用户名可用"))
    }
    return .just(.failed(message:"用户名不存在"))
  }
  
  func login(_ username:String, password:String) -> Observable<Result> {
    let filePath = NSHomeDirectory() + "/Documents/users.plist"
    let userDic = NSDictionary(contentsOfFile:filePath)
    if let userPass = userDic?.object(forKey: username) as? String {
      if userPass == password {
        return .just(.ok(message:"登录成功"))
      }
    }
    return .just(.failed(message:"密码错误"))
  }
}
