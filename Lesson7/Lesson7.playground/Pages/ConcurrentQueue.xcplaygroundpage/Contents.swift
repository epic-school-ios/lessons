import UIKit

let concurrentQueue = DispatchQueue(label: "Concurrent", qos: .utility, attributes: .concurrent)
// async
//асинхронно добавляем операцию на concurrentQueue

//for i in 1...10 {
//    concurrentQueue.async {
//        sleep(1)
//        print(i)
//    }
//}

// sync
// синхронно добавляем операцию на concurrentQueue, находясь в concurrentQueue

//concurrentQueue.async {
//    for i in 1...10 {
//        concurrentQueue.sync {
//            sleep(1)
//            print(i)
//        }
//    }
//}

// находясь на concurrentQueue, синхронно добавляем операцию на mainQueue, concurrentQueue блокируется, пока не выполнися код внутри DispatchQueue.main.sync

//concurrentQueue.async {
//    DispatchQueue.main.sync {
//        for i in 1...10 {
//            sleep(1)
//            print(i)
//        }
//    }
//    // этот код выполнится только тогда, когда синхронный вызов на глвной очереди выполнится
//    print("wow")
//}

concurrentQueue.async {
    DispatchQueue.main.sync {
        print("hi")
    }
}
