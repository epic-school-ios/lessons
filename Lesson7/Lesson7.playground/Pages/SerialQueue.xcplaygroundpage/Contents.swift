
import Foundation

// async
// асинхронно добавляем операцию на mainQueue, находясь на mainQueue
//for i in 1...10 {
//    DispatchQueue.main.async {
//        sleep(1)
//        print(i)
//    }
//}

// sync
// синхронно добавляем операцию на mainQueue, находясь в mainQueue - происходит deadLock
    DispatchQueue.main.sync {
        print("hi")
    }
