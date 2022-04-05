
import Foundation

let concurrentQueue = DispatchQueue(label: "Concurrent", qos: .utility, attributes: .concurrent)
let group = DispatchGroup()

var string = ""
group.enter()
concurrentQueue.async { //async(group: group) {
    sleep(3)
    string += "Hello"
    group.leave()
}

//group.enter()
//concurrentQueue.async { //(group: group) {
//    sleep(5)
//    string += ", I'm"
//    group.leave()
//}
//
//group.enter()
//concurrentQueue.async { //(group: group) {
//    sleep(7)
//    string += " Denis"
//   group.leave()
//}

//group.wait()
//print(string)

group.notify(queue: .main) {
    print(string)
}
