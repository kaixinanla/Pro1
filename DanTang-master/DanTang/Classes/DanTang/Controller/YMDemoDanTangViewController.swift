//
//  YMDemoDanTangViewController.swift
//  DanTang
//
//  Created by 盛嘉 on 2018/3/22.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import Foundation
import UIKit

class YMDemoViewController: YMBaseViewController, UIScrollViewDelegate{
  
  var channels = [YMChannel]()
  
  weak var titleView = UIView()
  
  weak var indicatorView = UIView()
  
  weak var contentView = UIScrollView()
  
  weak var selectedButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNav()
    weak var weakSelf = self
    YMNetworkTool.shareNetworkTool.loadHomeTopData { ym_channels in
      for channel in ym_channels {
        let vc = YMTopicViewController()
        vc.title = channel.name!
        vc.type = channel.id!
        weakSelf!.addChildViewController(vc)
      }
    }
  }
  
  func setupTitlesView() {
    let bgView  = UIView()
    bgView.frame = CGRect(x: 0, y: kTitlesViewY, width: SCREENW, height: kTitlesViewH)
    view.addSubview(bgView)
    
    let titlesView = UIView()
    titlesView.backgroundColor = UIColor.white
    titlesView.frame = CGRect(x: 0, y: 0, width: SCREENW - kTitlesViewH, height: kTitlesViewH)
    bgView.addSubview(titlesView)
    self.titleView = titlesView
    
    let indicatorView = UIView()
    indicatorView.backgroundColor = UIColor.red
    indicatorView.height = kIndicatorViewH
    indicatorView.y = kTitlesViewH - kIndicatorViewH
    indicatorView.tag = -1
    self.indicatorView = indicatorView
    
    let arrowButton = UIButton()
    arrowButton.frame = CGRect(x: SCREENW - kTitlesViewH, y: 0, width: kTitlesViewH, height: kTitlesViewH)
    arrowButton.setImage(UIImage(named:""), for: .normal)
    arrowButton.addTarget(self, action: #selector(arrowButtonClick), for: .touchUpInside)
    arrowButton.backgroundColor = YMGlobalColor()
    bgView.addSubview(arrowButton)
    
    let count = childViewControllers.count
    let width = titlesView.width / CGFloat(count)
    let height = titlesView.height
    
    for index in 0..<count {
      let button = UIButton()
      button.height = height
      button.width = width
      button.x = CGFloat(index) * width
      button.tag = index
      let vc = childViewControllers[index]
      button.titleLabel!.font = UIFont.systemFont(ofSize: 14)
      button.setTitle(vc.title!, for: .normal)
      button.setTitleColor(YMGlobalRedColor(), for: .disabled)
      button.setTitleColor(UIColor.gray, for: .normal)
      button.addTarget(self, action: #selector(titlesClick), for: .touchUpInside)
      titlesView.addSubview(button)
      
      if index == 0 {
        button.isEnabled = false
        selectedButton = button
        button.titleLabel?.sizeToFit()
        indicatorView.width = button.titleLabel!.width
        indicatorView.centerX = button.centerX
      }
    }
    titlesView.addSubview(indicatorView)
  }
  
  func setupNav() {
    view.backgroundColor = UIColor.white
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:""), style: .plain, target: self, action: #selector(rightButtonClick))
  }
  
  func arrowButtonClick(button:UIButton) {
    UIView.animate(withDuration: kAnimationDuration) {
      button.imageView?.transform = button.imageView!.transform.rotated(by: CGFloat(M_PI))
    }
  }
  
  func rightButtonClick()  {
    let searchBar = YMSearchViewController()
    navigationController?.pushViewController(searchBar, animated: true)
  }
  
  func titlesClick(button:UIButton) {
    selectedButton!.isEnabled = true
    button.isEnabled = false
    selectedButton = button
    
    UIView.animate(withDuration: kAnimationDuration) {
      self.indicatorView!.width = self.selectedButton!.titleLabel!.width;
      self.indicatorView!.centerX = self.selectedButton!.centerX
    }
    var offset = contentView!.contentOffset
    offset.x = CGFloat(button.tag)
    contentView!.setContentOffset(offset, animated: true)
  }
}


