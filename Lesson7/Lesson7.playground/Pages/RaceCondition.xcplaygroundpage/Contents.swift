
import Foundation

let concurrentQueue = DispatchQueue(label: "Concurrent", qos: .utility, attributes: .concurrent)

// У нас есть старый лейбл, мы его хотим обновить через результат "Сетевого" запроса, который выполняется не моментально
//var label = "old label"
//
//concurrentQueue.async {
//    sleep(1)
//    label = "new label"
//}
//
//print(label)

// чтобы исправить проблему, мы выполним код принта только тогда, когда сетевой запрос выполнится, используя замыкание completion
var label = "old label"

func getNewLabel(completion: @escaping (String) -> Void) {
    concurrentQueue.async {
        sleep(1)
        DispatchQueue.main.async {
            completion("new label")
        }
    }
}


getNewLabel { newValue in
    label = newValue
    print(label)
}

