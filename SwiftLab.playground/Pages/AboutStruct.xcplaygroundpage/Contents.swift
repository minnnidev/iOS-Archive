import Foundation

// ✅ 기본 struct 구문에 대해
//struct Student {
//    var name = "Min"
//    var age = "25"
//}
//
//var min = Student()
//print(min.name) // Min
//
//min.name = "Min2"
//print(min.name) // Min2


// ✅ 초기화 구문
//struct Student {
//    var name: String
//    var age: Int
//
//    var testP: String {
//        get { return name }
//        set { name = newValue }
//    }
//}

//let min = Student() // error
//var min = Student(name: "Min", age: 25) // good 👍🏻
//min.testP = "Poo..."
//print(min.name)

//struct Student {
//    var name = "Min"
//    var age: Int
//}
//
////let min = Student() // error
////let min = Student(name: "Mini") // error
//let min = Student(age: 27) // 👍🏻 Student(name: "Min", age: 27)
//let mini = Student(name: "mini", age: 26) // 👍🏻 Stuent(name: "mini", age: 26)

//
//struct Student {
//    var name: String
//    var age: Int
//}
//
//let min = Student(name: "Hi", age: 25)

//let min = Student(name: "Min", age: 25)
//var anotherMin = min
//
//anotherMin.age = 6
//print("anotherMin의 나이:", anotherMin.age) // anotherMin의 나이: 6
//print("min의 나이:", min.age) // min의 나이: 25

// ✅ 배열, 딕셔너리, 문자열 같은 Swift의 collection은 최적화를 하여 복사 성능 비용을 줄인다?!
//let people = ["Kim", "Lee", "Park", "Choi"]
//var newPeople = people // 이때는 저장된 메모리를 공유
//
//// 수정되기 직전 복사되는 것
//newPeople[1] = "Nam"
//print(newPeople) // ["Kim", "Nam", "Park", "Choi"]

// 구조체 인스턴스 실험
//struct Student {
//    var name = "Min"
//    let age = 25
//}
//
//let min = Student()
//min.name = "Mini"d
