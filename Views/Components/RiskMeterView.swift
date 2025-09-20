import SwiftUI

struct RiskMeterView: View {
    let currentRisk: Double
    @State private var animatedRisk: Double = 0.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("SAFE")
                    .font(.custom("Courier", size: 10))
                    .foregroundColor(Color.green.opacity(0.8))
                Spacer()
                Text("SUSPICIOUS")
                    .font(.custom("Courier", size: 10))
                    .foregroundColor(Color.orange.opacity(0.8))
                Spacer()
                Text("BLOWN")
                    .font(.custom("Courier", size: 10))
                    .foregroundColor(Color.red.opacity(0.8))
            }
            .frame(width: 200)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.black.opacity(0.3))
                    .frame(height: 8)
                
                RoundedRectangle(cornerRadius: 2)
                    .fill(
                        LinearGradient(
                            colors: riskColors,
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: max(4, animatedRisk * 200), height: 8)
                    .animation(.easeInOut(duration: 1.5), value: animatedRisk)
            }
            .frame(width: 200)
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color(red: 0.7, green: 0.6, blue: 0.4), lineWidth: 1)
            )
            
            Text("\(Int(currentRisk * 100))% RISK")
                .font(.custom("Courier", size: 11))
                .foregroundColor(riskTextColor)
                .padding(.top, 4)
        }
        .padding(12)
        .background(Color.black.opacity(0.2))
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color(red: 0.6, green: 0.5, blue: 0.3), lineWidth: 1)
        )
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).delay(0.5)) {
                animatedRisk = currentRisk
            }
        }
    }
    
    private var riskColors: [Color] {
        [
            Color.green.opacity(0.8),
            Color.yellow.opacity(0.8),
            Color.orange.opacity(0.8),
            Color.red.opacity(0.9)
        ]
    }
    
    private var riskTextColor: Color {
        if currentRisk < 0.33 {
            return Color.green.opacity(0.8)
        } else if currentRisk < 0.66 {
            return Color.orange.opacity(0.8)
        } else {
            return Color.red.opacity(0.9)
        }
    }
}
