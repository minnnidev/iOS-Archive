import Foundation

class Parent {
    func method() {
        print("안녕 난 부모님...")
    }
}

class Child: Parent {
    override func method() {
        print("안녕 난 자식!")
    }
}
//
//let instance: Parent = Child()
//instance.method()

let p1 = Parent()
let p2 = Parent()
let c1 = Child()
let c2 = Child()

let people = [p1, p2, c1, c2]
for person in people {
    person.method()
}

/*
 안녕 난 부모님...
 안녕 난 부모님...
 안녕 난 자식!
 안녕 난 자식!
 */
