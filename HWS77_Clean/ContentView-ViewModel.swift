//
//  ContentView-ViewModel.swift
//  Day77_challenge
//
//  Created by Onur Ay on 06.10.26.
//

import Foundation
import PhotosUI
import SwiftUI
extension ContentView {
    
    @Observable
    class ViewModel {
        
        var people : [Person]
        var selectedItems = [PhotosPickerItem]()
        var showPhotosPicker: Bool = false
        var locationFetched: Bool = false
        var draftPerson: Person?
        
        let savePath = URL.documentsDirectory.appending(path: "KnownPeople")
        let locationFetcher = LocationFetcher()
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                people = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                people = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(people)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addPerson(person: Person) {
            // is this enough to add a person?
            people.append(person)
            save()
        }
        
        func loadImages() {
            Task {
                var newImages = [UIImage]()
                
                for item in selectedItems {
                    do {
                        if let imageData = try await item.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: imageData) {
                            newImages.append(uiImage)
                        }
                    } catch {
                        print("Failed to load an image: \(error.localizedDescription)")
                    }
                }
                
                // LOOP IS FINISHED. Now create ONE person and show the sheet.
                if newImages.isEmpty == false {
                    draftPerson = Person(id: UUID(), name: "", images: newImages)
                    addCoordinateToPerson()
                }
            }
        }
        // i should include a method to remove a person later on maybe -> needs to be something that works with ondelete hopefully or inside ondelete
        
        func addCoordinateToPerson() {
            
                if locationFetched {
                    draftPerson!.longitute = locationFetcher.lastKnownLocation?.longitude
                    draftPerson!.latitude = locationFetcher.lastKnownLocation?.latitude
                }
            
        }
    }

}
