import SwiftUI

// Operation Briefing Screen (overall game briefing)
struct OperationBriefingView: View {
    @Binding var showOperationBriefing: Bool
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
                            
                            Text("OPERATION BRIEFING")
                                .font(.custom("Courier", size: 28))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.9, green: 0.8, blue: 0.6))
                                .tracking(6)
                        }
                        .padding(.top, 40)
                        
                        VStack(alignment: .leading, spacing: 25) {
                            BriefingSection(
                                title: "YOUR IDENTITY:",
                                content: "You're a CIA agent working undercover as a US journalist. Your real mission is intelligence gathering, but your cover story must be maintained at all costs."
                            )
                            
                            BriefingSection(
                                title: "OPERATION OBJECTIVE:",
                                content: "Infiltrate Cuban society and gather intelligence. Your Spanish skills determine operation success across multiple missions."
                            )
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text("THE RISK METER:")
                                    .font(.custom("Courier", size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                                    .tracking(2)
                                
                                Text("Every interaction affects your cover. Wrong answers raise suspicion. If the meter hits maximum, your cover is blown and the operation fails.")
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
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text("MISSION STRUCTURE:")
                                    .font(.custom("Courier", size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                                    .tracking(2)
                                
                                Text("Every mission begins with an official briefing, followed by a flashback to your CIA training at The Farm, before you face the live operation. Study the files, remember your drills, and then survive the field test.")
                                    .font(.custom("Courier", size: 14))
                                    .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                                    .lineSpacing(4)
                                
                                // Three-phase breakdown
                                VStack(alignment: .leading, spacing: 12) {
                                    ThreePhaseItem(
                                        number: "1",
                                        title: "MISSION BRIEFING",
                                        description: "Intelligence dossier with scenario details and Spanish learning objectives"
                                    )
                                    
                                    ThreePhaseItem(
                                        number: "2",
                                        title: "RECALL SEQUENCE (THE FARM)",
                                        description: "Flashback to CIA training - practice grammar and vocabulary in controlled environment"
                                    )
                                    
                                    ThreePhaseItem(
                                        number: "3",
                                        title: "LIVE MISSION DRILL",
                                        description: "Real-world application in Havana - your Spanish skills under pressure"
                                    )
                                }
                                .padding(.top, 10)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            BriefingSection(
                                title: "SEQUENTIAL OPERATIONS:",
                                content: "Operation Habla consists of 10 sequential missions. Each mission unlocks only after successful completion of the previous operation. Failure means starting the mission over."
                            )
                            
                            BriefingSection(
                                title: "REMEMBER:",
                                content: "You're not just learning Spanish - you're fighting for survival in the most dangerous place on Earth during the Cold War's tensest moment."
                            )
                        }
                        .padding(.horizontal, 30)
                        
                        Button(action: {
                            showOperationBriefing = false
                        }) {
                            HStack {
                                Image(systemName: "arrow.left")
                                Text("RETURN TO MAIN MENU")
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

struct ThreePhaseItem: View {
    let number: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(number)
                .font(.custom("Courier", size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                .frame(width: 20, height: 20)
                .overlay(
                    Circle()
                        .stroke(Color(red: 0.85, green: 0.2, blue: 0.2), lineWidth: 1)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.custom("Courier", size: 13))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.9, green: 0.8, blue: 0.6))
                    .tracking(1)
                
                Text(description)
                    .font(.custom("Courier", size: 12))
                    .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                    .lineSpacing(3)
            }
        }
    }
}
