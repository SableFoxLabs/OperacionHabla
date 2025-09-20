import SwiftUI

struct VisualNovelGameView: View {
    @State private var currentRisk: Double = 0.1
    @State private var gameState: GameState = .sceneIntro
    @State private var dialogueIndex = 0
    @State private var showChoices = false
    @State private var selectedChoice: String?
    
    enum GameState {
        case sceneIntro, dialogue, choices, result
    }
    
    var body: some View {
        ZStack {
            // Background Scene
            CustomsBackgroundView()
            
            // Character Layer
            CharacterLayer(gameState: gameState)
            
            // UI Overlay
            VStack {
                // Risk meter at top
                HStack {
                    Spacer()
                    RiskMeterView(currentRisk: currentRisk)
                        .padding(.trailing, 20)
                }
                .padding(.top, 50)
                
                Spacer()
                
                // Dialogue and choices at bottom
                if gameState == .dialogue || gameState == .choices {
                    DialogueSystem(
                        gameState: $gameState,
                        dialogueIndex: $dialogueIndex,
                        showChoices: $showChoices,
                        selectedChoice: $selectedChoice,
                        currentRisk: $currentRisk
                    )
                }
                
                if gameState == .sceneIntro {
                    IntroOverlay(gameState: $gameState)
                }
            }
        }
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct CustomsBackgroundView: View {
    var body: some View {
        ZStack {
            // Base background color
            LinearGradient(
                colors: [
                    Color(red: 0.2, green: 0.15, blue: 0.1),
                    Color(red: 0.15, green: 0.12, blue: 0.08),
                    Color(red: 0.1, green: 0.08, blue: 0.06)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            
            // Simulated airport scene with shapes
            VStack {
                Spacer()
                
                // Customs desk
                Rectangle()
                    .fill(Color(red: 0.4, green: 0.3, blue: 0.2))
                    .frame(height: 120)
                    .overlay(
                        Rectangle()
                            .fill(Color(red: 0.3, green: 0.2, blue: 0.15))
                            .frame(height: 20)
                            .offset(y: -50)
                    )
                
                // Floor
                Rectangle()
                    .fill(Color(red: 0.25, green: 0.2, blue: 0.15))
                    .frame(height: 100)
            }
            
            // Atmospheric elements
            VStack {
                HStack {
                    Spacer()
                    // Cuban flag colors as wall elements
                    Rectangle()
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 30, height: 200)
                    Rectangle()
                        .fill(Color.red.opacity(0.3))
                        .frame(width: 30, height: 200)
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 100)
            
            // Vintage film grain effect
            Rectangle()
                .fill(Color.black.opacity(0.15))
                .blendMode(.overlay)
        }
    }
}

struct CharacterLayer: View {
    let gameState: VisualNovelGameView.GameState
    
    var body: some View {
        ZStack {
            // Customs Officer (right side)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    CustomsOfficerView()
                        .padding(.trailing, 40)
                        .padding(.bottom, 120)
                }
            }
            
            // Player character silhouette (left side, subtle)
            if gameState != .sceneIntro {
                VStack {
                    Spacer()
                    HStack {
                        PlayerSilhouetteView()
                            .padding(.leading, 40)
                            .padding(.bottom, 120)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct CustomsOfficerView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Officer "portrait" using shapes
            ZStack {
                // Head
                Circle()
                    .fill(Color(red: 0.8, green: 0.6, blue: 0.4))
                    .frame(width: 80, height: 80)
                
                // Hat
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(red: 0.2, green: 0.3, blue: 0.2))
                    .frame(width: 90, height: 30)
                    .offset(y: -30)
                
                // Badge/emblem on hat
                Circle()
                    .fill(Color.yellow.opacity(0.8))
                    .frame(width: 12, height: 12)
                    .offset(y: -30)
                
                // Uniform collar
                Rectangle()
                    .fill(Color(red: 0.3, green: 0.4, blue: 0.3))
                    .frame(width: 100, height: 40)
                    .offset(y: 20)
            }
            .frame(width: 120, height: 140)
        }
    }
}

struct PlayerSilhouetteView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Player silhouette - more subtle
            ZStack {
                // Head
                Circle()
                    .fill(Color.black.opacity(0.4))
                    .frame(width: 60, height: 60)
                
                // Shoulders
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black.opacity(0.4))
                    .frame(width: 80, height: 30)
                    .offset(y: 20)
            }
            .frame(width: 100, height: 100)
        }
    }
}

struct DialogueSystem: View {
    @Binding var gameState: VisualNovelGameView.GameState
    @Binding var dialogueIndex: Int
    @Binding var showChoices: Bool
    @Binding var selectedChoice: String?
    @Binding var currentRisk: Double
    
