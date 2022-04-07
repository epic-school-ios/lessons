//: [Previous](@previous)

import Foundation

class ThreadSafeInt {
    // изолированный инт
    private var isolatedInt = 0
    
    // очередь изоляции
    private let isolationQueue = DispatchQueue(label: "isolation", attributes: .concurrent)
    
    // операция добавления, гарантируем что операция добавления в один момент будет единственной, которая будет выполняться
    func add(value: Int) {
        isolationQueue.async(flags: .barrier) {
            self.isolatedInt += value
        }
    }
    
    // операция записи, та же суть, как и у добавления
    func set(value: Int) {
        isolationQueue.async(flags: .barrier) {
            self.isolatedInt = value
        }
    }
    
    // инициализация
    init(_ value: Int) {
        isolationQueue.async(flags: .barrier) {
            self.isolatedInt = value
        }
    }
    
    // вариант чтения с синхронным вызовом, в один момент считывать файл может множество сущностей
    var int: Int {
        var result = 0
        isolationQueue.sync {
            result = isolatedInt
        }
        return result
    }
    
    // вариант чтения с асинхронным вызовом
    func getInt(completion: @escaping (Int) -> Void) {
        isolationQueue.async {
            completion(self.isolatedInt)
        }
    }
}
