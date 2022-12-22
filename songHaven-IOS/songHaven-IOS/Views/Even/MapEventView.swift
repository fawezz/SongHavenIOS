//
//  MapView.swift
//  songHaven-IOS
//
//  Created by SongH on 21/12/2022.
//

import SwiftUI
import _MapKit_SwiftUI
import NavigationStack

struct MapEventView: View {
    @State private var search : String = ""
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D (latitude: 40, longitude: 120), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
    @State private var locations = [Location]()
    var body: some View {
        ZStack {
         
             //   BackButton(action: {navigationStack.pop()})
            Map(coordinateRegion : $region , showsUserLocation: true , annotationItems: locations){
                location  in MapMarker (coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longtude))
            }
                    .ignoresSafeArea()
                   Circle ()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
           VStack {
                Spacer()
               HStack{
                   Spacer()
                       Button{
                           let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: region.center.latitude, longtude: region.center.longitude)
                           
                           
                           
                           locations.append(newLocation)
                           print("latitude")
                           print(region.center.latitude)
                           print("longitude")
                           print(region.center.longitude)
                       }label : {
                           Image( systemName: "plus")
                   }
                       .padding()
                       .background(.black.opacity(0.75))
                       .foregroundColor(.white)
                       .font(.title)
                       .clipShape(Circle())
                       .padding(.trailing)
               }
            }
               


        }  .padding(.all)
      
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapEventView()
    }
}
