import Foundation

class Stopwatch: ObservableObject, Identifiable {
    let id = UUID()
    
    let initialStopwatchTime = "00:00:00.00"
    @Published var displayTime: String
    @Published var laps: [Lap] = []
    private var timer: DispatchSourceTimer?
    private var startTime: DispatchTime?
    private var elapsedTime: TimeInterval = 0

    init() {
        displayTime = initialStopwatchTime
    }
    
    func start() {
        let queue = DispatchQueue(label: "StopwatchQueue")
        timer = DispatchSource.makeTimerSource(queue: queue)

        timer?.schedule(deadline: .now(), repeating: .milliseconds(100))

        startTime = .now()

        timer?.setEventHandler { [weak self] in
            guard let self = self, let startTime = self.startTime else { return }
            let currentTime = DispatchTime.now()
            let interval = currentTime.uptimeNanoseconds - startTime.uptimeNanoseconds
            let elapsed = TimeInterval(Double(interval) / 1_000_000_000) + self.elapsedTime
            let newDisplayTime = self.timeString(from: elapsed)

            DispatchQueue.main.async {
                self.displayTime = newDisplayTime
            }
        }


        timer?.resume()
    }
    
    func started() -> Bool {
        if timer == nil {
            return false
        } else {
            return true
        }
    }

    func stop() {
        elapsedTime += Double(DispatchTime.now().uptimeNanoseconds - (startTime?.uptimeNanoseconds ?? 0)) / 1_000_000_000
        timer?.cancel()
        timer = nil
        startTime = nil
    }

    func reset() {
        stop()
        elapsedTime = 0
        displayTime = initialStopwatchTime
    }

    func addLap() {
        let lap = Lap(number: laps.count + 1, displayTime: displayTime)
        self.laps.append(lap)
    }

    private func timeString(from interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = Int(interval) / 60 % 60
        let seconds = Int(interval) % 60
        let milliseconds = Int(interval * 100) % 100

        return String(format: "%02d:%02d:%02d.%02d", hours, minutes, seconds, milliseconds)
    }
}
