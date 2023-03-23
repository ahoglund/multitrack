import SwiftUI

struct ContentView: View {
    @State private var stopwatches: [Stopwatch] = []
    
    var body: some View {
        VStack {
            HStack {
                Text("MULTITRACK")
                    .padding()
                Button(action: {
                    let newStopwatch = Stopwatch()
                    stopwatches.append(newStopwatch)
                }) {
                    Text("Add Stopwatch")
                }
                .disabled(stopwatches.count > 3)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            
            // Body
            ScrollView {
                ForEach(stopwatches.indices, id: \.self) { index in
                    StopwatchView(stopwatch: stopwatches[index])
                }
            }
            
            HStack {
                if stopwatches.count > 0 {
                    Button(action: {
                        stopwatches.forEach { $0.start() }
                    }) {
                        Text("Start All")
                    }
                    .padding()
                    
                    Button(action: {
                        stopwatches.forEach { $0.stop() }
                    }) {
                        Text("Stop All")
                    }
                    .padding()
                    
                    Button(action: {
                        stopwatches.forEach { $0.reset() }
                    }) {
                        Text("Reset All")
                    }
                    .padding()
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
