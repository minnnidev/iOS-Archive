import Foundation

//class Vehicle {
//    var currentSpeed = 0.0
//    var description: String {
//        return "현재 속도는 \(currentSpeed)입니다."
//    }
//
//    func makeNoise() {
//
//    }
//}

//let someVehicle = Vehicle()
//print(someVehicle.description) // 현재 속도는 0.0입니다.
//
//class Bicycle: Vehicle {
//    var hasBasket = true
//}
//
//let bicycle = Bicycle()
//print(bicycle.description) // 현재 속도는 0.0입니다.
//print("바구니 유무:", bicycle.hasBasket) // 바구니 유무: true
//bicycle.currentSpeed = 5.0
//print(bicycle.description) // 현재 속도는 5.0입니다.
//
//
//class MountainBike: Bicycle {
//
//}
//
//let mountainBike = MountainBike()
//mountainBike.hasBasket = false

// ✅ 재정의 - 메서드
//class Vehicle {
//    var currentSpeed = 0.0
//    var description: String {
//        return "현재 속도는 \(currentSpeed)입니다."
//    }
//
//    func makeNoise() {
//        print("소리가 난다... ~")
//    }
//}
//
//class Train: Vehicle {
//    override func makeNoise() {
//        super.makeNoise()
//        print("추추 🚂")
//    }
//}

//let train = Train()
//train.makeNoise()
/*
 소리가 난다... ~
 추추 🚂
 */

// ✅ 재정의 - 프로퍼티
//class Vehicle {
//    var currentSpeed = 0.0
//    var description: String {
//        return "현재 속도는 \(currentSpeed)입니다."
//    }
//
//    func makeNoise() {
//
//    }
//}
//
//class Car: Vehicle {
//    var gear = 1
//    override var description: String {
//        return "기어: \(gear), 속도: \(super.description)"
//    }
//}
//
//let car = Car()
//car.currentSpeed = 30
//print(car.description) // 기어: 1, 속도: 현재 속도는 30.0입니다.

// ✅ 재정의 - 프로퍼티 옵저버
//class Vehicle {
//    var currentSpeed = 0.0
//    var description: String {
//        return "현재 속도는 \(currentSpeed)입니다."
//    }
//
//    func makeNoise() {
//
//    }
//}
//
//class Car: Vehicle {
//    var gear = 1
//
//    override var description: String {
//        return "기어: \(gear), 속도: \(super.description)"
//    }
//}
//
//class AutomaticCar: Car {
////    override var currentSpeed: Double {
////        didSet {
////            gear = Int(currentSpeed / 10.0) + 1
////        }
////    }
//}
//
//let automaticCar = AutomaticCar()
//automaticCar.currentSpeed = 30
//print(automaticCar.description) // 기어: 4, 속도: 현재 속도는 30.0입니다.

// ✅ 재정의 - 프로퍼티 옵저버
//final class Vehicle {
//    var currentSpeed = 0.0
//    var description: String {
//        return "현재 속도는 \(currentSpeed)입니다."
//    }
//
//    func makeNoise() {
//
//    }
//}
//
//class Car: Vehicle { // 🚨 inheritance from a final class 'Vehicle'
//
//}

// ✅ 재정의 - 저장 프로퍼티
//class Vehicle {
//    var currentSpeed = 0.0
//}
//
//class Car: Vehicle {
//    var gear = 1
//
//    override var currentSpeed: Double {
//        get {
//            Double(gear) * 10.0
//        }
//
//        set {
//            gear = Int(newValue / 10.0)
//        }
//    }
//}

// ✅ 재정의 - 연산 프로퍼티 오버라이딩

//class Human {
//    var name = "Sodeul"
//
//    var alias = " 바보"
//}
//
//
//
//class Teacher: Human {
//    override var alias: String {
//        return self.name + " 멍청이"
//    }
//}

