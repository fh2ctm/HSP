//
//  Set.swift
//  
//
//  Created by Rex Fang on 2024-07-05.
//

internal let CONVERGENCE_SIZE_LIMIT = 1000

class SubsetIterator<E: Hashable> {
  enum SubsetIteratorError: Error {
    case subsetSizeExceededSetSize
  }
  typealias Element = E
  let setSequence: Array<E>
  let subsetSize: UInt
  var indicator: UInt = 0
  let indicatorUpperBound: UInt
  init(set: Set<E>, size: UInt) throws {
    guard size <= set.count else {
      throw SubsetIteratorError.subsetSizeExceededSetSize
    }
    self.subsetSize = size
    self.setSequence = Array(set)
    self.indicatorUpperBound = 1 << (subsetSize + 1)
  }
  func next() -> Set<E>? {
    guard self.indicator < self.indicatorUpperBound else {
      return nil
    }
    while self.indicator.hammingWeight != self.subsetSize {
      self.indicator += 1
    }
    defer {
      self.indicator += 1
    }
    return Set(
      self.indicator.binaryOnePositions.map { index in self.setSequence[Int(index)]
      }
    )
  }
}

extension Set {
  typealias E = Element
  
  func setMap(_ transform: (E) -> E) -> Set<E> {
    var mapped = Set<E>()
    for element in self {
      mapped += transform(element)
    }
    return mapped
  }
  
  func conjoin(_ anotherSet: Set<E>) -> Set<E> {
    return self.union(anotherSet)
  }
  
  func disjoin(_ anotherSet: Set<E>) -> Set<E> {
    return self.intersection(anotherSet)
  }
  
  static func += (lhs: inout Set<E>, rhs: E) {
    lhs.insert(rhs)
  }
  
  static func + (lhs: Set<E>, rhs: E) -> Set<E> {
    var copy = lhs
    copy += rhs
    return copy
  }
  
  static func -= (lhs: inout Set<E>, rhs: E) {
    lhs.remove(rhs)
  }
  
  static func - (lhs: Set<E>, rhs: E) -> Set<E> {
    var copy = lhs
    copy -= rhs
    return copy
  }
  
  /// Repeatedly replace S with S \* S for a number of times.
  /// - Parameters:
  ///   - expander: Binary operation on set elements.
  ///   - iterationLimit: Number of times to expand.
  /// - Returns: Expanded set.
  func expand(
    with expander: (E, E) -> E,
    iterate iterationLimit: UInt
  ) -> Set<E> {
    var output = self
    var iterationLimit = iterationLimit
    while iterationLimit > 0 {
      var currentSet = Set<E>()
      _ = zip(output, output).map { a, b in
        currentSet.insert(expander(a, b))
      }
      iterationLimit -= 1
      output = currentSet
    }
    return output
  }
  
  /// Repeatedly replace S with S \* S till it stops growing.
  /// - Parameter expander: Binary operation on set elements.
  /// - Returns: Expanded set.
  func expandTillConvergence(with expander: (E, E) -> E) -> Set<E> {
    var output = self
    while true {
      guard output.count < CONVERGENCE_SIZE_LIMIT else {
        return output
      }
      var currentSet = Set<E>()
      for a in output {
        for b in output {
          currentSet.insert(expander(a, b))
        }
      }
      if currentSet.count == output.count {
        return output
      }
      output = currentSet
    }
  }
}
