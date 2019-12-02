import Swift
import Foundation

let OPCODE_HALT = 99
let OPCODE_ADD = 1

var opcodes = try! String(contentsOfFile: "inputs/input02")
    .filter { $0 != "\n" }
    .split(separator:",")
    .map { Int($0) ?? 0 }

func operation(opcode: Int, input: Array<Int>, start: Int) -> Int {
    if opcode == OPCODE_ADD {
        return input[input[start + 1]] + input[input[start + 2]] 
    } else {
        return input[input[start + 1]] * input[input[start + 2]] 
    }
}

func intcode(_ input: [Int], _ noun: Int, _ verb: Int) -> Int {
    var input = input
    (input[1], input[2]) = (noun, verb)
    for start in stride(from: 0, to: input.count, by: 4) {
        let OPCODE = input[start]
        if OPCODE == OPCODE_HALT { 
            break 
        } else {
            input[input[start + 3]] = operation(opcode: OPCODE, input: input, start: start)
        }
    }
    return input[0]
}

let match = (0..<100).flatMap { 
        noun in (0..<100).map { 
            verb in
            (noun, verb, intcode(opcodes, noun, verb)) 
        }
    }.filter { $2 == 19690720 }[0]

print("Part 1: \(intcode(opcodes, 12, 2))")
print("Part 2: \(match.0 * 100 + match.1)")
