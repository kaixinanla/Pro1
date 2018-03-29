//
//  LoginViewController.swift
//  RxSwiftDemo
//
//  Created by 盛嘉 on 2018/3/28.
//  Copyright © 2018年 盛嘉. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginViewController :UIViewController {
  
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  
  var viewModel: loginViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  

}
