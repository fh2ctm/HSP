//
//  Int.swift
//  
//
//  Created by Rex Fang on 2024-07-05.
//

import Foundation

extension Double {
  func floor() -> Int { Int(Darwin.floor(self)) }
  func ceiling() -> Int { Int(Darwin.ceil(self)) }
}
