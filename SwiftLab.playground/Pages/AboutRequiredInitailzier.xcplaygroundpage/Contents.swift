import Foundation

// 상위 클래스
//class SomeClass {
//    required init() {
//        print("SomeClass init...")
//    }
//}
//
//// 하위 클래스
//class SomeSubclass: SomeClass {
//    var test: String
//
//    required init() {
//        print("subclass init...")
//    }
//
//    init(test: String) {
//        self.test = test
//        super.init()
//    }
//}
//
//let sb = SomeSubclass(test: "hi")

//class SomeClass {
//    required init() {
//        print("SomeClass init...")
//    }
//}
//
//// 하위 클래스
//class SomeSubclass: SomeClass {
//}
//
//let sb = SomeSubclass()

//protocol SomeProtocol {
//    init(param: Int)
//}
//
//class SomeClass {
//    required init(param: Int) {
//        print("Some Calss: initialize paramter", param)
//    }
//}
//
////let sc = SomeClass(param: 3) // initialize paramter 3
//
//class AnotherClass: SomeClass {
//    required init(param: Int) {
//        print("Another Class: initialize paramter", param)
//        super.init(param: param)
//    }
//}
//
//let ac = AnotherClass(param: 7)
///*
// Another Class: initialize paramter 5
// Some Calss: initialize paramter 5
//*/

//protocol SomeProtocol {
//    init(param: Int)
//}
//
//final class SomeClass: SomeProtocol {
//    init(param: Int) {
//        print("SomeClass initialize paramter", param)
//    }
//}
//
//let sc = SomeClass(param: 5) // SomeClass initialize paramter 5

//class AnotherClass: SomeClass {
//    required init(param: Int) {
//        print("AnotherClass initialize paramter", param)
//        super.init(param: param)
//    }
//}
//
//let ac = AnotherClass(param: 3)
/*
 AnotherClass initialize paramter 3
 SomeClass initialize paramter 3
 */

protocol SomeProtocol {
    init()
}

class SomeSuperClass {
    init() {
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
    required override init() {
    }
}
