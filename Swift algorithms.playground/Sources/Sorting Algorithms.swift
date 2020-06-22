import Foundation

// Quick Sort

public class QuickSort {
    
    public static func sort<T: Comparable>(items: inout [T], left: Int? = nil, right: Int? = nil) {
        let left = left ?? 0
        let right = right ?? items.count - 1

        let index = partition(items: &items, left: left, right: right)
        if left < index - 1 {
            sort(items: &items, left: left, right: index - 1)
        }

        if index < right {
            sort(items: &items, left: index, right: right)
        }
    }
    
    private static func partition<T: Comparable>(items: inout [T], left: Int, right: Int) -> Int {
         let pivot = items[(left + right) / 2]
        var left = left
        var right = right

        while left <= right {
            while items[left] < pivot {
                left += 1
            }
            while items[right] > pivot {
                right -= 1
            }

            if left <= right {
                swap(items: &items, a: left, b: right)
                left += 1
                right -= 1
            }
        }
        return left
    }

    private static func swap<T: Comparable>(items: inout [T], a: Int, b: Int) {
        let temp = items[a]
        items[a] = items[b]
        items[b] = temp
    }

    // Anouther simpler more Swifty implimentation
    public static func swiftQuickSort<T: Comparable>(_ items: [T]) -> [T] {
        guard items.count > 1 else { return items }

        let pivot = items[items.count / 2]
        let less = items.filter({ $0 < pivot })
        let equal = items.filter({ $0 == pivot })
        let more = items.filter({ $0 > pivot })

        return QuickSort.swiftQuickSort(less) + equal + QuickSort.swiftQuickSort(more)
    }
}

// Merge Sort

public class MergeSort {
    public static func sort<T: Comparable>(items: inout [T]) {
        var helper = Array<T?>(repeating: nil, count: items.count)
        MergeSort.mergeSort(items: &items, helper: &helper, low: 0, high: items.count - 1)
    }

    private static func mergeSort<T: Comparable>(items: inout [T], helper: inout [T?], low: Int, high: Int) {
        guard low < high else {
            return
        }
        let middle = (low + high) / 2
        MergeSort.mergeSort(items: &items, helper: &helper, low: low, high: middle)
        MergeSort.mergeSort(items: &items, helper: &helper, low: middle + 1, high: high)
        MergeSort.merge(items: &items, helper: &helper, low: low, middle: middle, high: high)
    }

    private static func merge<T: Comparable>(items: inout [T], helper: inout [T?], low: Int, middle: Int, high: Int) {
        for i in low...high {
            helper[i] = items[i]
        }

        var helperLeft = low
        var helperRight = middle + 1
        var current = low

    // Iterate through helper array. Compare the left and right half, copying back the smaller element from the two halves into the original array.
        while helperLeft <= middle && helperRight <= high {
            guard let leftValue = helper[helperLeft],
                let rightValue = helper[helperRight] else {
                    return
            }
            if  leftValue <= rightValue {
                items[current] = leftValue
                helperLeft += 1
            } else {
                items[current] = rightValue
                helperRight += 1
            }
            current += 1
        }
    // Copy the rest of the left side of the array into the target array
        let remaining = middle - helperLeft
        if remaining >= 0 {
            for i in 0...remaining {
                if let helperValue = helper[helperLeft + i] {
                    items[current + i] = helperValue
                }
            }
        }
    }
}

public class BubbleSort {
    public static func sort<T: Comparable>(items: inout [T]) {
        for _ in 0..<items.count {
            for j in 0..<(items.count - 1) {
                if a=items[j] > items[j + 1] {
                    items.swapAt(j, j + 1)
                }
            }
        }
    }
}
