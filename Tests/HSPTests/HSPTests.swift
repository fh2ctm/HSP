import Testing
@testable import HSP

@Suite("Cyclic groups of odd order")
struct OddCyclicGroup {
  let G = CyclicGroup(mod: 7)
  
  @Test("Range")
  func range() {
    print("Z/7Z has range \(G.normalizationRange). ")
  }
  
  @Test("Normalization")
  func normalize() {
    let a = G.normalize(7)
    #expect(a == 0)
    let b = G.normalize(5)
    #expect(b == -2)
  }
  
  @Test("Inverses")
  func inverse() {
    let a = G.inverse(of: 3)
    #expect(a == -3)
  }
  
  @Test("Elements")
  func elements() {
    print("Z/7Z has elements \(G.elements).")
  }
  
  @Test("Generating subgroup from subset")
  func span() {
    let genset = Set([2])
    let spanned = G.span(genset)
    #expect(spanned == G.elements)
  }
}

@Suite("Cyclic groups of even order")
struct EvenCyclicGroup {
  let G = CyclicGroup(mod: 6)
  
  @Test("Range")
  func range() {
    print("Z/6Z has range \(G.normalizationRange). ")
  }
  
  @Test("Normalization")
  func normalize() {
    let a = G.normalize(7)
    #expect(a == 1)
    let b = G.normalize(5)
    #expect(b == -1)
    let c = G.normalize(3)
    #expect(c == -3)
  }
  
  @Test("Inverses")
  func inverse() {
    let a = G.inverse(of: 3)
    #expect(a == -3)
  }
  
  @Test("Elements")
  func elements() {
    print("Z/6Z has elements \(G.elements).")
  }
  
  @Test("Generating subgroup from subset")
  func span() {
    let genset = Set([2])
    let spanned = G.span(genset)
    #expect(spanned == Set([-2,0,2]))
  }
}

@Suite("Utilities")
struct Utilities {
  let thirteen: UInt = 13
  let thirtyTwo: UInt = 32
  
  @Test("Hamming weight")
  func hammingWeight() {
    #expect(thirteen.hammingWeight == 3)
    #expect(thirtyTwo.hammingWeight == 1)
  }
  
  @Test("Binary one positions")
  func binary1Positions() {
    #expect(thirteen.binaryOnePositions == [0, 2, 3])
    #expect(thirtyTwo.binaryOnePositions == [5])
  }
}
