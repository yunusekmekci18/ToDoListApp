//
//  ContentView.swift
//  ToDoListApp
//
//  Created by Yunus Emre Ekmekci on 22.01.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var oldItems = [String]()
    @State private var addItem = ""
    @State private var presentAlert = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            NavigationView {
                List {
                    Section {
                        ForEach(oldItems, id: \.self) { word in
                            Text(word)
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
                .toolbar {
                    EditButton()
                }
                .navigationTitle("To-Do List")
                .onSubmit(addNewItem)
            }
            Button("+") {
                presentAlert = true
            }
            .font(.system(.largeTitle))
            .frame(width: 77, height: 70)
            .foregroundColor(Color.white)
            .padding(.bottom, 7)
            .background(Color.blue)
            .cornerRadius(38.5)
            .padding()
            .shadow(color: Color.black.opacity(0.3),
                    radius: 3,
                    x: 3,
                    y: 3)
            .alert("Add New Item", isPresented: $presentAlert, actions: {
                        TextField ("Add new item", text: $addItem)
                
                        Button("Add", action: {
                            self.oldItems.append(addItem)
                            addItem = ""
                        })
                        Button("Cancel", role: .cancel, action: {})
                    }
            )
            .background(colorScheme == .dark ? Color.black : Color.white)
        }
    }
    
    func addNewItem() {
        let cevap = addItem.trimmingCharacters(in: .whitespacesAndNewlines)
        guard cevap.count > 0 else { return }
        
        oldItems.insert(cevap, at: 0)
    }
    
    func deleteItems(at offsets: IndexSet) {
            oldItems.remove(atOffsets: offsets)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
