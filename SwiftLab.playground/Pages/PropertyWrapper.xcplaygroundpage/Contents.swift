import Foundation

@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

//let zr = ZeroRectangle(height: 12, width: 15)
//let zeroRectangle = ZeroRectangle(height: .init(wrappedValue: 3, maximum: 2), width: .init(wrappedValue: 12, maximum: 15))
//print(zeroRectangle.height, zeroRectangle.width) // 2 12

