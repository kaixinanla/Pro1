//
//  LoginViewController.swift
//  RxSwiftDemo
//
//  Created by sss on 2018/3/28.
//  Copyright © 2018年 sss. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol MyProtocol {
  static func foo() -> String
}

class LoginViewController :UIViewController {
  
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  
  var viewModel: loginViewModel!
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupActionEvent()
    for point in cartesianSequence(xCount: 5, yCount: 3) {
      print("(x:\(point.x), y:\(point.y)")
    }
  }
  typealias potintType = (x:Int, y:Int)
  
  func cartesianSequence(xCount: Int, yCount: Int) -> UnfoldSequence<potintType, Int> {
    assert(xCount > 0 && yCount > 0)
    return sequence(state: 0, next: {
      (index: inout Int) -> potintType? in
      guard index < xCount * yCount else {return nil}
      defer {index += 1}
      return (x:index % xCount, y: index/xCount)
    })
  }
  
  func setupActionEvent() {
    viewModel = loginViewModel(input: (username: usernameTextField.rx.text.orEmpty.asDriver(), password:passwordTextField.rx.text.orEmpty.asDriver(), loginTap:loginButton.rx.tap.asDriver()), service: ValidationService.instance)
    
    viewModel.usernameUnable.drive(usernameLabel.rx.validationResult).disposed(by: disposeBag)
    
    viewModel.loginButtonEnabled.drive(onNext:{[weak self] valid in
      self?.loginButton.isEnabled = valid
      self?.loginButton.alpha = valid ? 1 : 0.5
    }).disposed(by: disposeBag)
    
    viewModel.loginResult.drive(onNext:{ [weak self] result in
      switch result {
      case let .ok(message):
        self?.showAlert(message: message)
      case .empty:
        self?.showAlert(message: "")
      case .failed(let message):
        self?.showAlert(message: message)
      }
    }).disposed(by: disposeBag)
  }
  
  func showAlert(message: String) {
    let action = UIAlertAction(title: "确定", style: .default, handler: nil)
    let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    alertViewController.addAction(action)
    present(alertViewController, animated: true, completion: nil)
  }
}
