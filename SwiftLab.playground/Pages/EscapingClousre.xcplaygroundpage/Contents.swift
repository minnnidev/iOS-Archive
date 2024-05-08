// escaping closure

import Foundation

/*
 만약에 함수 내에서 뭔가 비동기적 일을 하고 잇어...
 그러면 이걸 먼저 하는 게 아니라 함수는 먼저 종료시키고, 그 후에 함수를 호출한다는 건가
 */

//func test(_ closure: @escaping () -> Void) {
//    DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
//        closure()
//    }
//
//    print("test 함수 종료")
//}
//
//test { print("I'm escaping closure... 🐌") }


//var closures: [() -> Void] = []
//
//func addClosure(closure: @escaping () -> Void) {
//    closures.append(closure)
//}
//
//addClosure { print("escaping closure1... 🐌") }
//addClosure { print("escaping closure2... 🐌") }
//
//closures.forEach { $0() }

var closures: [() -> Void] = []

func doSomethingWithEscapingClosure(closure: @escaping () -> Void) {
    closures.append(closure)
}

func doSomethingWithClosure(closure: () -> Void) {
    closure()
}

class TestClass {
    var x = 10

    func testMethod() {
        doSomethingWithClosure { x = 100 }
        doSomethingWithEscapingClosure { [weak self] in
            self?.x = 200
        }
    }
}

let tc = TestClass()
tc.testMethod()
print(tc.x) // 100

closures.first?()
print(tc.x) // 200
