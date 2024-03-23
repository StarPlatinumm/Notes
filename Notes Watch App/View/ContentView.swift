//
//  ContentView.swift
//  Notes Watch App
//
//  Created by Артем Кривдин on 23.03.2024.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTY
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    @AppStorage("lineCount") var lineCount: Int = 1
    
    // MARK: - FUNCTIONS
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func save() {
        do {
            // 1. Conver the notes array to data using JSONEncoder
            let data = try JSONEncoder().encode(notes)
            
            // 2. Create a new URL to save the file using the getDocumentDirectory
            let url = getDocumentsDirectory().appendingPathComponent("notes")
            
            // 3. Write the data to the given URL
            try data.write(to: url)
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
                // 1. Get the notes URL path
                let url = getDocumentsDirectory().appendingPathComponent("notes")
                
                // 2. Create a new property for the data
                let data = try Data(contentsOf: url)
                
                // 3. Decode the data
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                // Do nothing
            }
        }
    }
    
    func add() {
        // 1. Only run the button's action when the text field is not empty
        if text.isEmpty { return }
        
        // 2. Create a new Note item and initialize with the text value
        let note = Note(id: UUID(), text: text)
        
        // 3. Add the new item to the notes array
        notes.append(note)
        
        // 4. Make the text field empty
        text = ""
        
        // 5. Save the notes
        save()
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .center, spacing: 6) {
                    TextField("Add new note", text: $text)
                    
                    Button { add() } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42, weight: .semibold))
                    }
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
                }
            } //: VSTACK
            .navigationTitle("Notes")
            .onAppear(perform: load)
            
            Spacer()
            
            if !notes.isEmpty {
                List {
                    ForEach(0..<notes.count, id: \.self) { i in
                        NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                            HStack {
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                Text(notes[i].text)
                                    .lineLimit(lineCount)
                                    .padding(.leading, 5)
                            }
                        }
                    }
                    .onDelete(perform: delete)
                }
            } else {
                Spacer()
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .padding(15)
                    .opacity(0.25)
                Spacer()
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    ContentView()
}
