// Auto Closure

import Foundation

// ✅ auto closure 미적용
//func test(_ closure: () -> Void) {
//    closure()
//}
//
//test({ print("안뇽1") })
//test {
//    print("안뇽2")
//}

// 안뇽1
// 안뇽2

// ✅ auto closure 적용
func test(_ closure: @autoclosure () -> Void) {
    closure()
}

test(print("wow 😇")) // wow 😇

// ✅ auto closure 사용 예시
//assert(3 < 5, "틀림! 🚨")

//assert(3 < 5, "3은 5보다 작은데요?")


var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"

let customerProvider = { customersInLine.remove(at: 0) } // () -> String
print(customersInLine.count)
//// Prints "5"
//
//print("Now serving \(customerProvider())!")
//// Prints "Now serving Chris!"
//print(customersInLine.count)
//// Prints "4"
