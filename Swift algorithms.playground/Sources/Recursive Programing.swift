import Foundation

// Fibanachi sequence functions

public class RecersivePrograming {

    // Recersive fibinachi
    // O(2ⁿ)
    // Bad

    public static func fibinachiBad(i: Int) -> Int {
        if i == 0 {
            return 0
        }
        if i == 1 {
            return 1
        }
        return fibinachiBad(i: i - 1) + fibinachiBad(i: i - 2)
    }
    
    // Memoization fibinatchi
    // O(n)
    // Better
    public static func fibinachiWithMemory(i: Int) -> Int {
        var memo = [Int: Int]()
        return RecersivePrograming.fibinachiWithMemory(i: i, memo: &memo)
    }
    
    private static func fibinachiWithMemory(i: Int, memo: inout [Int: Int]) -> Int {
        if i == 0 || i == 1 {
            return i
        }
        if memo[i] == nil {
            memo[i] = fibinachiWithMemory(i: i - 1, memo: &memo) + fibinachiWithMemory(i: i - 2, memo: &memo)
        }
        return memo[i] ?? 0
    }
    
    // Botom up fibinachi with an array
    // O(n)
    // Better

    public static func fibinachiBottomUp(i: Int) -> Int {
        if i == 0 || i == 1 {
            return i
        }
        var memo = [0, 1]

        for num in 2...i {
            memo.append(memo[num - 1] + memo[num - 2])
        }
        return memo[i]
    }
    
    // Botom up fibinachi with just variables
    // O(n)
    // Better memory efficancy slower execution

    public static func fibinachiBottomUpNoMemo(i: Int) -> Int {
        if i == 0 || i == 1 {
            return i
        }
        var a = 0
        var b = 1
        for _ in 2..<i {
            let c = a + b
            a = b
            b = c
        }
        return a + b
    }
    
    // Top down dynamic programing
    // O(n3)
    // Memory efficent, slow performance
    // In this case the number of routes to climb a stare case of n stares
    // while climbing 1, 2, or 3 steps per stride
    
    public static func stepCombos(n: Int) -> Int {
        guard n >= 0 else {
            return 0
        }

        var possibleRouts = 0

        if n - 3 == 0 || n - 2 == 0 || n - 1 == 0 {
            possibleRouts += 1
        }

        possibleRouts += stepCombos(n: n - 3) + stepCombos(n: n - 2) + stepCombos(n: n - 1)
        return possibleRouts
    }
}
