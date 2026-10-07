//
//  NameView.swift
//  Day77_challenge
//
//  Created by Onur Ay on 06.10.26.
//

import Foundation
import SwiftUI

struct DetailView : View {
    
    let person: Person // these do not change here and not for this app right?
    let locationFetcher = LocationFetcher()

    
    var body: some View {
        
        VStack {
            
            Text(person.name)
                .font(.title2)
            
                ForEach(person.images, id: \.self) { image in
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            
            Button("Start Tracking Location") {
                         locationFetcher.start()
                     }

                     Button("Read Location") {
                         if let location = locationFetcher.lastKnownLocation {
                             print("Your location is \(location)")
                         } else {
                             print("Your location is unknown")
                         }
                     }
                 }
        }
    
}
