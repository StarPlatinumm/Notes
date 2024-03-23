//
//  DetailedView.swift
//  Notes Watch App
//
//  Created by Артем Кривдин on 23.03.2024.
//

import SwiftUI

struct DetailView: View {
    
    let note: Note
    let count: Int
    let index: Int
    
    @State private var isCreditsPresented: Bool = false
    @State private var isSettingsPresented: Bool = false
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 3) {
            // HEADER
            HeaderView()
            
            // CONTENT
            Spacer()
            
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            
            // FOOTER
            Spacer()
            
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .onTapGesture { isSettingsPresented.toggle() }
                    .sheet(isPresented: $isSettingsPresented, content: {
                        SettingsView()
                    })
                
                Spacer()
                
                Text("\(count) / \(index + 1)")
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture { isCreditsPresented.toggle() }
                    .sheet(isPresented: $isCreditsPresented, content: {
                        CreditsView()
                    })
            }
            .foregroundColor(.secondary)
            
        }
        .padding(3)
    }
}

#Preview {
    let note = Note(id: UUID(), text: "Hello")
    return DetailView(note: note, count: 5, index: 2)
}
