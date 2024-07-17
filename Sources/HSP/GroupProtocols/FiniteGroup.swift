//
//  FiniteGroup.swift
//  
//
//  Created by Rex Fang on 2024-07-05.
//

protocol FiniteGroup: Group {
  var order: UInt { get }
  func order(of: Element) -> UInt
  var elements: Set<Element> { get }
}

extension FiniteGroup {
  typealias E = Element
  func order(of g: E) -> UInt {
    var ord: UInt = 1
    var current = g
    while g != self.identity {
      current = self.operate(current, g)
      ord += 1
    }
    return ord
  }
  func elementSequence() -> any Sequence<Self.E> {
    return self.elements
  }
}
