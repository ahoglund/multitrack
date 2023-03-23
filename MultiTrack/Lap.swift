import Foundation

class Lap: ObservableObject, Identifiable, Hashable {
    let id = UUID()
    let number: Int
    @Published var displayTime: String

    init(number: Int, displayTime: String) {
        self.number = number
        self.displayTime = displayTime
    }

    // Implement the required methods for the Hashable protocol
    static func == (lhs: Lap, rhs: Lap) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
