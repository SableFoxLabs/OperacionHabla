import SwiftUI

// Placeholder for Farm Training View
struct FarmTrainingView: View {
    @Binding var showFarmTraining: Bool
    
    var body: some View {
        ZStack {
            Color.black
            
            VStack {
                Text("THE FARM - TRAINING SEQUENCE")
                    .font(.custom("Courier", size: 24))
                    .foregroundColor(.white)
                
                Text("Coming Soon...")
                    .font(.custom("Courier", size: 16))
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                
                Button("Return to Briefing") {
                    showFarmTraining = false
                }
                .padding(.top, 40)
                .foregroundColor(.white)
            }
        }
        .ignoresSafeArea()
    }
}

