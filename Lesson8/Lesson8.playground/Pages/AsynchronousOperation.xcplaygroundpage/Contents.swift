//: [Previous](@previous)

import Foundation

let operationQueue = OperationQueue()

// MARK: Для того, чтобы создать асинхронную операцию, нужно перегрузить параметр isAsynchronous, но это только начало
//class AsyncOperation: Operation {
//    override var isAsynchronous: Bool {
//        return true
//    }
//
//    override func main() {
//        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
//            print("Executing")
//        }
//    }
//}

// Operations finished покажется до того, как покажется Executing, это происходит потому что для асинхронных операций нужен кастомный менеджмент состояния операции. А до тех пор, пока этого не случилось, у нас в мейне выполнилась операция добавления замыкания на глобальную очередь, и союственно все, операция теперь считается завершенной, хоть и замыкание внутри не выполнилось
//let operation = AsyncOperation()
//operationQueue.addOperations([operation], waitUntilFinished: true)
//print("Operations finished")


// MARK: Операция с кастомным менеджментом состояния
class AsyncOperation: Operation {
    // Происходит нечто похожее, как с потокобезопасным Интом, у нас есть параллельная очередь
    private let lockQueue = DispatchQueue(label: "lock", attributes: .concurrent)
    // перегружаем isAsynchronous, показывая, что операция асинхронная
    override var isAsynchronous: Bool {
        return true
    }
    
    // кастомная приватная пропертя isExecuting
    private var _isExecuting: Bool = false
    // Перегружаем isExecuting у суперкласса, обратите внимание что isExecuting имеет модификатор видимости private(set), только сама операция может менеджить свои состояния, из вне их менять нельзя(за исключением отмены(cancel))
    override private(set) var isExecuting: Bool {
        get {
            // синхронизируем возвращение isExecuting, также, как и с потокобезопасным интом
            return lockQueue.sync { () -> Bool in
                return _isExecuting
            }
        }
        set {
            // willChangeValue(forKey: String) это обязательный вызов, использующий KVO(Key Value Observing), который заставляем родительский класс реагировать на изменения isExecuting, иначе родительский класс будет реагировать изменения в параметре
            willChangeValue(forKey: "isExecuting")
            // изменяем значение используя барьер, гарантируя верное считывание значения после изменений
            lockQueue.async(flags: [.barrier]) { [weak self] in
                self?._isExecuting = newValue
            }
            // KVO только для didChangeValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    // кастомный менеджмент параметра isFinished тоже обязателен
    // создаем кастомный параметр isFinished
    private var _isFinished: Bool = false
    // Перезагружаем параметр родительского класса isFinished
    override private(set) var isFinished: Bool {
        get {
            // синхронизируем возвращение данных
            return lockQueue.sync { () -> Bool in
                return _isFinished
            }
        }
        set {
            //KVO willChangeValue, только для isFinished
            willChangeValue(forKey: "isFinished")
            // барьер, чтобы запись не произошла в момент считывания
            lockQueue.async(flags: [.barrier]) { [weak self] in
                self?._isFinished = newValue
            }
            //KVO для didChangeValue
            didChangeValue(forKey: "isFinished")
        }
    }

        // перегружаем метод родителя для запуска операций
    override func start() {
        // проверяем, что операция не cancelled, иначе заканчиваем с ней работу. ПРИ ЭТОМ ОБЯЗАТЕЛЬНО НАДО ЯВНО ставить isExecuting в false, а isFinished в true, это специфика operation
        guard !isCancelled else {
            finish()
            return
        }

        // если операция не отменена, то явно ставим isFinished а false, а isExecuting в true
        isFinished = false
        isExecuting = true
        main()
    }

    // main - место, где хранится наш асинхронный код, мейн обязательно надо перегружать сабклассам, обратите внимание, что super.main() НЕ вызывается, это потому что мы полностью перегружаем метод суперкласса Operation, полностью кастомизируя исполнение
    override func main() {
        fatalError("Subclasses must implement `main` without overriding super.")
    }

    // прекращаем выполнение операции
    func finish() {
        isExecuting = false
        isFinished = true
    }
}

final class FileUploadOperation: AsyncOperation {

    private let fileURL: URL
    private let targetUploadURL: URL
    private var uploadTask: URLSessionTask?

    init(fileURL: URL, targetUploadURL: URL) {
        self.fileURL = fileURL
        self.targetUploadURL = targetUploadURL
    }

    override func main() {
        uploadTask = URLSession.shared.uploadTask(with: URLRequest(url: targetUploadURL), fromFile: fileURL) { (data, response, error) in
            // Обработай респонс
            // ...
            // Вызови финиш
            self.finish()
        }
    }

    override func cancel() {
        uploadTask?.cancel()
        super.cancel()
    }
}
