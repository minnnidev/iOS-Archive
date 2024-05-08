import Foundation

// 클래스 키워드로 작성된 타입 프로퍼티
//class AClass {
//    class var testTypeProperty: Int {
//        return 5
//    }
//}
//
//class BClass: AClass {
//    override class var testTypeProperty: Int {
//        return 10
//    }
//}


//print(AClass.testTypeProperty) // 5
//print(BClass.testTypeProperty) // 10

// 클래스 키워드로 작성된 타입 메서드
//class AClass {
//    class func hi() {
//        print("Hi")
//    }
//}
//
//class BClass: AClass {
//    override class func hi() {
//        print("Hi2")
//    }
//}
//
//AClass.hi() // Hi
//BClass.hi() // Hi2

//class Car {
//    let model = "BMW X5"
//    var ownerName = "Min"
//}
//
//let car = Car()

// 구조체와의 초기화 비교
//struct Student {
//    var name: String
//    var age: Int
//}
//
//let min = Student(name: "min", age: 25)
//print(min)

//class Car {
//    var model: String
//    var ownerName: String
//
//    init() {
//        self.model = "BMW X5"
//        self.ownerName = "Mini"
//    }
//
//    init(ownerName: String) {
//        self.model = "BMW X5"
//        self.ownerName = ownerName
//    }
//
//    init(model: String, ownerName: String) {
//        self.model = model
//        self.ownerName = ownerName
//    }
//}

//let car1 = Car()
//print(car1.model, car1.ownerName) // BMW X5 Mini
//
//let car2 = Car(ownerName: "June")
//print(car2.model, car2.ownerName) // BMW X5 June
//
//let car3 = Car(model: "Benz eclass", ownerName: "Ham")
//print(car3.model, car3.ownerName) // Benz eclass Ham

//var car = Car()
//print(car.model)
//car.model = "툭툭이"
//print(car.model)

// 구조체 인스턴스 접근 및 슈정
//class Car {
//    let model = "툭툭이"
//    var ownerName = "min"
//}
//
////var car = Car()
////car.ownerName = "외제차"
////print(car)
//
//let car1 = Car()
//print(car1.model, car1.ownerName) // 툭툭이 min
//let car2 = car1
//car2.ownerName = "june" // car1의 ownerName 수정
//print(car1.ownerName, car2.ownerName) // june june

