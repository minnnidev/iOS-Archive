import Foundation

//let a = [5, 3, 1, 4, 2]

// ✅ 함수로 작성하기
//func ascending(_ i1: Int, _ i2: Int) -> Bool {
////    if i1 < i2 {
////        return true
////    } else {
////        return false
////    }
//    return i1 < i2
//}
//
//let sortedA = a.sorted(by: ascending)
//print(sortedA) // [1, 2, 3, 4, 5]

// ✅ 파라미터로 전부 넣어주기
//let sortedA = a.sorted(by: { (i1: Int, i2: Int) -> Bool in
//    return i1 < i2
//})
//print(sortedA) // [1, 2, 3, 4, 5]

// ✅ 타입 추론
//let sortedA = a.sorted(by: { i1, i2 in return i1 < i2 })
//print(sortedA) // [1, 2, 3, 4, 5]

// ✅ return 생략
//let sortedA = a.sorted(by: { i1, i2 in i1 < i2 })
//print(sortedA) // [1, 2, 3, 4, 5]

// ✅ 짧은 인수 이름
//let sortedA = a.sorted(by: { $0 < $1 })
//print(sortedA) // [1, 2, 3, 4, 5]

// ✅ 연산자 메서드
//let sortedA = a.sorted(by: <)
//print(sortedA) // [1, 2, 3, 4, 5]

// ✅ 후행 클로저
//let sortedA = a.sorted { $0 < $1 }
//print(sortedA) // [1, 2, 3, 4, 5]

// ✅ 다중 후행 클로저
//func test(first: (Int, Int) -> Int, 
//          second: (Int, Int) -> Int,
//          third: (Int, Int) -> Int) {
//    // ...
//}

// ✅ 캡처
//func externalMethod(_ a: Int) -> () -> Int {
//    var b = 0
//
//    func internalMethod() -> Int {
//        b += 10
//        return b
//    }
//    return internalMethod
//}
//
//let test = externalMethod(5)
//test
//test
//test

//func makeIncrementer(forIncrement amount: Int) -> () -> Int {
//    var runningTotal = 0
//    func incrementer() -> Int {
//        runningTotal += amount
//        return runningTotal
//    }
//    return incrementer
//}
//
//let increment = makeIncrementer(forIncrement: 10)
//increment() // 10
//increment() // 20
//increment() // 30
//
//let alsoIncrement2 = increment
//alsoIncrement2() // 40
//alsoIncrement2() // 50

//class TestClass {
//    var value = 0
//}
//
//var a = TestClass()
//var b = TestClass()
//let testClosure = { [a] in
//    print(a.value, b.value)
//}
//
//a.value = 10
//b.value = 15
//testClosure() // 10 15

var a = 0
var b = 0
let closure = { [a] in
    print(a, b)
}

a = 10
b = 10
closure() // 0 10
