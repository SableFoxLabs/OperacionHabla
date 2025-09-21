import SwiftUI

struct MissionOneBriefingView: View {
    @Binding var showMissionBriefing: Bool
    @State private var showContent = false
    @State private var showFarmTraining = false
    
    var body: some View {
        if showFarmTraining {
            // Placeholder for Farm Training View
            FarmTrainingView(showFarmTraining: $showFarmTraining)
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
                            // Header
                            VStack(spacing: 15) {
                                Text("CLASSIFIED - EYES ONLY")
                                    .font(.custom("Courier", size: 12))
                                    .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                                    .tracking(3)
                                
                                Text("MISSION 1 BRIEFING")
                                    .font(.custom("Courier", size: 24))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 0.9, green: 0.8, blue: 0.6))
                                    .tracking(4)
                                
                                Text("ARRIVAL AT CUSTOMS")
                                    .font(.custom("Courier", size: 16))
                                    .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                                    .tracking(2)
                                
                                Rectangle()
                                    .fill(Color(red: 0.7, green: 0.6, blue: 0.4))
                                    .frame(height: 1)
                                    .frame(maxWidth: 200)
                            }
                            .padding(.top, 40)
                            
                            VStack(alignment: .leading, spacing: 25) {
                                // Scenario
                                BriefingSection(
                                    title: "SCENARIO:",
                                    content: "You've just landed at José Martí Airport, Havana. The customs officer is approaching. Your cover story must be flawless - one wrong word could expose your mission before it begins."
                                )
                                
                                // Spanish Learning Objectives
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("SPANISH INTEL REQUIRED:")
                                        .font(.custom("Courier", size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                                        .tracking(2)
                                    
                                    VStack(alignment: .leading, spacing: 12) {
                                        LearningObjective(
                                            title: "ARTICLES",
                                            content: "Master el/la/un/una - your linguistic precision matters"
                                        )
                                        
                                        LearningObjective(
                                            title: "IDENTITY VOCABULARY",
                                            content: "Passport, visa, journalist - words that determine survival"
                                        )
                                        
                                        LearningObjective(
                                            title: "FORMAL ADDRESS",
                                            content: "Use 'usted' - disrespect could raise suspicion"
                                        )
                                        
                                        LearningObjective(
                                            title: "SURVIVAL PHRASES",
                                            content: "Emergency responses when conversation goes wrong"
                                        )
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                // Risk Assessment
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("THREAT ASSESSMENT:")
                                        .font(.custom("Courier", size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                                        .tracking(2)
                                    
                                    Text("Customs officers are trained to spot inconsistencies. Incorrect articles, hesitation, or claiming suspicious professions will increase your risk meter rapidly.")
                                        .font(.custom("Courier", size: 14))
                                        .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                                        .lineSpacing(4)
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("CURRENT MISSION RISK:")
                                            .font(.custom("Courier", size: 12))
                                            .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                                            .tracking(1)
                                        
                                        RiskMeterView(currentRisk: 0.2)
                                    }
                                    .padding(.top, 10)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                // Mission Objectives
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("MISSION OBJECTIVES:")
                                        .font(.custom("Courier", size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                                        .tracking(2)
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        ObjectiveItem(text: "Present documents using correct Spanish articles")
                                        ObjectiveItem(text: "Maintain journalist cover story")
                                        ObjectiveItem(text: "Answer questions with appropriate formality")
                                        ObjectiveItem(text: "Exit customs without raising suspicion")
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                // Intelligence Note
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                                        
                                        Text("INTELLIGENCE NOTE:")
                                            .font(.custom("Courier", size: 14))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                                            .tracking(1)
                                    }
                                    
                                    Text("Never claim to be 'soldado' (soldier) in 1962 Cuba. This profession will immediately blow your cover and end the mission.")
                                        .font(.custom("Courier", size: 13))
                                        .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                                        .lineSpacing(3)
                                }
                                .padding(15)
                                .background(Color.red.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(Color(red: 0.85, green: 0.2, blue: 0.2), lineWidth: 1)
                                )
                            }
                            .padding(.horizontal, 30)
                            
                            // Action Buttons
                            VStack(spacing: 15) {
                                Button(action: {
                                    showFarmTraining = true
                                }) {
                                    HStack {
                                        Image(systemName: "brain.head.profile")
                                        Text("PROCEED TO THE FARM")
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
                                
                                Button(action: {
                                    showMissionBriefing = false
                                }) {
                                    HStack {
                                        Image(systemName: "arrow.left")
                                        Text("RETURN TO MISSION SELECT")
                                    }
                                    .font(.custom("Courier", size: 14))
                                    .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                                    .frame(width: 280, height: 45)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 0)
                                            .stroke(Color(red: 0.8, green: 0.7, blue: 0.5), lineWidth: 1)
                                    )
                                }
                                .buttonStyle(SpyButtonStyle())
                            }
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
}
