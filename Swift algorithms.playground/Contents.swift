import Foundation

// Test Data
var unsigedIntegerList = [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]
var alphaList = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m"]
let dateList = [1990, 05, 13]
let IntegerList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// Sorts Tests
print(alphaList)
MergeSort.sort(items: &alphaList)
print("\(alphaList.map({ $0.uppercased() }))\n")

print(unsigedIntegerList)
QuickSort.sort(items: &unsigedIntegerList)
print("\(unsigedIntegerList)\n")

print(dateList)
let newDateList = QuickSort.swiftQuickSort(dateList)
print("\(newDateList)\n")

// Recursion / Dynamic programing

print(RecersivePrograming.fibinachiBad(i: 1))
print(RecersivePrograming.fibinachiWithMemory(i: 2))
print(RecersivePrograming.fibinachiBottomUp(i: 3))
print("\(RecersivePrograming.fibinachiBottomUpNoMemo(i: 4))\n")

print(RecersivePrograming.stepCombos(n: 5))

// Test using result types
func testResultTypes() {
    for _ in 0...5 {
        let result = ResultTests.randomEvennumber()
        switch result {
        case let .success(number):
            print("Success: \(number)")
        case let .failure(error):
            print("Failure: \(error.localizedDescription)")
        }
    }
}

testResultTypes()
print("\n")

let justinItem = MyType.justinType()
let json = try! justinItem.jsonEncode()
print("\(String(data: json, encoding: .utf8)!)\n")

let newJustinItem = try MyType.jsonDecode(data: json)
dump(newJustinItem)
print("\n")

let xmlItem = try! newJustinItem.xmlPlistEncode()
print(String(data: xmlItem, encoding: .utf8)!)
let itemFromPlist = try! MyType.xmlPlistDecoder(data: xmlItem)
dump(itemFromPlist)
print("\n")




func testEncodingDistance() throws {
    let meters: [Distance<Meters>] = [5.0, 6.0 , 7.5, 8.25]
    let feet: [Distance<Feet>] = [15.0, 18.0, 22.5, 24.75]
    let encoder = JSONEncoder()
    let meterData = try encoder.encode(meters)
    let feetData = try encoder.encode(feet)

    print(String(data: meterData, encoding: .utf8)!)
    print(String(data: feetData, encoding: .utf8)!)
}

print("\n")

try testEncodingDistance()

print("\n")

// Tree Traversal

let treeNode = Tree.arrayToTree(items: [0, 1, 2, 3, 5, 8, 13, 21])!
let tree = Tree(rootNode: treeNode)

tree.inOrderTraversal()

print("\n")

tree.preOrderTraversal()

print("\n")

tree.postOrderTraversal()

// Graph Traversal
let graph = Graph.arrayToGraph(items: [0, 2, 4, 6, 8, 10])

graph.depthFirstSearch()

print("\n")

graph.breadthFirstSearch()

print("\n")

// Binary Search

let foundIndex = Search.binarySearch(items: IntegerList, target: 22)
print("\(foundIndex)\n")

// Hash Tables

struct HashTable<Key: Hashable, Value> {
    private typealias Chain = (key: Key, value: Value)
    private typealias Bucket = [Chain]
    private var buckets: [Bucket]
    
    private(set) public var count = 0
    public var isEmpty: Bool {
        return count == 0
    }
    
    public init(capacity: Int) {
        // capacity give the opertunity to ballance memory performance (low capcatiy)
        // vs look up performance (high capacity)
        buckets = Array<Bucket>(repeating: [], count: capacity > 0 ? capacity : 1)
    }
    
    private func index(for key: Key) -> Int {
        return abs(key.hashValue) % buckets.count
    }
    
    public subscript(key: Key) -> Value? {
        get {
            return value(for: key)
        }
        
        set {
            if let value = newValue {
                update(value: value, for: key)
            } else {
                removeValue(for: key)
            }
        }
    }
    
    public func value(for key: Key) -> Value? {
        let index = self.index(for: key)
        return buckets[index].first(where: { $0.key == key })?.value
    }
    
    @discardableResult
    public mutating func update(value: Value, for key: Key) -> Value? {
        let index = self.index(for: key)
        
        if let (i, chain) = buckets[index].enumerated().first(where: { $0.1.key == key }) {
            let oldValue = chain.value
            buckets[index][i].value = value
            return oldValue
        }
        
        buckets[index].append((key: key, value: value))
        count += 1
        return nil
    }
    
    @discardableResult
    public mutating func removeValue(for key: Key) -> Value? {
        let index = self.index(for: key)
        if let (i, chain) = buckets[index].enumerated().first(where: { $0.1.key == key}) {
            buckets[index].remove(at: i)
            count -= 1
            return chain.value
        }
        
        return nil
    }
}

//var hashTabel = HashTable<String, Any>(capacity: 20)
//hashTabel["firstName"] = "Justin"
//hashTabel["lastName"] = "Oakes"
//hashTabel["age"] = 29
//hashTabel["job"] = "programer"
//hashTabel["address"] = "1617 TenBears Rd"
//
//print("Name: \(hashTabel["firstName"]!) \(hashTabel["lastName"]!)\nAge: \(hashTabel["age"]!)\nJob: \(hashTabel["job"]!)\nAddress: \(hashTabel["address"]!)")
//
//hashTabel["age"] = 30
//hashTabel["address"] = "Beverly Hills 90210"
//
//print("\n")
//print("New age: \(hashTabel["age"]!)\nNew address: \(hashTabel["address"]!)")
//
//hashTabel["job"] = nil
//
//print("\n")
//
//print("New job: \(hashTabel["job"] ?? "none")")

