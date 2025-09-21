import SwiftUI

struct LearningObjective: View {
    let title: String
    let content: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "target")
                .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                .font(.system(size: 12))
                .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.custom("Courier", size: 13))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.9, green: 0.8, blue: 0.6))
                    .tracking(1)
                
                Text(content)
                    .font(.custom("Courier", size: 12))
                    .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                    .lineSpacing(3)
            }
        }
    }
}

