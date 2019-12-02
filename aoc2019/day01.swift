import Swift
import Foundation

func fuel(mass: Int) -> Int {
    Int(floor(Double(mass) / 3.0)) - 2
}

let total = try! String(contentsOfFile: "inputs/input")
    .split(separator:"\n")
    .map { Int($0) ?? 0 }
    .map { fuel(mass: $0) }
    .reduce(0, +)

print("Total fuel:", total)
