import Foundation

// lazy와 연산 프로퍼티
//class TestClass {
//  lazy var test: Int = 0 {
//      willSet {
//          print("willSet called, newValue:", newValue)
//      }
//      didSet { 
//          print("didSet called!, oldValue:", oldValue)
//      }
//  }
//}

//let testClass = TestClass()
//testClass.test = 3
/*
 willSet called, newValue: 3
 didSet called!, oldValue: 0
 */

// 타입 프로퍼티
class TestClass {
    static let storedTypeProperty = "hi"
    static var storedTypeProperty2 = "hi2"
    static var computedTypeProperty: Int = 3 {
        willSet {
            print("newValue", newValue)
        }
        didSet {
            print("oldValue", oldValue)
        }
    }
}

//print(TestClass.storedTypeProperty) // hi
//TestClass.storedTypeProperty2 = "hi2 is gone!"
//print(TestClass.storedTypeProperty2) // hi2 is gone!
//print(TestClass.computedTypeProperty) // 6
TestClass.computedTypeProperty = 7
print(TestClass.computedTypeProperty) // 6
//
//// 클래스 타입의 연산 프로퍼티
//class Vehicle {
//    class var name: String {
//        return "Vehicle"
//    }
//}
//
//class Car: Vehicle {
//    override class var name: String {
//        return "Car"
//    }
//}
//
//Vehicle.name // "Vehicle"
//Car.name // "Car"
