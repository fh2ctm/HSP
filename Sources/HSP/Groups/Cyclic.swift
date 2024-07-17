//
//  ZZ.swift
//  
//
//  Created by Rex Fang on 2024-07-05.
//

import Foundation

class CyclicGroup: FiniteGroup {
  
  var name: String { "Cyclic group of order \(self.order)" }
  
  typealias Element = Int
  
  /// Modulus of current group.
  let order: UInt
  
  var identity: Int { 0 }
  
  func inverse(of g: Int) -> Int { self.normalize(-g) }
  
  let normalizationRange: ClosedRange<Int>
  
  init(mod modulus: UInt) {
    self.order = modulus
    if modulus.isMultiple(of: 2) {
      let half = Int(modulus / 2) - 1
      self.normalizationRange = (-half - 1) ... half
    } else {
      let half = Int((modulus - 1) / 2)
      self.normalizationRange = (-half) ... half
    }
  }
  
  /// Normalize group elements to ensure each element is unique.
  /// - Parameter n: Integer to normalize
  /// - Returns: Normalized integer under current group modulus.
  func normalize(_ n: Int) -> Int {
    let firstMod = n % Int(self.order)
    if firstMod < self.normalizationRange.lowerBound {
      return firstMod + Int(self.order)
    } else if firstMod > self.normalizationRange.upperBound {
      return firstMod - Int(self.order)
    } else {
      return firstMod
    }
  }
  
  /// Group operation.
  internal func operate(_ a: Int, _ b: Int) -> Int {
    guard a != self.identity else {
      return self.normalize(b)
    }
    guard b != self.identity else {
      return self.normalize(a)
    }
    let result = self.normalize(a + b)
//    print("\(a) + \(b) mod \(self.order) = \(result)")
    return result
  }
  
  var elements: Set<Int> { Set(self.normalizationRange) }
  
  /// Compare whether two elements are equivalent under the current modulus.
  /// - Parameters:
  ///   - lhs: A group element.
  ///   - rhs: A group element.
  /// - Returns: Whether they are equivalent.
  func equivalent(_ lhs: Int, _ rhs: Int) -> Bool {
    return (lhs - rhs) % Int(self.order) == 0
  }
}
