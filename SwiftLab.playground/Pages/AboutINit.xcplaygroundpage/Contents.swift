// 초기화에 대하여!

import Foundation

//struct Student {
//    var grade = 3
//}

// 초기화 파라미터
//class SomeClass {
//    var someProperty: Int
//
//    init(overthreeProperty: Int) {
//        someProperty = overthreeProperty - 3
//    }
//
//    init(for overFourProperty: Int) {
//        someProperty = overFourProperty - 4
//    }
//
//    init(_ overFiveProperty: Int) {
//        someProperty = overFiveProperty - 5
//    }
//}
//
//let someClassA = SomeClass(overthreeProperty: 5)
//someClassA.someProperty // 2
//let someClassB = SomeClass(for: 5)
//someClassB.someProperty // 1
//let someClassC = SomeClass(5)
//someClassC.someProperty // 0
//
//let someClass = SomeClass

// ✅ 기본 초기화 구문
//class Car {
//    var modelName = "BMW X5"
//    var ownerName: String?
//    var purchased = false
//}
//
//let car = Car()

// ✅ init vs convenience init

//class Student {
//    var name: String
//    var age: Int
//
////    init(name: String, age: Int) {
////        self.name = name
////        self.age = age
////    }
//
//    init(name: String, age: Int = 24) {
//        self.name = name
//        self.age = age
//    }
//
//    convenience init(name: String) {
//        var guessedAge: Int
//
//        if name == "민준" {
//            guessedAge = 17
//        } else if name == "민" {
//            guessedAge = 25
//        } else {
//            guessedAge = 0
//        }
//
//        self.init(name: name, age: guessedAge)
//    }
//}

//extension Student {
//    convenience init(name: String) {
//        var guessedAge: Int
//
//        if name == "민준" {
//            guessedAge = 17
//        } else if name == "민" {
//            guessedAge = 25
//        } else {
//            guessedAge = 0
//        }
//
//        self.init(name: name, age: guessedAge)
//    }
//}
//let min = Student(name: "Min", age: 25)
//let graduate = Student(name: "Mini")
//let mini = Student(name: "hmm")

//let min = Student(name: "민준")


// ✅ 클래스의 2단계 초기화

//class Human {
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//}
//
//class Student: Human {
//    var level: Int
//
//    // ✅
//    init(level: Int) {
//        self.level = level
//        super.init(name: "ming...")
//        self.name = "hmm..."
//    }
//
//    // ❎ error
////    init(level: Int) {
////        self.level = level
////        self.name = "hmm..."
////        super.init(name: "ming...")
////    }
//}

// 안전 점검 3
//class Human {
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//}
//
//class Student: Human {
//    var nickName: String
//    var age: Int
//
//    init(nickName: String, age: Int) {
//        self.nickName = nickName
//        self.age = age
//        super.init(name: nickName)
//    }
//}

// 안전 점검 4
//class Human {
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//
//    func eat() {
//        print("먹는듕")
//    }
//}
//
//class Student: Human {
//    var nickName: String
//    var age: Int
//
//    init(nickName: String, age: Int) {
//        self.nickName = nickName
//        self.age = age
//        super.init(name: nickName)
//
//        eat()
//        name = "test"
//    }
//}
//
//let student = Student(nickName: "mini", age: 25) // mini
//print(student.name)

// 2단계 초기화
//class Student {
//    var name: String = "Min"
//    var description: String {
//        return "Name: \(name)"
//    }
//}
//
//class June: Student {
//    var age: Int
//
//    init(age: Int) {
//        self.age = age
//        // super.inti()을 암시적으로 호출한다!
//    }
//}

// 자동 초기화 구문 상속
//class Food {
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//
//    convenience init() {
//        self.init(name: "[Unnamed]")
//    }
//}
//
//class RecipeIngredient: Food {
//    var quantity: Int
//
//    init(name: String, quantity: Int) {
//        self.quantity = quantity
//        super.init(name: name)
//    }
//
//    override convenience init(name: String) {
//        self.init(name: name, quantity: 1)
//    }
//}
//
//
//class ShoppingListItem: RecipeIngredient {
//    var purchased = false
//    var description: String {
//        var output = "\(quantity) x \(name)"
//        output += purchased ? " ✔" : " ✘"
//        return output
//    }
//}

// 실패 가능한 초기화 구문
//struct Animal {
//    let species: String
//
//    init?(species: String) {
//        if species.isEmpty { return nil }
//        self.species = species
//    }
//}
//
//let someCreature = Animal(species: "Giraffe")
//if let giraffe = someCreature {
//    print("An animal was initialized with a species of \(giraffe.species)")
//}
//// An animal was initialized with a species of Giraffe
//
//let unknownCreature = Animal(species: "")
//if unknownCreature == nil {
//    print("unknown")
//}


// 초기화 재정의
//class Document {
//    var name: String?
//
//    init() {}
//    init?(name: String) {
//        if name.isEmpty { return nil }
//        self.name = name
//    }
//}
//
//class UntitledDocument: Document {
//    override init() {
//        super.init(name: "[Untitled]")!
//    }
//}
//
//let test = UntitledDocument()
//print(test.name) // Optional("[Untitled]")

// required init

// 상위 클래스
class SomeClass {
    required init() {
        print("SomeClass init...")
    }
}

// 하위 클래스
class SomeSubclass: SomeClass {
    required init() {
        print("SomeSubclass init...")
    }
}

let sb = SomeClass()

/*
 SomeSubclass init...
 SomeClass init...
 */
