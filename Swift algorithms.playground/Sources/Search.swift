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
