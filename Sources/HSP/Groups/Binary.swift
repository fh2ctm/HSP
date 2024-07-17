//
//  Binary.swift
//  
//
//  Created by Rex Fang on 2024-07-09.
//

class BinaryGroup: FiniteGroup {
  
  let identity = false
  
  typealias Element = Bool
  
  var elements: Set<Bool> { Set([false, true]) }
  
  let name = "Binary Group"
  
  func inverse(of g: Element) -> Element { !g }
  
  func operate(_ a: Bool, _ b: Bool) -> Bool {
    (a && b) ? false : (a || b)
  }
  
  func span(_ s: Set<Element>) -> Set<Element> {
    s.contains(true) ? Set([false, true]) : Set([false])
  }
  
  let order: UInt = 2
  
  func order(of g: Bool) -> UInt { g ? 2 : 1 }
  
  init() {}
}
