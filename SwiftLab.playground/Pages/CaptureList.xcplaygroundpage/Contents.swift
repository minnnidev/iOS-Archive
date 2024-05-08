// CaptureList

import Foundation

var a = 0
var b = 0

let closure = { [a] in
    a = 30
    print(a, b)
}

a = 10
b = 10
closure() // 0 10
