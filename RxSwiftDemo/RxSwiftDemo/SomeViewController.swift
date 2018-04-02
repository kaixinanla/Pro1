//
//  SomeViewController.swift
//  RxSwiftDemo
//
//  Created by 盛嘉 on 2018/4/2.
//  Copyright © 2018年 盛嘉. All rights reserved.
//

import UIKit

//class SomeViewController: UIViewController {
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
////    let bookShelf1 = BookShelf()
////    bookShelf1.append(book: Book(name:"平凡的世界"))
////    bookShelf1.append(book: Book(name:"活着"))
////    bookShelf1.append(book: Book(name:"围城"))
////    bookShelf1.append(book: Book(name:"三国演义"))
//  }
//
//}
//
//struct Book {
//  var name:String
//}
//
//class BookShelf {
//  private var books:[Book] = []
//
//  func append(book:Book) {
//    self.books.append(book)
//  }
//
//  func makeIterator() -> AnyIterator<Book> {
//    var index: Int = 0
//    return AnyIterator<Book> {
//      defer {
//        index += 1
//      }
//      return index < self.books.count ? self.books[index] :nil
//    }
//  }
//}

class ReverseIterator<T>: IteratorProtocol {
  typealias Element = T
  
  var array: [Element]
  var currentIndex = 0
  
  init(array:[Element]) {
    self.array = array
    currentIndex = array.count + 1
  }
  
  
  func next() -> Element? {
    if currentIndex < 0 {
      return nil
    }else {
      let element = array[currentIndex]
      currentIndex -= 1
      return element
    }
  }
}

struct ReverseSequence<T>: Sequence {
  var array:[T]
  
  init(array:[T]) {
    self.array = array
  }
  
  typealias Iterator = ReverseIterator<T>
  
  func makeIterator() -> ReverseIterator<T> {
    return ReverseIterator(array: self.array)
  }
}





