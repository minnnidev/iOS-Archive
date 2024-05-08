// subscript

import Foundation

//struct TimesTable {
//    let multiplier: Int
//
//    subscript(index: Int) -> Int {
//        return multiplier * index
//    }
//}
//
//let threeTimesTable = TimesTable(multiplier: 3)
//print(threeTimesTable[0]) // 0
//print(threeTimesTable[1]) // 3
//print(threeTimesTable[2]) // 6
//print(threeTimesTable[6]) // 18



//enum Planet: Int {
//    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
//
//    static subscript(n: Int) -> Planet {
//        return Planet(rawValue: n)!
//    }
//}
//
//let mars = Planet[4]
//print(mars) // mars

struct Point {
    var x: Int
    var y: Int

    subscript(coordinate: String) -> Int {
        return coordinate == "x" ? x : y
    }

    subscript(index: Int) -> Int {
        return index == 0 ? x : y
    }
}

var point = Point(x: 3, y: 5)
print(point["x"]) // 3
print(point[0]) // 3
