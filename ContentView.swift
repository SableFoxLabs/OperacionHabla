import SwiftUI

struct ContentView: View {
    @State private var showTitle = false
    @State private var showSubtitle = false
    @State private var showButtons = false
    @State private var typewriterText = ""
    @State private var showMissionBriefing = false
    
    private let subtitle = "Havana, 1962. The world stands on the brink of nuclear war."
    private let coverStory = "Your cover: American journalist."
    private let mission = "Your mission: Learn Spanish fast enough to survive."
    
    var body: some View {
        if showMissionBriefing {
            MissionBriefingView(showMissionBriefing: $showMissionBriefing)
        } else {
            ZStack {
                // Background
                LinearGradient(
                    colors: [
                        Color(red: 0.1, green: 0.08, blue: 0.06),
                        Color(red: 0.15, green: 0.12, blue: 0.08),
                        Color(red: 0.08, green: 0.06, blue: 0.04)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                    .ignoresSafeArea()
                    .blendMode(.overlay)
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    if showTitle {
                        VStack(spacing: 10) {
                            Text("OPERACIÓN")
                                .font(.custom("Courier", size: 36))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.9, green: 0.8, blue: 0.6))
                                .tracking(8)
                            
                            Text("HABLA")
                                .font(.custom("Courier", size: 48))
                                .fontWeight(.heavy)
                                .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                                .tracking(10)
                        }
                        .transition(.opacity.combined(with: .scale))
                    }
                    
                    if showSubtitle {
                        VStack(spacing: 20) {
                            Text(typewriterText)
                                .font(.custom("Courier", size: 16))
                                .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                                .frame(maxWidth: 300)
                        }
                        .transition(.opacity)
                    }
                    
                    Spacer()
                    
                    if showButtons {
                        VStack(spacing: 20) {
                            Button(action: {
                                // Navigate to game
                            }) {
                                HStack {
                                    Image(systemName: "play.fill")
                                    Text("BEGIN MISSION")
                                        .fontWeight(.semibold)
                                }
                                .font(.custom("Courier", size: 18))
                                .foregroundColor(.black)
                                .frame(width: 250, height: 50)
                                .background(Color(red: 0.9, green: 0.8, blue: 0.6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(Color(red: 0.7, green: 0.6, blue: 0.4), lineWidth: 2)
                                )
                            }
                            .buttonStyle(SpyButtonStyle())
                            
                            Button(action: {
                                showMissionBriefing = true
                            }) {
                                HStack {
                                    Image(systemName: "doc.text")
                                    Text("MISSION BRIEFING")
                                }
                                .font(.custom("Courier", size: 16))
                                .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                                .frame(width: 250, height: 45)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(Color(red: 0.8, green: 0.7, blue: 0.5), lineWidth: 1)
                                )
                            }
                            .buttonStyle(SpyButtonStyle())
                        }
                        .transition(.opacity.animation(.easeInOut(duration: 1.2)))
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .onAppear {
                startIntroSequence()
            }
        }
    }
    
    private func startIntroSequence() {
        withAnimation(.easeInOut(duration: 1.5)) {
            showTitle = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeInOut(duration: 0.5)) {
                showSubtitle = true
            }
            startTypewriterEffect()
        }
        
        let fullText = subtitle + "\n\n" + coverStory + "\n\n" + mission
        let textDuration = Double(fullText.count) * 0.05
        let buttonDelay = 2.0 + textDuration + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + buttonDelay) {
            withAnimation(.easeInOut(duration: 1.2)) {
                showButtons = true
            }
        }
    }
    
    private func startTypewriterEffect() {
        let fullText = subtitle + "\n\n" + coverStory + "\n\n" + mission
        typewriterText = ""
        
        for (index, character) in fullText.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                typewriterText.append(character)
            }
        }
    }
}

struct MissionBriefingView: View {
    @Binding var showMissionBriefing: Bool
    @State private var showContent = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.08, blue: 0.06),
                    Color(red: 0.15, green: 0.12, blue: 0.08),
                    Color(red: 0.08, green: 0.06, blue: 0.04)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            Rectangle()
                .fill(Color.black.opacity(0.1))
                .ignoresSafeArea()
                .blendMode(.overlay)
            
            if showContent {
                ScrollView {
                    VStack(spacing: 30) {
                        VStack(spacing: 15) {
                            Text("CLASSIFIED")
                                .font(.custom("Courier", size: 14))
                                .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                                .tracking(4)
                            
                            Text("MISSION BRIEFING")
                                .font(.custom("Courier", size: 28))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.9, green: 0.8, blue: 0.6))
                                .tracking(6)
                        }
                        .padding(.top, 40)
                        
                        VStack(alignment: .leading, spacing: 25) {
                            BriefingSection(
                                title: "OBJECTIVE:",
                                content: "Infiltrate Cuban society and gather intelligence. Your Spanish skills determine mission success."
                            )
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text("THE RISK METER:")
                                    .font(.custom("Courier", size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                                    .tracking(2)
                                
                                Text("Every interaction affects your cover. Wrong answers raise suspicion. If the meter hits maximum, your cover is blown and the mission fails.")
                                    .font(.custom("Courier", size: 14))
                                    .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                                    .lineSpacing(4)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("CURRENT THREAT LEVEL:")
                                        .font(.custom("Courier", size: 12))
                                        .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                                        .tracking(1)
                                    
                                    RiskMeterView(currentRisk: 0.4)
                                }
                                .padding(.top, 10)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            BriefingSection(
                                title: "GAMEPLAY:",
                                content: "• Choose between SPEAKING or MULTIPLE CHOICE\n• Speaking is faster but riskier\n• Multiple choice is safer but slower\n• Complete scenarios to advance"
                            )
                            
                            BriefingSection(
                                title: "REMEMBER:",
                                content: "You're not just learning Spanish - you're fighting for survival in the most dangerous place on Earth during the Cold War's tensest moment."
                            )
                        }
                        .padding(.horizontal, 30)
                        
                        Button(action: {
                            showMissionBriefing = false
                        }) {
                            HStack {
                                Image(systemName: "arrow.left")
                                Text("RETURN TO MISSION SELECT")
                            }
                            .font(.custom("Courier", size: 16))
                            .foregroundColor(.black)
                            .frame(width: 280, height: 50)
                            .background(Color(red: 0.9, green: 0.8, blue: 0.6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color(red: 0.7, green: 0.6, blue: 0.4), lineWidth: 2)
                            )
                        }
                        .buttonStyle(SpyButtonStyle())
                        .padding(.top, 30)
                        
                        Spacer(minLength: 50)
                    }
                }
                .transition(.opacity.animation(.easeInOut(duration: 0.8)))
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                showContent = true
            }
        }
    }
}

struct BriefingSection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.custom("Courier", size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                .tracking(2)
            
            Text(content)
                .font(.custom("Courier", size: 14))
                .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

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
            
            Text("\(Int(currentRisk * 100))% RISK")
                .font(.custom("Courier", size: 11))
                .foregroundColor(riskTextColor)
                .padding(.top, 4)
        }
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

struct SpyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
