//
//  extension+Mapview.swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 21/2/23.
//

import Foundation
import MapKit

extension MKMapView {
    func centerLocation(location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        self.setRegion(coordinateRegion, animated: true)
    }
    
}
