import SwiftUI

struct ContentView: View {
    @State private var showTitle = false
    @State private var showSubtitle = false
    @State private var showButtons = false
    @State private var typewriterText = ""
    @State private var showOperationBriefing = false
    @State private var showMissionSelect = false
    
    private let subtitle = "Havana, 1962. The world stands on the brink of nuclear war."
    private let coverStory = "Your cover: American journalist."
    private let mission = "Your mission: Learn Spanish fast enough to survive."
    
    var body: some View {
        if showOperationBriefing {
            OperationBriefingView(showOperationBriefing: $showOperationBriefing)
        } else if showMissionSelect {
            MissionSelectView(showMissionSelect: $showMissionSelect)
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
                                showMissionSelect = true
                            }) {
                                HStack {
                                    Image(systemName: "play.fill")
                                    Text("BEGIN OPERATION")
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
                            
                            // START HERE indicator and Operation Briefing button
                            VStack(spacing: 8) {
                                HStack(spacing: 8) {
                                    Text("START HERE")
                                        .font(.custom("Courier", size: 12))
                                        .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                                        .tracking(2)
                                    
                                    Image(systemName: "arrow.down")
                                        .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                                        .font(.system(size: 12, weight: .bold))
                                }
                                
                                Button(action: {
                                    showOperationBriefing = true
                                }) {
                                    HStack {
                                        Image(systemName: "doc.text")
                                        Text("OPERATION BRIEFING")
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
        
        var currentIndex = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if currentIndex < fullText.count {
                let index = fullText.index(fullText.startIndex, offsetBy: currentIndex)
                typewriterText.append(fullText[index])
                currentIndex += 1
            } else {
                timer.invalidate()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
