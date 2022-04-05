
import Foundation

let concurrentQueue = DispatchQueue(label: "Concurrent", qos: .utility, attributes: .concurrent)

let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
    concurrentQueue.async {
        print("basic operation started")
        sleep(3)
        print("basic operation executed")
    }
}

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    concurrentQueue.async(flags: .barrier) {
        print("barrier operation started")
        sleep(7)
        print("barrier operation finished")
    }
}




