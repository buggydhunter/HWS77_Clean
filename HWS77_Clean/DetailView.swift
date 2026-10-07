//
//  NameView.swift
//  Day77_challenge
//
//  Created by Onur Ay on 06.10.26.
//

import Foundation
import SwiftUI
import MapKit

struct DetailView : View {
    
    let person: Person // these do not change here and not for this app right?
    
    
    
    var body: some View {
        
        VStack {
            
            Text(person.name)
                .font(.title2)
            
            ForEach(person.images, id: \.self) { image in
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            
            let startPositon = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: person.latitude ?? 25, longitude: person.longitute ?? 25), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)))
            
            ZStack {
                MapReader { MapProxy in
                    Map(initialPosition: startPositon) {
                        Annotation(person.name, coordinate:  CLLocationCoordinate2D(latitude: person.latitude ?? 25, longitude: person.longitute ?? 25)) {
                            Image(systemName: "mappin.and.ellipse.circle.fill")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                            
                        }
                    }
                }
                .frame(width: 250, height: 250)
                .clipShape(Circle())
                
            }
        }
        
    }
}
