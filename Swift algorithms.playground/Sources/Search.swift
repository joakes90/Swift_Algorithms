import Foundation

public class Search {
    public static func binarySearch(items: [Int], target: Int) -> Int {
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
}


// Bidirectional search
public class BidirectionalSearch {

    public static func pathExists<T>(nodeA: Node<T>, nodeB: Node<T>) -> Bool {

        var queueA = Queue<Node<T>>()
        var queueB = Queue<Node<T>>()

        var visitedA: Set<Node<T>> = Set<Node<T>>()
        var visitedB: Set<Node<T>> = Set<Node<T>>()

        visitedA.insert(nodeA)
        visitedB.insert(nodeB)

        queueA.add(item: nodeA)
        queueB.add(item: nodeB)

        while !queueA.isEmpty() || !queueB.isEmpty() {
            if pathExistsHelper(queue: &queueA,
                                visitedFromThisSide: visitedA,
                                visitedFromThatSide: visitedB) {
                return true
            }
            if pathExistsHelper(queue: &queueB, visitedFromThisSide: visitedB, visitedFromThatSide: visitedA) {
                return true
            }
        }
        return false
    }

    private static func pathExistsHelper<T>(queue: inout Queue<Node<T>>,
        visitedFromThisSide: Set<Node<T>>,
        visitedFromThatSide: Set<Node<T>>) -> Bool {

        if !queue.isEmpty() {
            let next = queue.remove()
            let adjacentNodes: [Node<T>] = next?.adjacent ?? []
            for node in adjacentNodes {
                if visitedFromThatSide.contains(node) {
                    return true
                } else if !visitedFromThisSide.contains(node) {
                    queue.add(item: node)
                }
            }
        }
        return false
    }
}
