import SwiftUI

// Individual Mission Briefing Screen (for specific missions)
struct IndividualMissionBriefingView: View {
    @Binding var showMissionBriefing: Bool
    let missionNumber: Int
    let missionTitle: String
    let missionDescription: String
    @State private var showContent = false
    @State private var startMission = false
    
    var body: some View {
        if startMission {
            Text("Game Scene Placeholder")
                .font(.title)
                .foregroundColor(.white)
        } else {
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
                                Text("MISSION \(missionNumber)")
                                    .font(.custom("Courier", size: 20))
                                    .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                                    .tracking(4)
                                
                                Text(missionTitle.uppercased())
                                    .font(.custom("Courier", size: 24))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 0.9, green: 0.8, blue: 0.6))
                                    .tracking(3)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.top, 40)
                            
                            VStack(alignment: .leading, spacing: 25) {
                                BriefingSection(
                                    title: "SITUATION:",
                                    content: missionDescription + " Your journalist cover must remain convincing while you navigate this scenario."
                                )
                                
                                if missionNumber == 1 {
                                    BriefingSection(
                                        title: "SPANISH FOCUS:",
                                        content: "• Basic greetings and introductions\n• Travel and immigration vocabulary\n• Formal vs informal speech (tú vs usted)\n• Purpose of visit expressions"
                                    )
                                    
                                    BriefingSection(
                                        title: "KEY PHRASES:",
                                        content: "• \"Soy periodista\" (I am a journalist)\n• \"Vengo por trabajo\" (I come for work)\n• \"¿Puedo pasar?\" (May I pass?)\n• \"Gracias por su tiempo\" (Thank you for your time)"
                                    )
                                }
                                
                                BriefingSection(
                                    title: "MISSION OBJECTIVES:",
                                    content: "• Maintain your cover story\n• Complete all scene interactions\n• Keep risk level below 80%\n• Gather intelligence when possible"
                                )
                            }
                            .padding(.horizontal, 30)
                            
                            VStack(spacing: 15) {
                                Button(action: {
                                    startMission = true
                                }) {
                                    HStack {
                                        Image(systemName: "play.fill")
                                        Text("START MISSION")
                                    }
                                    .font(.custom("Courier", size: 16))
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
                                    showMissionBriefing = false
                                }) {
                                    HStack {
                                        Image(systemName: "arrow.left")
                                        Text("BACK TO MISSION SELECT")
                                    }
                                    .font(.custom("Courier", size: 14))
                                    .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                                    .frame(width: 250, height: 45)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 0)
                                            .stroke(Color(red: 0.8, green: 0.7, blue: 0.5), lineWidth: 1)
                                    )
                                }
                                .buttonStyle(SpyButtonStyle())
                            }
                            .padding(.top, 20)
                            
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
}

