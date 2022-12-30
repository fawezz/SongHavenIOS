//
//  MapView.swift
//  songHaven-IOS
//
//  Created by SongH on 21/12/2022.
//

import SwiftUI
import MapKit
import NavigationStack

struct MapView: View {
    @StateObject var viewModel  = CreateEventViewModel()
    
    @StateObject var viewModelMAP  = MapViewModel()
    @StateObject private var languageService = LocalizationService.shared
    @State private var search : String = ""
    
    
    @EnvironmentObject private var navigationStack: NavigationStackCompat
   
    @State private var locations = [Location]()
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .top) {
                //   BackButton(action: {navigationStack.pop()})
                Map(coordinateRegion : $viewModelMAP.region , showsUserLocation: true , annotationItems: locations){
                    location  in MapMarker (coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longtude))
                }
                .ignoresSafeArea()
                .accentColor(Color(.systemPink))
                .onAppear{
                    viewModelMAP.checkLocationAuthorization()             }
                Circle ()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                VStack {
                    HStack{
        
                        Button{
                            
                            let newLocation = Location(id: UUID(), name: "New Location", description: "Coordinates", latitude: viewModelMAP.region.center.latitude, longtude: viewModelMAP.region.center.longitude)
                            
                            locations.append(newLocation)
                            
                          
                            print("latitude")
                            print($viewModelMAP.region.center.latitude)
                            print("longitude")
                            print($viewModelMAP.region.center.longitude)
       
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
                VStack{
                    
                    
                    HStack {
                        Button(action: {
                            print("search pressed")
                            
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.purple)
                        }
                        
                        TextField("search",text: $search)
                        
                                                .foregroundColor(.main_color.opacity(0.8))
                                            if(search.isEmpty){
                                                Button(action: {
                                                    print("clear pressed")
                                                   search = ""
                                                }) {
                                                    Text("Clear".localized(languageService.language))
                                                        .foregroundColor(.main_color.opacity(0.5))
                                                }
                                            }
                    }
                    .foregroundColor(.gray)
                    .padding(.all, 13)
                    .background(
                        .regularMaterial,
                        in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                    )
                }
                .frame(height: 40)
                .cornerRadius(13)
                .padding()
            }
        }
            }
            
        }



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
