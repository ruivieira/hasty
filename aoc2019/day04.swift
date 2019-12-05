import Swift
import Foundation

let input = "236491-713787".split(separator: "-").map { Int($0)! }

let items = (input[0]...input[1])

func to_digits(input: Int) -> [Int] {
    return String(input).map {Int(String($0))!}
}

func increasing(digits: [Int]) -> Bool {
    return digits.sorted { $0 < $1 } == digits
}

func counts(digits: [Int]) -> [Int: Int] {
    digits.reduce(into: [:]) { counts, number in counts[number, default: 0] += 1 }
}

func twice(digits: [Int]) -> Bool {
    !counts(digits: digits).values.filter { $0 >= 2 }.isEmpty
}

func twice_at_most(digits: [Int]) -> Bool {
    !counts(digits: digits).values.filter { $0 == 2 }.isEmpty
}

let part1 = items.filter { 
    let d = to_digits(input: $0)
    return increasing(digits: d) && twice(digits: d) 
}.count

let part2 = items.filter { 
    let d = to_digits(input: $0)
    return increasing(digits: d) && twice_at_most(digits: d) 
}.count

print("Part 1: \(part1)")
print("Part 2: \(part2)")
