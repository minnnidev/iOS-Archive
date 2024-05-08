// Generic

import Foundation

// generic 함수가 해결해줄 수 잇는 문제들
//func swapTwoInts(_ a: inout Int, _ b: inout Int) {
//    let temporaryA = a
//    a = b
//    b = temporaryA
//}
//
//var intA = 3
//var intB = 5
//swapTwoInts(&intA, &intB)
//print(intA, intB) // 5, 3
//
//func swapTwoStrings(_ a: inout String, _ b: inout String) {
//    let temporaryA = a
//    a = b
//    b = temporaryA
//}
//
//func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
//    let temporaryA = a
//    a = b
//    b = temporaryA
//}
//

//func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
//    let temporaryA = a
//    a = b
//    b = temporaryA
//}

//func swapTwoValues<U>(_ a: inout U, _ b: inout U) {
//    let temporaryA = a
//    a = b
//    b = temporaryA
//}

//var intA = 3
//var intB = 5
//var stringA = "hello"
//var stringB = "hi"
//
//swapTwoValues(&intA, &intB)
//print(intA, intB) // 5 3
//
//swapTwoValues(&stringA, &stringB)
//print(stringA, stringB) // hi hello

// generic type

//struct Stack<Element> {
//    var items = [Element]()
//
//    mutating func push(_ item: Element) {
//        items.append(item)
//    }
//
//    mutating func pop() -> Element {
//        return items.removeLast()
//    }
//}
//
//extension Stack {
//    var topItem: Element? {
//        return items.isEmpty ? nil : items[items.count-1]
//    }
//}
//
//var intStack = Stack<Int>()
//intStack.push(1)
//intStack.push(2)
//intStack.push(3)
//intStack.pop()
//print(intStack.items) // [1, 2]
//print(intStack.topItem) // Optional(2)
//
//var stringStack = Stack<String>()
//stringStack.push("mini")
//stringStack.pop()
//stringStack.push("june")
//stringStack.push("ham")
//print(stringStack.items) // ["june", "ham"]

// type constaints

//func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}
//
//let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
//if let foundIndex = findIndex(ofString: "llama", in: strings) {
//    print("The index of llama is \(foundIndex)")
//}

//func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}

// associated type
protocol Container {
    associatedtype Item

    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

struct Stack<Double>: Container {

    
    var count: Int
    
    func append(_ item: Double) {

    }
    
    subscript(i: Int) -> Double {
        return 0.0 as! Double
    }
}

//struct Stack<Element>: Container {
//    var items: [Element] = []
//
//    mutating func push(_ item: Element) {
//        items.append(item)
//    }
//    mutating func pop() -> Element {
//        return items.removeLast()
//    }
//
//    mutating func append(_ item: Element) {
//        self.push(item)
//    }
//
//    var count: Int {
//        return items.count
//    }
//    
//    subscript(i: Int) -> Element {
//        return items[i]
//    }
//}
