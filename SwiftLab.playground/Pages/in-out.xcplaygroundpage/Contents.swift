//: [Previous](@previous)

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let tmpA = a
    a = b
    b = tmpA
}

var a = 5
var b = 3
swapTwoInts(&a, &b)

print(a, b) // 3 5

// in-out 파라미터의 전달 과정
//var number: Int = 2 {
//    willSet {
//        print("newValue:", newValue)
//    }
//
//    didSet {
//        print("oldValue:", oldValue)
//    }
//}
//
//func inoutTest(num: inout Int) {
//    print("inoutTest1:", number)
//    num = 5
//    print("inoutTest2:", number)
//    num = 7
//    print("inoutTest3:", number)
//}
//
//inoutTest(num: &number)
//print("number:", number) // 7

/*
 inoutTest1: 2
 inoutTest2: 2
 inoutTest3: 2
 newValue: 7
 oldValue: 2
 number: 7
 */

// inout 인수로 전달된 값에 접근하기
//var property = 3
//
//func inoutTest(_ p: inout Int) {
//    p += property
//}
//
//inoutTest(&property)
