// ARC

import Foundation

// ARC 간단 예제
//class Person {
//    let name: String
//
//    init(name: String) {
//        self.name = name
//        print("initialized...")
//    }
//
//    deinit {
//        print("deinitialized...")
//    }
//}
//
//var ref1: Person?
//var ref2: Person?
//var ref3: Person?
//
//// nothing...
//
//ref1 = Person(name: "Mini")
//// initialized...
//
//ref2 = ref1
//ref3 = ref1
//
//ref1 = nil
//ref2 = nil
//
//// nothing...
//
//ref3 = nil
//// deinitialized...

// 강한 참조 사이클

//class Person {
//    let name: String
//    var apartment: Apartment?
//
//    init(name: String) {
//        self.name = name
//    }
//
//    deinit {
//        print("\(name) is being deinitialized")
//    }
//}
//
//class Apartment {
//    let unit: String // 집 하나의 이름
//    var tenant: Person? // 세입자
//
//    init(unit: String) {
//        self.unit = unit
//    }
//
//    deinit {
//        print("Apartment \(unit) is being deinitialized")
//    }
//}
//
//var mini: Person?
//var unitA: Apartment?
//
//mini = Person(name: "Mini")
//unitA = Apartment(unit: "1A")
//
//mini!.apartment = unitA
//unitA!.tenant = mini
//
//mini = nil
//unitA = nil

// 강한 참조 사이클 없애기 - 약한 참조
//class Person {
//    let name: String
//    var apartment: Apartment?
//
//    init(name: String) {
//        self.name = name
//    }
//
//    deinit {
//        print("\(name) is being deinitialized")
//    }
//}
//
//class Apartment {
//    let unit: String // 집 하나의 이름
//    weak var tenant: Person? // 세입자
//
//    init(unit: String) {
//        self.unit = unit
//    }
//
//    deinit {
//        print("Apartment \(unit) is being deinitialized")
//    }
//}
//
//var mini: Person?
//var unitA: Apartment?
//
//mini = Person(name: "Mini")
//unitA = Apartment(unit: "1A")
//
//mini!.apartment = unitA
//unitA!.tenant = mini
//
//mini = nil // Mini is being deinitialized
//unitA = nil // Apartment 1A is being deinitialized

// 강한 참조 사이클 해결 - 미소유 참조
//class Customer {
//    let name: String
//    var card: CreditCard?
//
//    init(name: String) {
//        self.name = name
//    }
//
//    deinit { print("\(name) deinitialized...")}
//}
//
//class CreditCard {
//    let number: UInt64
//    unowned var customer: Customer
//
//    init(number: UInt64, customer: Customer) {
//        self.number = number
//        self.customer = customer
//    }
//
//    deinit { print("Card $\(number) deinitialized...")}
//}
//
//var mini: Customer?
//var card: CreditCard?
//
//mini = Customer(name: "Mini")
//card = CreditCard(number: 1234_5678_9012_3456, customer: mini!)
//
//mini!.card = card
//mini = nil

//mini = nil
///*
// Mini deinitialized...
// Card $1234567890123456 deinitialized...
// */

// 강한 참조 사이클 해결 - 옵셔널 unowned
//class Department { // 과를 나타내는 클래스
//    var name: String
//    var courses: [Course]
//
//    init(name: String) {
//        self.name = name
//        self.courses = []
//    }
//}
//
//class Course { // 과목들
//    var name: String
//    unowned var department: Department
////    unowned var nextCourse: Course?
//
//    init(name: String, in department: Department) {
//        self.name = name
//        self.department = department
////        self.nextCourse = nil
//    }
//}

/*
 과에는 과목들이 존재할 수 있지만, 과가 정해지지 않은 과목들은 존재할 수 없음.
 (... 음... 대충 전공 과목이라 생각해야 안 헷갈리겠다!)
 course의 department는 항상 존재할 것이고,
 department 인스턴스의 수명이 더 기므로 unowned로 참조하는 게 맞음.

 그럼 nextCourse에 대해 생각해 보자.
 후속 과목은 현재 과목이 존재할
 */

// 클로저에 대한 순환 참조
class SampleClass {
    var name: String

    lazy var someProperty: () -> Void = { [unowned self] in
        print("\(self.name)에서 클로저가 호출되었습니다. 😇")
    }

    init(name: String) {
        self.name = name
    }

    deinit { print("\(name) deinitalized...") }
}

var sampleClass: SampleClass?
sampleClass = SampleClass(name: "sampleClass")

sampleClass?.someProperty() // sampleClass에서 클로저가 호출되었습니다. 😇
sampleClass = nil // sampleClass deinitalized...
sampleClass?.someProperty() // nil
