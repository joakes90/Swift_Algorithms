import Foundation

public class HashTable<Key: Hashable, Value> {
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
    public func update(value: Value, for key: Key) -> Value? {
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
    public func removeValue(for key: Key) -> Value? {
        let index = self.index(for: key)
        if let (i, chain) = buckets[index].enumerated().first(where: { $0.1.key == key}) {
            buckets[index].remove(at: i)
            count -= 1
            return chain.value
        }
        
        return nil
    }
}

// Stack
public class Stack<T> {
    public class StackNode<T> {
        let data: T
        var next: StackNode<T>?

        public init(data: T) {
            self.data = data
        }
    }

    var top: StackNode<T>?

    public func pop() -> T? {
        guard top != nil else {
            return nil
        }
        let item = top?.data
        top = top?.next
        return item
    }

    public func push(item: T) {
        let newNode = StackNode(data: item)
        newNode.next = top
        top = newNode
    }

    public func peek() -> T? {
        return top?.data
    }

    public func isEmpty() -> Bool {
        return top == nil
    }
}

// Queue
public class Queue<T> {
    public class QueueNode<T> {
        let data: T
        var next: QueueNode<T>?
        
        init(data: T) {
            self.data = data
        }
    }
    
    var first: QueueNode<T>?
    var last: QueueNode<T>?
    
    public func add(item: T) {
        let newNode = QueueNode(data: item)
        if last != nil {
            last?.next = newNode
        }
        last = newNode
        if first == nil {
            first = last
        }
    }
    
    public func remove() -> T? {
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
    
    public func peek() -> T? {
        return first?.data
    }
    
    public func isEmpty() -> Bool {
        return first == nil
    }
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
//println(num.a)  // output 5
//println(num.b)  // output 5.078

