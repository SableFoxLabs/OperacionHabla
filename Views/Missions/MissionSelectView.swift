import SwiftUI

// Mission Selection Screen
struct MissionSelectView: View {
    @Binding var showMissionSelect: Bool
    @State private var showContent = false
    @State private var selectedMission: Int? = nil
    @State private var showMissionBriefing = false
    
    let missions = [
        ("Arrival at Customs", "Navigate airport security with your cover story", true),
        ("Hotel Registration", "Check into your hotel without raising suspicion", false),
        ("Street Conversations", "Blend in with locals and gather information", false),
        ("Restaurant Encounter", "Order food and overhear important conversations", false),
        ("Press Conference", "Maintain your journalist cover at an official event", false),
        ("Market Investigation", "Investigate suspicious activities at the local market", false),
        ("Embassy Contact", "Make contact with your handler at the embassy", false),
        ("Document Exchange", "Secretly exchange classified documents", false),
        ("Escape Plan", "Prepare your extraction route from Cuba", false),
        ("Final Confrontation", "Complete your mission before time runs out", false)
    ]
    
    var body: some View {
        if showMissionBriefing, let mission = selectedMission {
            IndividualMissionBriefingView(
                showMissionBriefing: $showMissionBriefing,
                missionNumber: mission + 1,
                missionTitle: missions[mission].0,
                missionDescription: missions[mission].1
            )
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
                                Text("CLASSIFIED")
                                    .font(.custom("Courier", size: 14))
                                    .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                                    .tracking(4)
                                
                                Text("OPERATION HABLA")
                                    .font(.custom("Courier", size: 28))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 0.9, green: 0.8, blue: 0.6))
                                    .tracking(6)
                                
                                Text("MISSION SELECTION")
                                    .font(.custom("Courier", size: 16))
                                    .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                                    .tracking(3)
                            }
                            .padding(.top, 40)
                            
                            VStack(spacing: 15) {
                                ForEach(Array(missions.enumerated()), id: \.offset) { index, mission in
                                    MissionRowView(
                                        missionNumber: index + 1,
                                        title: mission.0,
                                        description: mission.1,
                                        isUnlocked: mission.2,
                                        onTap: {
                                            if mission.2 {
                                                selectedMission = index
                                                showMissionBriefing = true
                                            }
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                            
                            Button(action: {
                                showMissionSelect = false
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
}

struct MissionRowView: View {
    let missionNumber: Int
    let title: String
    let description: String
    let isUnlocked: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: {
            if isUnlocked {
                onTap()
            }
        }) {
            HStack(spacing: 15) {
                Text("\(missionNumber)")
                    .font(.custom("Courier", size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(isUnlocked ? Color(red: 0.85, green: 0.2, blue: 0.2) : Color.gray)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Circle()
                            .stroke(isUnlocked ? Color(red: 0.85, green: 0.2, blue: 0.2) : Color.gray, lineWidth: 2)
                    )
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("MISSION \(missionNumber): \(title.uppercased())")
                        .font(.custom("Courier", size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(isUnlocked ? Color(red: 0.9, green: 0.8, blue: 0.6) : Color.gray)
                        .tracking(1)
                    
                    Text(description)
                        .font(.custom("Courier", size: 12))
                        .foregroundColor(isUnlocked ? Color(red: 0.8, green: 0.7, blue: 0.5) : Color.gray.opacity(0.7))
                        .lineSpacing(3)
                }
                
                Spacer()
                
                if isUnlocked {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                } else {
                    Image(systemName: "lock.fill")
                        .foregroundColor(Color.gray)
                }
            }
            .padding(15)
            .background(isUnlocked ? Color.black.opacity(0.3) : Color.black.opacity(0.1))
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(isUnlocked ? Color(red: 0.7, green: 0.6, blue: 0.4) : Color.gray.opacity(0.5), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(!isUnlocked)
    }
}
