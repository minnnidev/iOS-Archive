//: [Previous](@previous)

import Foundation

protocol 모듈화 {
    func hi()
}

class B: 모듈화 {

    func hi() {
        print("B가 인사 중 👋🏻")
    }
}

class C: 모듈화 {

    func hi() {
        print("C가 인사 중")
    }
}

class A {
    let b: 모듈화

    init(b: 모듈화) {
        self.b = b
    }

    func sayHello() {
        b.hi()
    }
}

let a = A(b: B())
a.sayHello() // B가 인사 중 👋🏻
