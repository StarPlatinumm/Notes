//
//  CreditsView.swift
//  Notes Watch App
//
//  Created by Артем Кривдин on 23.03.2024.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack(spacing: 3) {
            // PROFILE IMAGE
            
            
            // HEADER
            HeaderView(title: "Credits")
            
            // CONTENT
            Text("Artiom Krivdin")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            Text("Developer")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
        }
    }
}

#Preview {
    CreditsView()
}
