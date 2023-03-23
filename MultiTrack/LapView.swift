import SwiftUI

struct LapView: View {
    @ObservedObject var lap: Lap
    var body: some View {
        Text("Lap \(lap.number): \(lap.displayTime)")
    }
}
