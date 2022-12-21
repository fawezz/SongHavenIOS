//
//  MapView.swift
//  songHaven-IOS
//
//  Created by SongH on 21/12/2022.
//

import SwiftUI
import _MapKit_SwiftUI
import NavigationStack

struct MapView: View {
    @State private var search : String = ""
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D (latitude: 40, longitude: 120), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
    var body: some View {
        ZStack {
            VStack {
                BackButton(action: {navigationStack.pop()})
                Map(coordinateRegion : $region , showsUserLocation: true)
                    .ignoresSafeArea()
                    .tint(.purple)
                
            }


        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
