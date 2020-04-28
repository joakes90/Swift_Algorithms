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

print(RecersivePrograming.stepCombos(n: 20))

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

func jsonEncodeDecode() throws {
    // Encoding to JSON
    let myType = MyType.justinType()
    let encoder = JSONEncoder()
    let data = try encoder.encode(myType)

    print(String(data: data, encoding: .utf8)!)

    // Decoding from JSON
    let decoder = JSONDecoder()
    let decodedMyType = try decoder.decode(MyType.self, from: data)
    dump(decodedMyType)
}

func xmlPlistEncodeDecode() throws {
    // Encoding to Plist
    let myType = MyType.justinType()
    let encoder = PropertyListEncoder()
    encoder.outputFormat = .xml
    let data = try encoder.encode(myType)

    print(String(data: data, encoding: .utf8)!)

    // Decoding Plist
    let decoder = PropertyListDecoder()
    let decodedMyType = try decoder.decode(MyType.self, from: data)
    dump(decodedMyType)
}

try jsonEncodeDecode()
print("\n")
try xmlPlistEncodeDecode()

// Using Serialization for polymorphisum

protocol Length {}
struct Feet: Length {}
struct Meters: Length {}

struct Distance<Units: Length>: Codable, Equatable, ExpressibleByFloatLiteral {
    var value: Double

    static var unitType: String {
        String(describing: Units.self).lowercased()
    }

    struct UnitsKey: CodingKey {
        var stringValue: String

        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int? { fatalError() }

        init?(intValue: Int) { fatalError() }
    }

    init(floatLiteral value: FloatLiteralType) {
        self.value = value
    }

    init(from decoder: Decoder) throws {
        let continer = try decoder.container(keyedBy: UnitsKey.self)
        self.value = try continer.decode(Double.self, forKey: UnitsKey(stringValue: Distance.unitType)!)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UnitsKey.self)
        try container.encode(value, forKey: UnitsKey(stringValue: Distance.unitType)!)
    }
}

func testEncodingDistance() throws {
    let meters: [Distance<Meters>] = [5.0, 6.0 , 7.5, 8.25]
    let feet: [Distance<Feet>] = [15.0, 18.0, 22.5, 24.75]
    let encoder = JSONEncoder()
    let meterData = try encoder.encode(meters)
    let feetData = try encoder.encode(feet)

    print(String(data: meterData, encoding: .utf8)!)
    print(String(data: feetData, encoding: .utf8)!)

    let decoder = JSONDecoder()
    dump(try decoder.decode([Distance<Feet>].self, from: feetData))
    dump(try decoder.decode([Distance<Meters>].self, from: meterData))
}

//try testEncodingDistance()


// Tree Traversal
class Node<T: Hashable>: Hashable {
    
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.value == rhs.value
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
    
    var value: T
    // these would probably be used for a node in a tree
    var left: Node?
    var right: Node?
    // this would probably be used in a node in a graph with an adjacentcy table
    var adjacent: [Node<T>] = [Node<T>]()
    var visited = false
    init(value: T) {
        self.value = value
    }
}

func visit<T>(node: Node<T>) {
    node.visited = true
    print(node.value)
}

// In-Order Traversal
func inOrderTraversal<T>(node: Node<T>) {
    if let left = node.left { inOrderTraversal(node: left) }
    visit(node: node)
    if let right = node.right { inOrderTraversal(node: right) }
}

// Pre-Order Traversal
func preOrderTraversal<T>(node: Node<T>) {
    visit(node: node)
    if let left = node.left { preOrderTraversal(node: left) }
    if let right = node.right { preOrderTraversal(node: right) }
}

// Post-Order Traversal
func postOrderTraversal<T>(node: Node<T>) {
    if let left = node.left { preOrderTraversal(node: left) }
    if let right = node.right { preOrderTraversal(node: right) }
    visit(node: node)
}

// Creating a tree

func createNode(integers: [Int], index: Int) -> Node<Int>? {
    guard index < integers.count else {
        return nil
    }
    let value = integers[index]
    let node = Node(value: value)
    node.left = createNode(integers: integers, index: (index * 2) + 1)
    node.right = createNode(integers: integers, index: (index == 0 ? 2 : (index * 2)))
    return node
}

func arrayToTree(integers: [Int]) -> Node<Int>? {
    let rootNode = createNode(integers: integers, index: 0)
    return rootNode
}

//let values = [0, 1, 2, 3, 5, 8, 13, 21]
//let tree = arrayToTree(integers: values)

//inOrderTraversal(node: tree!)

//preOrderTraversal(node: tree!)

//postOrderTraversal(node: tree!)

// Searching a Graph depth first

func depthFirstSearch<T>(root: Node<T>) {
    visit(node: root)
    root.adjacent.forEach { (node) in
        if !node.visited {
            visit(node: node)
        }
    }
}

// Searching a graph breadth first
//    uses a hacky queue but should work for sample code

func breadthFirstSearch<T>(root: Node<T>)  {
    var queue = [Node<T>]()
    root.visited = true
    queue.append(root)

    while !queue.isEmpty {
        let node = queue.remove(at: 0)
        visit(node: node)
        node.adjacent.forEach { (child) in
            if !child.visited {
                visit(node: child)
                queue.append(child)
            }
        }
    }
}

// Binary Search

func binarySearch(items: [Int], target: Int) -> Int {
    var low = 0
    var high = items.count - 1
    
    while low <= high {
        let mid = (low + high) / 2
        if items[mid] < target {
            low = mid + 1
        } else if items[mid] > target {
            high = mid - 1
        } else {
            return mid
        }
    }
    return -1
}

//print(binarySearch(items: list, target: 10))

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

enum Number {
    case a(Int)
    case b(Double)

    var a:Int{
        switch(self)
        {
        case .a(let intval): return intval
        case .b(let doubleValue): return Int(doubleValue)
        }
    }

    var b:Double{
        switch(self)
        {
        case .a(let intval): return Double(intval)
        case .b(let doubleValue): return doubleValue
        }
    }
}
//let num = Number.b(5.078)
//
//println(num.a)  // output 5
//println(num.b)  // output 5.078

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