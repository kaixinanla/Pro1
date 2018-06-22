//
//  RegisterViewController.swift
//  RxSwiftDemo
//
//  Created by 盛嘉 on 2018/3/27.
//  Copyright © 2018年 盛嘉. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//class RegisterViewController: UIViewController {
//  @IBOutlet weak var usernameTextField: UITextField!
//  @IBOutlet weak var usernameLabel: UILabel!
//  @IBOutlet weak var passwordTextField: UITextField!
//  @IBOutlet weak var passwordLabel: UILabel!
//  @IBOutlet weak var rpPasswordTextField: UITextField!
//  @IBOutlet weak var rpPasswordLabel: UILabel!
//
//  @IBOutlet weak var registerButton: UIButton!
//  let disposeBag = DisposeBag()
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    setupUI()
//    setupActionEvent()
//  }
//
//  func setupUI() {
//    view.backgroundColor  = UIColor.white
//    title = "注册"
////    let loginButton = UIButton(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
////    loginButton.setTitle("登陆", for: .normal)
////    loginButton .setTitleColor(UIColor.blue, for: .normal)
////    loginButton .setTitleColor(UIColor.gray, for: .highlighted)
////    let buttonItem = UIBarButtonItem(customView: loginButton)
////    navigationItem.rightBarButtonItem = buttonItem
////    weak var weakself = self
////    loginButton.rx.tap.asObservable().subscribe(onNext:{
////      let vc = LoginViewController()
////      weakself?.navigationController?.pushViewController(vc, animated: true)
////    }).disposed(by: disposeBag)
//  }
//
//  func setupActionEvent() {
//    let viewModel = RegisterModel()
//
//    usernameTextField.rx.text.orEmpty.bind(to: viewModel.username).disposed(by: disposeBag)
//
//    passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
//
//    rpPasswordTextField.rx.text.orEmpty.bind(to: viewModel.repeatPassword).disposed(by: disposeBag)
//
//    registerButton.rx.tap.bind(to:viewModel.registerTap).disposed(by: disposeBag)
//
//    viewModel.usernameUnable.bind(to: usernameLabel.rx.validationResult).disposed(by: disposeBag)
//
//    viewModel.passwordUnable.bind(to: passwordLabel.rx.validationResult).disposed(by: disposeBag)
//
//    viewModel.repeatPasswordUnable.bind(to: rpPasswordLabel.rx.validationResult).disposed(by: disposeBag)
//
//    viewModel.registerBttonUnable.subscribe(onNext:{ [weak self] valid in
//      self?.registerButton.isEnabled = valid
//      self?.registerButton.alpha = valid ? 1.0 : 0.5
//    }).disposed(by: disposeBag)
//
//    viewModel.registerResult.subscribe(onNext:{ [weak self] result in
//      switch result {
//      case .ok(let message):
//        self?.showAlert(message: message)
//      case .empty:
//        self?.showAlert(message: "")
//      case .failed(let message):
//        self?.showAlert(message: message)
//      }
//    }).disposed(by: disposeBag)
//  }
//
//  func showAlert(message:String) {
//    let action = UIAlertAction.init(title: "确定", style: .default, handler: nil)
//    let alertViewController = UIAlertController.init(title: nil, message: message, preferredStyle: .alert)
//    alertViewController.addAction(action)
//    present(alertViewController, animated: true, completion: nil)
//  }
//
//}











