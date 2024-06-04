import SwiftUI

struct CountdownCard: View {
    let movie: Movie
    let releaseDate: Date

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let url = movie.posterURL {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 150)
                            .cornerRadius(13)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Color.gray
                        .frame(width: 100, height: 150)
                        .cornerRadius(13)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.title3)
                        .bold()

                    CountdownView(targetDate: releaseDate)

                    Text("Releasing \(releaseDate, formatter: DateFormatter.shortDate)")
                        .font(.subheadline)
                }
                .padding(.leading, 10)
            }
        }
        .padding()
        .background(
            ZStack {
                VisualEffectBlur()
                Color.white.opacity(0.2)
            }
        )
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 13)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.salmonPink,
                            Color.darkBlue,
                            Color.lightBlue,
                            Color.pastelYellow,
                            Color.foregroundWhite
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 2
                )
        )
    }
}

struct CountdownView: View {
    let targetDate: Date
    @State private var timeRemaining: TimeInterval = 0

    private var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateTimeRemaining()
        }
    }

    var body: some View {
        HStack(spacing: 5) {
            countdownText("\(days)", label: "days")
            countdownText("\(hours)", label: "hours")
            countdownText("\(minutes)", label: "minutes")
        }
        .onAppear(perform: {
            self.updateTimeRemaining()
            _ = self.timer
        })
    }

    private func countdownText(_ time: String, label: String) -> some View {
        VStack {
            Text(time)
                .font(.largeTitle)
                .foregroundColor(.yellow)
                .overlay(
                    Text(time)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        
                )
                .overlay(
                    Text(time)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        
                )
            Text(label)
                .font(.caption)

                .overlay(
                    Text(label)
                        .font(.caption)
                        .foregroundColor(.black)
                )
        }
    }

    private var days: Int {
        Int(timeRemaining) / (3600 * 24)
    }

    private var hours: Int {
        (Int(timeRemaining) % (3600 * 24)) / 3600
    }

    private var minutes: Int {
        (Int(timeRemaining) % 3600) / 60
    }

    private func updateTimeRemaining() {
        let now = Date()
        timeRemaining = max(targetDate.timeIntervalSince(now), 0)
    }
}

extension DateFormatter {
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}
