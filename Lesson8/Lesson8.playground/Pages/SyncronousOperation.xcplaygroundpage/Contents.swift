import UIKit
import Foundation

let operationQueue = OperationQueue()

// MARK: Это синхронная операция, она используется, когда исполняемый в main код является синхронным, синхронная операция самостоятельно менеджит все состояния
class DatabaseSynchronousUpdateOperation: Operation {
    
    let index: Int
    
    override func main() {
        // проверяем, что нет отмененных зависимостей
         guard !dependencies.contains(where: { $0.isCancelled }), !isCancelled else { return }
        //print(dependencies)
        print("Updating Database Value \(index)")
    }
    
    init(index: Int) {
        self.index = index
        super.init()
    }
}

// MARK: Добавление операций на operationQueue
//let databaseUpdateOperation = DatabaseSynchronousUpdateOperation(index: 1)
//databaseUpdateOperation.completionBlock = {
//    print("Operation Executed")
//}
//
//operationQueue.addOperation(databaseUpdateOperation)
//// Что если мы добавим еще операций? Они будут выполняться одновременно, потому что operationQueue - параллельная очередь
//operationQueue.addOperation(DatabaseSynchronousUpdateOperation(index: 2))
//operationQueue.addOperation(DatabaseSynchronousUpdateOperation(index: 3))


// MARK: Добавление операций на operationQueue, используя зависимости
let operation1 = DatabaseSynchronousUpdateOperation(index: 1)
let operation2 = DatabaseSynchronousUpdateOperation(index: 2)
let operation3 = DatabaseSynchronousUpdateOperation(index: 3)
 // операция 1 зависима от выполнения операции 2 и 3
//operation1.addDependency(operation2)
//operation1.addDependency(operation3)

 // операция 1 зависима от операции 2, операция 2 зависима от операции 3
operation2.addDependency(operation3)
operation1.addDependency(operation2)
operation3.addDependency(operation1)

operationQueue.addOperations([operation1,
                              operation2,
                              operation3], waitUntilFinished: false)


