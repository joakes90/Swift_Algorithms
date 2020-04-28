import Foundation

struct ProblemSolutions {
    
    func cellCompete(states:[Int], days:Int) -> [Int] {
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

    // starts with    1 0 0 0 0 1 0 0
    // needs to match 0 1 0 0 1 0 1 0
    
    
    
    // Finding the greatest common denominator
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
}



