import SwiftUI

struct ObjectiveItem: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .font(.custom("Courier", size: 14))
                .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
            
            Text(text)
                .font(.custom("Courier", size: 13))
                .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                .lineSpacing(3)
        }
    }
}
