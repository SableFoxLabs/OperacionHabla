import SwiftUI

struct BriefingSection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.custom("Courier", size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                .tracking(2)
            
            Text(content)
                .font(.custom("Courier", size: 14))
                .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.5))
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
