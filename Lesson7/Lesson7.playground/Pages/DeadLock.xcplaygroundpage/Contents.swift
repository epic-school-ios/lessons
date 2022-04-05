//: [Previous](@previous)

import Foundation

let serialQueue = DispatchQueue(label: "Serial", qos: .utility)


//serialQueue.async {
//    for i in 1...10 {
//        // находясь внутри последовательной очереди serialQueue, синхронно добавляем на нее операцию
//        serialQueue.sync {
//            sleep(1)
//            print(i)
//        }
//    }
//}
