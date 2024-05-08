import Foundation

// ✅ 선언
//protocol SomeProtocol1 {
//
//}
//
//protocol SomeProtocol2 {
//
//}
//
//class Human {
//
//}
//
//class Student: Human, SomeProtocol1, SomeProtocol2 {
//
//}

// 프로퍼티 요구사항
//protocol FullyNamed {
//    var fullName: String { get }
//}


// ✅ 메서드 요구사항
//protocol SomeProtocol1 {
//    func someMethod()
//}
//
//class SomeClass: SomeProtocol1 {
//    func someMethod() {
//        print("someMethod 구현하기")
//    }
//}

// Mutating Method Requirements
//class Center {
//    var x: Double = 0.0
//    var y: Double = 0.0
//
//    func moveToRight(deltaX: Double) {
//        x += deltaX
//    }
//}

//protocol Togglable {
//    mutating func toggle() // 타입의 상태를 전환하는 메서드
//}
//
//struct TestStruct: Togglable {
//    var num = 0
//
//    mutating func toggle() {
//        num = 1
//        print("num:", num)
//    }
//}
//
//var ts = TestStruct()
//ts.toggle() // num: 1
//
//class TestClass: Togglable {
//    var num = 0
//
//    func toggle() {
//        num = 4
//        print("num:", num)
//    }
//}
//
//let tc = TestClass()
//tc.toggle() // num: 4


// ✅ Initializer Requirements
//protocol SomeProtocol {
//    init(param: Int)
//}

//class SomeClass  {
//    required init() {
//        print("initialized...")
//    }
//}
//
//class AnotherClass: SomeClass {
//    var param: Int
//
//    required init() {
//        print("initialized2...")
//    }
//
//    init(param: Int) {
//        print("param initialized...")
//    }
//}
//
//let ac = AnotherClass(param: 3)

//protocol SomeProtocol {
//    init()
//}
//
//class SomeSuperClass {
//    init() {
//    }
//}
//
//class SomeSubClass: SomeSuperClass, SomeProtocol {
//    required override init() {
//    }
//}

// ✅ extension

//protocol SomeProtocol {
//    func someMethod()
//}
//
//class SomeClass {
//    var someProtperty: Int
//
//    init(someProtperty: Int) {
//        self.someProtperty = someProtperty
//    }
//}
//
//let someClass = SomeClass(someProtperty: 3)
//someClass.someMethod()
//
//extension SomeClass: SomeProtocol {
//    func someMethod() {
//        print("채택했다!")
//    }
//}

//protocol SomeProtocol {
//    func someMethod()
//}
//
//class SuperClass {
//
//}
//
//class SomeClass: SuperClass {
//    var someProtperty: Int
//
//    init(someProtperty: Int) {
//        self.someProtperty = someProtperty
//    }
//
//    func someMethod() {
//        print("채택했다!")
//    }
//}
//
//
//extension SomeClass: SomeProtocol {}

// ✅ where
//for i in 0..<10 where i % 2 == 0 {
//    print(i)
//}
//
///*
// 0
// 2
// 4
// 6
// 8
// */

//protocol SomeProtocol {
//    var description: String { get }
//}
//
//class SomeClass: SomeProtocol {
//    var description: String {
//        return "💦"
//    }
//}
//
//extension Array: SomeProtocol where Element == Int {
//    var description: String {
//        return "✅"
//    }
//}
//
//let arr = [1, 2, 3]
//arr.description // ✅

// ✅ protocol as types
//protocol SomeProtocol {
//
//}
//
//class SomeClass: SomeProtocol {
//    init() {
//        print("initialized...")
//    }
//}
//
//let sc1:SomeClass = SomeClass() // initialized...
//let sc2:SomeProtocol = SomeClass() // initialized...

// 📌 Protocol 상속
//protocol SomeProtocol {
//    func someMethod()
//}
//
//protocol AnotherProtocol: SomeProtocol {
//    func anotherMethod()
//}
//
//class SomeClass: AnotherProtocol {
//    func anotherMethod() {
//        print("another method...")
//    }
//    
//    func someMethod() {
//        print("some method...")
//    }
//}

// 📌 class-only protocol
//protocol SomeClassOnlyProtocol: AnyObject {
//
//}
//
//// ✅
//class TestClass: SomeClassOnlyProtocol {
//
//}
//
//// 🚨
////struct TestStruct: SomeClassOnlyProtocol {
////
////}

// 📌 protocol composition
//protocol Named {
//    var name: String { get }
//}
//
//protocol Aged {
//    var age: Int { get }
//}
//
//struct Person: Named, Aged {
//    var name: String
//    var age: Int
//}
//
//func celebrateBirthday(to celebrator: Named & Aged) {
//    print("HBD!", celebrator.name)
//    print("Happy", celebrator.age)
//}
//
//let mini = Person(name: "Mini", age: 25)
//celebrateBirthday(to: mini)
///*
// HBD! Mini
// Happy 25
// */

// 📌 protocol extension
protocol AnotherPro {

}

//protocol RandomNumberGenerator {
//    func random() -> Double
//}
//
//extension RandomNumberGenerator {
//    func hi() {
//        print("hi")
//    }
//
//    func randomBool() -> Bool {
//        return random() > 0.5
//    }
//}
//
//class SomeClass: RandomNumberGenerator {
//    func random() -> Double {
//        return 0.3
//    }
//}
//
//let sc = SomeClass()
//sc.random() // 0.3
//sc.randomBool() // false
//sc.hi() // hi

//protocol RandomNumberGenerator {
//    func random() -> Double
//}
//
//extension RandomNumberGenerator {
//    func random() -> Double {
//        return 0.5
//    }
//}
//
//class SomeClass: RandomNumberGenerator {
//    func random() -> Double {
//        return 0.8
//    }
//}
//
//let sc = SomeClass()
//sc.random() // 0.8

// 📌 optional requirements
@objc protocol Living {
    func breath()
    @objc optional func eat()
}

class June: Living {
    func breath() {
        print("숨 쉬는 중...")
    }

    func eat() {
        print("먹는 중...")
    }
}

class Min: Living {
    func breath() {
        print("숨 쉬는 중...")
    }
}

