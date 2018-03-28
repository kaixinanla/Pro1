//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by 盛嘉 on 2018/3/27.
//  Copyright © 2018年 盛嘉. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var rpPasswordTextField: UITextField!
  let disposeBag = DisposeBag()
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  func setupUI() {
    view.backgroundColor  = UIColor.red
    title = "注册"
    let loginButton = UIButton(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
    loginButton.setTitle("登陆", for: .normal)
    loginButton .setTitleColor(UIColor.white, for: .normal)
    loginButton .setTitleColor(UIColor.gray, for: .highlighted)
    let buttonItem = UIBarButtonItem(customView: loginButton)
    navigationItem.rightBarButtonItem = buttonItem
    weak var weakself = self
    loginButton.rx.tap.asObservable().subscribe(onNext:{
      let vc = LoginViewController()
      weakself?.navigationController?.pushViewController(vc, animated: true)
    }).disposed(by: disposeBag)
  }
  


}

