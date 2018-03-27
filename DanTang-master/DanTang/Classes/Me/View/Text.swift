
//
//  Text.swift
//  DanTang
//
//  Created by 盛嘉 on 2018/3/20.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import Foundation
import UIKit

//protocol TargetAction {
//  func performAction ()
//}
//
//struct TargetActionWrapper<T:AnyObject>:TargetAction {
//  weak var target:T?
//  let action:(T) ->() ->()
//
//  func performAction() -> () {
//    if let t = target {
//      action(t)()
//    }
//  }
//}
//
//enum ControlEvent {
//  case TouchUpInside
//  case ValueChanged
//}
//
//class Control{
//  var actions = [ControlEvent:TargetAction]()
//
//  func setTarget<T:AnyObject>(target:T,
//                              action:@escaping(T) -> () -> (),
//                              controlEvent:ControlEvent){
//    actions[controlEvent] = TargetActionWrapper(
//      target:target,action:action)
//  }
//
//  func removeTargetForController(controlEvent:ControlEvent) {
//
//  }
//}

//protocol Vehicle {
//  var numberOfWheels:Int {get}
//  mutating func changeColor()
//}
//
//class ReverIterator<T>: InteratorProtocol {
//  typealias Element = T
//
//  var array:[Element]
//  var currentIndex = 0
//
//  init(array:[Element]) {
//    self.array = array
//    currentIndex = array.count - 1
//  }
//  func next() -> Element? {
//    if currentIndex < 0 {
//      return nil
//    }else {
//      let element = array[currentIndex]
//      currentIndex -= 1
//      return element
//    }
//  }
//}
//
//struct ReverseSequence<T>:Sequence {
//  var array:[T]
//
//  init(arrary:[T]) {
//    self.array = array
//  }
//  typealias Iterator = ReverseIterator<T>
//
//  func makeIterator() -> ReverseIterator<T> {
//    return ReverseIterator(array:self.array)
//  }
//}
//
//let arr = [0,1,2,3,4]
//
//for i in ReverseSequence(array:arr) {
//  print("Index\(i) is \(arr[i])")
//}
//
//var interator = arr.makeIterator()
//while let obj = interator.next(){
//  print(obj)
//}
//
//
//extension CGRect {
//  func divided(atDistance:CGFloat,from fromEdge:CGRectEdge) -> (slice:CGRect,remainder:CGRect) {
//
//  }
//}
//
//let rect = CGRect.init(x: 0, y: 0, width: 100, height: 100)
//let (small, large) = rect.divided(atDistace: 20, from: 2)
//
//
//func logIfTrue(_ predocate:@autoclosure() -> Bool) {
//  if predocate() {
//    print("True")
//
//  }
//}

//func doWork(block:()->()) {
//  block()
//}
//
//func doWorkAsync(block:@escaping ()->()) {
//  DispatchQueue.main.async {
//    block()
//  }
//}
//
//class S {
//  var foo = "foo"
//  func method1() {
//    doWork {
//      print(foo)
//    }
//    foo = "bar"
//  }
//  
//  func method2() {
//    doWorkAsync {
//      print(self.foo)
//    }
//  }
//}


  

