//
//  MapViewModel.swift
//  songHaven-IOS
//
//  Created by SongH on 27/12/2022.
//

import Foundation
import MapKit
 

@MainActor class MapViewModel :  NSObject ,ObservableObject
,CLLocationManagerDelegate{
    
   @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D (latitude: 36.80278, longitude: 10.17972), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    var locationManager : CLLocationManager?
    
    
    func checkIfLocationServicesIsEnable(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            
        } else{
            print( "show an alert letting them know this is off and to go turn it on")
        }
    }
    func checkLocationAuthorization( ){
        guard let  locationManager = locationManager else{
            return}
        switch locationManager.authorizationStatus{
            
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            print("your location is restrected likely to parental controls")
        case .denied:
            print( "You have denied this app location permission. go into setting to chnge")
        case .authorizedAlways,.authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        @unknown default:
            break
        }
    }
   func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
