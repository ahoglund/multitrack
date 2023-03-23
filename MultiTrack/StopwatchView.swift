import SwiftUI

struct StopwatchView: View {
    @ObservedObject var stopwatch: Stopwatch
    @State private var isExpanded: Bool = false
    @State private var laps: [Lap] = []
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
            VStack {
                Button(action: {
                    isExpanded.toggle()
                }) {
                    HStack {
                        Text(stopwatch.displayTime)
                            .font(.title)
                    }
                }

                Divider()
                
                HStack {
                    if stopwatch.started() {
                        Button(action: {
                            stopwatch.addLap()
                        }) {
                            Text("Lap")
                        }
              
                        Divider().frame(height: 50) // adds a vertical line

                        Button(action: {
                            stopwatch.stop()
                        }) {
                            Text("Stop")
                        }
                        
                        
                    } else {
                        Button(action: {
                            stopwatch.start()
                        }) {
                            Text("Start")
                        }
                        
                    }
                }
                
                if isExpanded {
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack {
                            ForEach(laps.indices, id: \.self) { index in
                                LapView(lap: laps[index])
                            }
                        }
                    }
                }
            }
        }.padding(10).frame(height: isExpanded ? 300 : 150)
    }
}
