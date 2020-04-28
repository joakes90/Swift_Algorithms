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

// Tree Traversal Tests

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

// Binary Search Tests

let foundIndex = Search.binarySearch(items: IntegerList, target: 22)
print("\(foundIndex)\n")

// Hash Tables Tests

var hashTabel = HashTable<String, Any>(capacity: 20)
hashTabel["firstName"] = "Justin"
hashTabel["lastName"] = "Oakes"
hashTabel["age"] = 29
hashTabel["job"] = "programer"
hashTabel["address"] = "1617 TenBears Rd"

print("Name: \(hashTabel["firstName"]!) \(hashTabel["lastName"]!)\nAge: \(hashTabel["age"]!)\nJob: \(hashTabel["job"]!)\nAddress: \(hashTabel["address"]!)")

hashTabel["age"] = 30
hashTabel["address"] = "Beverly Hills 90210"

print("\n")
print("New age: \(hashTabel["age"]!)\nNew address: \(hashTabel["address"]!)")

hashTabel["job"] = nil

print("\n")

print("New job: \(hashTabel["job"] ?? "none")\n")


// Bidirectional Search Tests

let pathExists = BidirectionalSearch.pathExists(nodeA: graph.root, nodeB: graph.root.adjacent[1])
print(pathExists)
