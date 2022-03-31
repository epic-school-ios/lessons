//
//  ARC.swift
//  Lesson6
//
//  Created by Denis on 31.03.2022.
//

// ARC - Automatic Refference Counter
//let classB = B()
//
//class A {
//    // Strong Refference. 1 strong refference = + 1 в счетчике рефференсов
//    private var b: B? = classB
//
//    func removeB() {
//        b = nil
//    }
//}
//
//class B {
//
//}
//
//class C {
//    // у класса B при создании инстансов класса A и C счетчик референсов будет равен 2
//    private var b: B? = classB
//}


// у инстанса класса А и Б счетчик референсов будет равен 1, но никогда не сможет опустится до 0
class A {
    // unowned НЕ опциональный, также не увеличивает счетчик рефенсов, но если в действительности при обращении к инстансу B он окажется удаленным из памяти, то произойдет краш
    // unowned var b: B
    weak var b: B?
    
    init(b: B?) {
        self.b = b
    }
}

class B {
    let a: A
    
    init(a: A) {
        self.a = a
    }
}


// weak и unowned - эти модификаторы НЕ увеличивают счетчик рефенсов при присвоении им значения


