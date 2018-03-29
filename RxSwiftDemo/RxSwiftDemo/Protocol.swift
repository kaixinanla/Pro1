//
//  Protocol.swift
//  RxSwiftDemo
//
//  Created by 盛嘉 on 2018/3/28.
//  Copyright © 2018年 盛嘉. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum Result {
  case ok(message:String)
  case empty
  case failed(message:String)
}

extension Result {
  var isValid: Bool {
    switch self {
    case .ok:
      return true
    default:
      return false
    }
  }
}

extension Result {
  var textColor: UIColor {
    switch self {
    case .ok:
      return UIColor.green
    case .empty:
      return UIColor.black
    case .failed:
      return UIColor.red
    }
  }
}

extension Result {
  var description: String {
    switch self {
    case let .ok(message):
      return message
    case .empty:
      return ""
    case let .failed(message):
      return message
    }
  }
}

extension Reactive where Base:UILabel {
  var validationResult: Binder<Result> {
    return Binder(base) { label, result in
      label.textColor = result.textColor
      label.text = result.description
    }
  }
}