    let dialogues = [
        "You approach the customs desk with your press credentials ready...",
        "OFICIAL DE ADUANAS: \"¿Cuál es el propósito de su visita a Cuba?\"",
        "(What is the purpose of your visit to Cuba?)"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Dialogue box
            if gameState == .dialogue {
                DialogueBox(
                    speaker: dialogueIndex == 1 ? "CUSTOMS OFFICER" : nil,
                    text: dialogues[min(dialogueIndex, dialogues.count - 1)],
                    onTap: {
                        if dialogueIndex < dialogues.count - 1 {
                            dialogueIndex += 1
                        } else {
                            gameState = .choices
                        }
                    }
                )
            }
            
            // Choice selection
            if gameState == .choices {
                ChoiceBox(
                    selectedChoice: $selectedChoice,
                    onSubmit: {
                        processChoice()
                    }
                )
            }
        }
    }
    
    private func processChoice() {
        // Calculate risk based on choice
        let riskValues: [String: Double] = [
            "journalist": 0.1,
            "tourist": 0.3,
            "family": 0.2,
            "business": 0.4
        ]
        
        if let choice = selectedChoice,
           let risk = riskValues[choice] {
            withAnimation(.easeInOut(duration: 1.0)) {
                currentRisk = min(1.0, currentRisk + risk)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            gameState = .result
        }
    }
}

struct DialogueBox: View {
    let speaker: String?
    let text: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 10) {
                if let speaker = speaker {
                    Text(speaker)
                        .font(.custom("Courier", size: 12))
                        .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                        .tracking(2)
                }
                
                Text(text)
                    .font(.custom("Courier", size: 14))
                    .foregroundColor(Color(red: 0.9, green: 0.8, blue: 0.6))
                    .lineSpacing(4)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Spacer()
                    Text("▶ TAP TO CONTINUE")
                        .font(.custom("Courier", size: 10))
                        .foregroundColor(Color(red: 0.6, green: 0.5, blue: 0.4))
                        .opacity(0.7)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(
                Color.black.opacity(0.8)
                    .blur(radius: 0.5)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color(red: 0.7, green: 0.6, blue: 0.4), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 20)
        .padding(.bottom, 30)
    }
}

struct ChoiceBox: View {
    @Binding var selectedChoice: String?
    let onSubmit: () -> Void
    
    let choices = [
        ("journalist", "Vengo como periodista para escribir artículos", "I come as a journalist to write articles"),
        ("tourist", "Soy turista aquí para las vacaciones", "I'm a tourist here for vacation"),
        ("family", "Estoy visitando familia", "I'm visiting family"),
        ("business", "Vine para negocios importantes", "I came for important business")
    ]
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Choose your response:")
                .font(.custom("Courier", size: 12))
                .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                .padding(.bottom, 10)
            
            ForEach(choices, id: \.0) { choice in
                Button(action: {
                    selectedChoice = choice.0
                }) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(choice.1)
                            .font(.custom("Courier", size: 13))
                            .foregroundColor(selectedChoice == choice.0 ? .black : Color(red: 0.9, green: 0.8, blue: 0.6))
                        
                        Text(choice.2)
                            .font(.custom("Courier", size: 10))
                            .foregroundColor(selectedChoice == choice.0 ? Color.black.opacity(0.7) : Color(red: 0.6, green: 0.5, blue: 0.4))
                            .italic()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(12)
                    .background(selectedChoice == choice.0 ? Color(red: 0.9, green: 0.8, blue: 0.6) : Color.black.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color(red: 0.7, green: 0.6, blue: 0.4), lineWidth: 1)
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            if selectedChoice != nil {
                Button(action: onSubmit) {
                    Text("SUBMIT ANSWER")
                        .font(.custom("Courier", size: 14))
                        .foregroundColor(.black)
                        .frame(width: 200, height: 40)
                        .background(Color(red: 0.9, green: 0.8, blue: 0.6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color(red: 0.7, green: 0.6, blue: 0.4), lineWidth: 2)
                        )
                }
                .buttonStyle(SpyButtonStyle())
                .padding(.top, 10)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 30)
    }
}

struct IntroOverlay: View {
    @Binding var gameState: VisualNovelGameView.GameState
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 15) {
                Text("MISSION: CUSTOMS")
                    .font(.custom("Courier", size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                    .tracking(4)
                
                Text("José Martí Airport - Havana, Cuba")
                    .font(.custom("Courier", size: 14))
                    .foregroundColor(Color(red: 0.9, green: 0.8, blue: 0.6))
                
                Text("October 1962")
                    .font(.custom("Courier", size: 12))
                    .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
            }
            .padding(30)
            .background(Color.black.opacity(0.8))
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color(red: 0.7, green: 0.6, blue: 0.4), lineWidth: 2)
            )
            
            Button(action: {
                gameState = .dialogue
            }) {
                Text("BEGIN SCENE")
                    .font(.custom("Courier", size: 16))
                    .foregroundColor(.black)
                    .frame(width: 200, height: 50)
                    .background(Color(red: 0.9, green: 0.8, blue: 0.6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color(red: 0.7, green: 0.6, blue: 0.4), lineWidth: 2)
                    )
            }
            .buttonStyle(SpyButtonStyle())
        }
        .padding(.bottom, 100)
    }
}//
//  Untitled.swift
//  OperacionHabla
//
//  Created by AJ Whitsell on 9/20/25.
//

