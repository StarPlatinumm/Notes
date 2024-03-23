//
//  HeaderView.swift
//  Notes Watch App
//
//  Created by Артем Кривдин on 23.03.2024.
//

import SwiftUI

struct HeaderView: View {
    
    var title: String = ""
    
    var body: some View {
        VStack {
            // TITLE
            if title != "" {
                Text(title.uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
            }
            
            // SEPARATOR
            HStack {
                Capsule()
                    .frame(height: 1)
                Image(systemName: "note.text")
                Capsule()
                    .frame(height: 1)
            }
            .foregroundColor(.accentColor)
        }
    }
}

#Preview {
    HeaderView(title: "Title")
}
