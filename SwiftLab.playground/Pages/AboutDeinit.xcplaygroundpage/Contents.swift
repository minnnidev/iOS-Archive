import Foundation

// 기본 예제
class Student {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
        print("init...")
    }

    deinit {
        print("deinit...")
    }
}

var mini: Student? = Student(name: "Mini", age: 25)
// 출력: init...
mini = nil