// Stack Data Structure
class Stack<T> {
    class StackNode<T> {
        let data: T
        var next: StackNode<T>?

        public init(data: T) {
            self.data = data
        }
    }

    var top: StackNode<T>?

    func pop() -> T? {
        guard top != nil else {
            return nil
        }
        let item = top?.data
        top = top?.next
        return item
    }

    func push(item: T) {
        let newNode = StackNode(data: item)
        newNode.next = top
        top = newNode
    }

    func peek() -> T? {
        return top?.data
    }

    func isEmpty() -> Bool {
        return top == nil
    }
}

// Queue Data Structure
class Queue<T> {
    class QueueNode<T> {
        let data: T
        var next: QueueNode<T>?
        
        init(data: T) {
            self.data = data
        }
    }
    
    var first: QueueNode<T>?
    var last: QueueNode<T>?
    
    func add(item: T) {
        let newNode = QueueNode(data: item)
        if last != nil {
            last?.next = newNode
        }
        last = newNode
        if first == nil {
            first = last
        }
    }
    
    func remove() -> T? {
        guard first != nil else {
            return nil
        }
        let data = first?.data
        first = first?.next
        if first == nil {
            last = nil
        }
        return data
    }
    
    func peek() -> T? {
        return first?.data
    }
    
    func isEmpty() -> Bool {
        return first == nil
    }
}


func cellCompete(states:[Int], days:Int) -> [Int]
{
    guard days > 0 else {
        return states
    }
    // Creating new array because states is not in out so it is inmutable
    var newStates = [Int]()
    for i in 0..<states.count {
        let previous = (i - 1 >= 0) ? states[i - 1] : 0
        let next = (i + 1 < states.count) ? states[i + 1] : 0
        if (previous == 1 && next == 1) || (previous == 0 && next == 0) {
            newStates.append(0)
        } else {
            newStates.append(1)
        }
    }
    print(newStates)
    return cellCompete(states: newStates, days: days - 1)
}

//let done = cellCompete(states: [1, 0, 0, 0, 0, 1, 0, 0], days: 1)

// starts with    1 0 0 0 0 1 0 0
// needs to match 0 1 0 0 1 0 1 0

func generalizedGCD(num:Int, arr:[Int]) -> Int
{
    let smallestN = arr.sorted(by: { $0 < $1} ).first ?? 1
    for i in 0..<smallestN {
        let candidate = smallestN - i
        print("candidate: \(candidate)")
        let remanserSet = Set(arr.map( { $0 % candidate } ))
        print(remanserSet)
        if remanserSet.count == 1 {
            return candidate
        }
    }
    return 1
}

// Example of an enum being used as a union

//enum Number {
//    case a(Int)
//    case b(Double)
//
//    var a:Int{
//        switch(self)
//        {
//        case .a(let intval): return intval
//        case .b(let doubleValue): return Int(doubleValue)
//        }
//    }
//
//    var b:Double{
//        switch(self)
//        {
//        case .a(let intval): return Double(intval)
//        case .b(let doubleValue): return doubleValue
//        }
//    }
//}
//let num = Number.b(5.078)
//
//println(num.a)  // output 5
//println(num.b)  // output 5.078
//
// Bidirectional search
//class bidirectionalSearch {
//
//    static func pathExists<T>(nodeA: Node<T>, nodeB: Node<T>) -> Bool {
//
//        var queueA = Queue<Node<T>>()
//        var queueB = Queue<Node<T>>()
//
//        var visitedA: Set<Node<T>> = Set<Node<T>>()
//        var visitedB: Set<Node<T>> = Set<Node<T>>()
//
//        visitedA.insert(nodeA)
//        visitedB.insert(nodeB)
//
//        queueA.add(item: nodeA)
//        queueB.add(item: nodeB)
//
//        while !queueA.isEmpty() || !queueB.isEmpty() {
//            if pathExistsHelper(queue: &queueA,
//                                visitedFromThisSide: visitedA,
//                                visitedFromThatSide: visitedB) {
//                return true
//            }
//            if pathExistsHelper(queue: &queueB, visitedFromThisSide: visitedB, visitedFromThatSide: visitedA) {
//                return true
//            }
//        }
//    }
//
//    private static func pathExistsHelper<T>(queue: inout Queue<Node<T>>,
//        visitedFromThisSide: Set<Node<T>>,
//        visitedFromThatSide: Set<Node<T>>) -> Bool {
//
//        if !queue.isEmpty() {
//            let next = queue.remove()
//            let adjacentNodes: Set<Node<T>> = next?.adjacent
//            for node in adjacentNodes {
//                if visitedFromThatSide.contains(node) {
//                    return true
//                } else if !visitedFromThisSide.contains(node) {
//                    queue.add(item: node)
//                }
//            }
//        }
//        return false
//    }
//}
