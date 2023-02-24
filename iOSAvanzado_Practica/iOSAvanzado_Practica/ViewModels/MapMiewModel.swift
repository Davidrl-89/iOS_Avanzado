//
//  MapMiewModel.swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 21/2/23.
//

import Foundation
import MapKit

final class MapMiewModel {
    
    let coreDataManager: CoreDataManager
    var locations: [CDLocations]
    var hero: [CDHero]
    
    init(
        coreDataManager: CoreDataManager = CoreDataManager(),
        locations: [CDLocations] = [],
        hero: [CDHero] = [])
    {
        self.coreDataManager = coreDataManager
        self.locations = locations
        self.hero = hero
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        }
    }
    
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            break
        default:
            break
        }
    }
    
    func getHeroesLocationCoreData(for heroId: String) {
        self.locations = self.coreDataManager.fetchLocations(for: heroId)
    }
    
    func getHeroesAnnotations(completion: (MKPointAnnotation) -> Void) {
        self.coreDataManager.fetchHeros().forEach { hero in
            getHeroesLocationCoreData(for: hero.id)
            let latitudReceived = locations.first?.latitud
            let longitudReceived = locations.first?.longitud
            guard let latitudVerify = latitudReceived, let longitudVerify = longitudReceived else { return }
            
            let latitud = Double(latitudVerify)
            let longitud = Double(longitudVerify)
            guard let latitud = latitud,
                  let longitud = longitud else { return }
            let annotations = MKPointAnnotation()
            annotations.title = hero.name
            annotations.coordinate = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
            
            completion(annotations)
        }
    }
}
