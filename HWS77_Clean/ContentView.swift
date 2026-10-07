//
//  ContentView.swift
//  Day77_challenge
//
//  Created by Onur Ay on 06.10.26.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State private var viewModel = ViewModel()

    
    var body: some View {
       
        NavigationStack {
            
            List {
                ForEach(viewModel.people) { person in
                
                    NavigationLink(value: person) {
                        HStack {
                            if let firstImage = person.images.first {
                                Image(uiImage: firstImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            } else {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                            
                            Text(person.name)
                            
                        }
                    }
                    
                }
            }
            .navigationDestination(for: Person.self) { selectedPerson in
                DetailView(person: selectedPerson)
            }
            .sheet(item: $viewModel.draftPerson) { unwrappedDraft in
                NameSheetView(person: unwrappedDraft) { finishedPerson in
                    
                    // This runs when they tap "Save" in the sheet
                    viewModel.addPerson(person: finishedPerson)
                    
                }
            }
            .toolbar {
                HStack {
                    Button {
                        viewModel.people.sort()
                    } label: {
                        Image(systemName: "arrow.up.and.down.text.horizontal")
                    }
                    
                    Button("Select Photos") {
                        
                        viewModel.showPhotosPicker = true
                        
                    }.photosPicker(isPresented: $viewModel.showPhotosPicker, selection: $viewModel.selectedItems, matching: .images)
                        .onChange(of: viewModel.selectedItems, viewModel.loadImages)
                    
                }
            }
            .navigationTitle("People I have Met")
            
            
            
            
            
        }
        
        
        
        
        
        
    }
}

#Preview {
    ContentView()
}
