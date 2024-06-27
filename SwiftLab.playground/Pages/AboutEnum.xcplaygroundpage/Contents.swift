//: [Previous](@previous)

import Foundation

enum Developer: Int {
    case iOS = 1
    case android
    case server
    case web
}

let developer2 = Developer(rawValue: 5)
print(developer2) // nil
// Optional(__lldb_expr_28.Developer.server)
