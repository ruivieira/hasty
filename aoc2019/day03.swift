import Swift
import Foundation

struct Point: Hashable {
    let x: Int
    let y: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(x.hashValue)
        hasher.combine(y.hashValue)
    }
}

let CENTRE = Point(x:0, y:0)

let wires = try! String(contentsOfFile: "inputs/input03")
    .split(separator:"\n")
    .map { $0.split(separator: ",").map { String($0) } }

func direction(value: String) -> Point {
      switch value {
            case "U": return Point(x: -1, y: 0)
            case "D": return Point(x: 1, y: 0)
            case "L": return Point(x: 0, y: -1)
            case "R": return Point(x: 0, y: 1)
            default: return Point(x:0, y:0)
        }
}

func path(wire: Array<String>)  -> [Point: Int] {
    var i = 0
    var j = 0
    var step: Int = 1
    return Dictionary(wire.map { w in
        let d = direction(value: String(w.prefix(1)))
        return (0..<Int(String(w.dropFirst()))!).map { _ in
            i += d.x
            j += d.y
            step += 1
            return (Point(x: i, y: j), step - 1)
        }
    }.reduce([], +), uniquingKeysWith: { $1 })
}

let wires1 = path(wire: wires[0])
let wires2 = path(wire: wires[1])

let intersections = Set(wires1.keys).intersection(Set(wires2.keys))

let min_distance = intersections.map { abs($0.x - CENTRE.x) + abs($0.y - CENTRE.y) }.min()!
let min_steps = intersections.map { wires1[$0]! + wires2[$0]! }.min()!

print("Part 1: \(min_distance)")
print("Part 2: \(min_steps)")