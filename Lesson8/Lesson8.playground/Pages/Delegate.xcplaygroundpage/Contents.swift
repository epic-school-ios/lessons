//: [Previous](@previous)

import Foundation

protocol BDElegate: AnyObject {
    func bark()
}

class A: BDElegate {
    let b = B()
    
    func bark() {
        print("Woof")
    }
}

class B {
    weak var delegate: BDElegate?
    
    func sayWoof() {
        delegate?.bark()
    }
}

let a = A()

let b = B()

b.delegate = a

b.sayWoof()
