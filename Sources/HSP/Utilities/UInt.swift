//
//  UInt.swift
//  
//
//  Created by Rex Fang on 2024-07-10.
//

extension UInt {
  var hammingWeight: UInt {
    var copy = self
    var count: UInt = 0
    while copy > 0 {
      count += 1
      copy &= copy - 1
    }
    return count
  }
  var binaryOnePositions: [UInt] {
    var copy = self
    var comparatorIndex: UInt = 0
    var comparator: UInt = 1
    var positions = [UInt]()
    while copy != 0 {
      if copy & comparator != 0 {
        positions.append(comparatorIndex)
        copy -= comparator
      }
      comparatorIndex += 1
      comparator <<= 1
    }
    return positions
  }
}
