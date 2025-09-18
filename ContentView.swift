import SwiftUI

struct ContentView: View {
    @State private var showTitle = false
    @State private var showSubtitle = false
    @State private var showButtons = false
    @State private var typewriterText = ""
    
    private let subtitle = "Havana, 1962. The world stands on the brink of nuclear war."
    private let mission = "Your cover: American journalist. Your mission: Learn Spanish fast enough to survive."
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.08, blue: 0.06),  // Dark brown
                    Color(red: 0.15, green: 0.12, blue: 0.08), // Slightly lighter
                    Color(red: 0.08, green: 0.06, blue: 0.04)  // Very dark
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Subtle noise overlay for vintage feel
            Rectangle()
                .fill(Color.black.opacity(0.1))
                .ignoresSafeArea()
                .blendMode(.overlay)
            
            VStack(spacing: 40) {
                Spacer()
                
                // Main Title
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
                
                // Subtitle with typewriter effect
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
                
                // Action Buttons
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
                            .background(
                                Color(red: 0.9, green: 0.8, blue: 0.6)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color(red: 0.7, green: 0.6, blue: 0.4), lineWidth: 2)
                            )
                        }
                        .buttonStyle(SpyButtonStyle())
                        
                        Button(action: {
                            // Show instructions
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
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
                Spacer()
            }
            .padding()
        }
        .onAppear {
            startIntroSequence()
        }
    }
    
    private func startIntroSequence() {
        // Show title first
        withAnimation(.easeInOut(duration: 1.5)) {
            showTitle = true
        }
        
        // Then show subtitle with typewriter effect
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeInOut(duration: 0.5)) {
                showSubtitle = true
            }
            startTypewriterEffect()
        }
        
        // Finally show buttons
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            withAnimation(.easeInOut(duration: 0.8)) {
                showButtons = true
            }
        }
    }
    
    private func startTypewriterEffect() {
        let fullText = subtitle + "\n\n" + mission
        typewriterText = ""
        
        for (index, character) in fullText.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                typewriterText.append(character)
            }
        }
    }
}

// Custom button style for spy theme
struct SpyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
