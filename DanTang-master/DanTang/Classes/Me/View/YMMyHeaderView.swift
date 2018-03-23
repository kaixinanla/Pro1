//
//  YMMyHeaderView.swift
//  DanTang
//
//  Created by 盛嘉 on 2018/3/6.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class YMMyHeaderView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    //初始化UI
    setupUI()
  }
  
  private func setupUI() {
    addSubview(bgImageView)
    addSubview(settingButton)
    addSubview(messageButton)
    addSubview(avatarButton)
    addSubview(nameLabel)
    
    bgImageView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(self)
      make.top.equalTo(-20)
    }
    
    
  }
  
  lazy var bgImageView: UIImageView = {
    let bgImageView = UIImageView()
    bgImageView.contentMode = .scaleAspectFill
    bgImageView.image = UIImage(named: "Me_ProfileBackground")
    return bgImageView
  }()
  
  lazy var messageButton: UIButton = {
    let messageButton = UIButton()
    messageButton.setImage(UIImage(named:"Me_message_20x20_"), for: .normal)
    return messageButton
  }()
  
  lazy var avatarButton: UIButton = {
    let avatarButton = UIButton()
    avatarButton.setImage(UIImage(named:"Me_message_20x20_"), for: .normal)
    return avatarButton
  }()
  
  lazy var settingButton: UIButton = {
    let settingButton = UIButton()
    settingButton.setImage(UIImage(named:"Me_settings_20x20_"), for: .normal)
    return settingButton
  }()
  
  lazy var nameLabel: UILabel = {
    let nameLabel = UILabel()
    return nameLabel
  }()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
