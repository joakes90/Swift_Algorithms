import Foundation


public class Node<T: Hashable>: Hashable {
    
    public static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.value == rhs.value
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
    
    var value: T
    // These would probably be used for a node in a tree
    var left: Node?
    var right: Node?
    // This would probably be used in a node in a graph with an adjacentcy table
    var adjacent: [Node<T>] = [Node<T>]()
    var visited = false
    init(value: T) {
        self.value = value
    }
    
    func visit() {
        visited = true
        print(value)
    }
}

public class Tree<T: Hashable> {
    let root: Node<T>

    public init(rootNode: Node<T>) {
        self.root = rootNode
    }
    
    // In-Order Traversal
    public func inOrderTraversal() {
        inOrderTraversal(node: root)
    }
    
    private func inOrderTraversal<T>(node: Node<T>) {
        if let left = node.left { inOrderTraversal(node: left) }
        node.visit()
        if let right = node.right { inOrderTraversal(node: right) }
    }

    // Pre-Order Traversal
    public func preOrderTraversal() {
        preOrderTraversal(node: root)
    }
    
    private func preOrderTraversal<T>(node: Node<T>) {
        node.visit()
        if let left = node.left { preOrderTraversal(node: left) }
        if let right = node.right { preOrderTraversal(node: right) }
    }

    // Post-Order Traversal
    public func postOrderTraversal() {
        postOrderTraversal(node: root)
    }
    
    private func postOrderTraversal<T>(node: Node<T>) {
        if let left = node.left { preOrderTraversal(node: left) }
        if let right = node.right { preOrderTraversal(node: right) }
        node.visit()
    }
    
    // Creating a tree for testing
    static func createNode(items: [T], index: Int) -> Node<T>? {
        guard index < items.count else {
            return nil
        }
        
        let value = items[index]
        let node = Node(value: value)
        node.left = createNode(items: items, index: (index * 2) + 1)
        node.right = createNode(items: items, index: (index == 0 ? 2 : (index * 2)))
        return node
    }

    public static func arrayToTree(items: [T]) -> Node<T>? {
        let rootNode = createNode(items: items, index: 0)
        return rootNode
    }
}


// Depth first
public class Graph<T: Hashable> {
 
    let root: Node<T>
    
    public init(root: Node<T>) {
        self.root = root
    }
    
    // Searching a graph depth first
    func depthFirstSearch<T>(node: Node<T>) {
        node.visit()
        root.adjacent.forEach { (node) in
            if !node.visited {
                node.visit()
            }
        }
    }
    
    // Searching a graph breadth first
    func breadthFirstSearch<T>(root: Node<T>)  {
        var queue = [Node<T>]()
        queue.append(root)
    
        while !queue.isEmpty {
            let node = queue.remove(at: 0)
            node.visit()
            node.adjacent.forEach { (child) in
                if !child.visited {
                    child.visit()
                    queue.append(child)
                }
            }
        }
    }
}
