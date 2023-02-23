//
//   CDLocations+CoreDataClass..swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 21/2/23.
//

import Foundation
import CoreData

@objc(CDLocations)
public class CDLocations: NSManagedObject {

}

//MARK: - EXTENSION -
extension CDLocations {
    
    //MARK: FUNCON CREAR CDHERO
    static func create(from heroCoordenates: HeroCoordenates, for hero: CDHero ,context:NSManagedObjectContext) -> CDLocations {
        
        let cdLocations = CDLocations(context: context)
        cdLocations.id = heroCoordenates.id
        cdLocations.latitud = heroCoordenates.latitud
        cdLocations.longitud = heroCoordenates.longitud
        cdLocations.dateShow = heroCoordenates.dateShow
        cdLocations.hero = hero
        
        return cdLocations
    }
    
    var heroLocations: HeroCoordenates {
        HeroCoordenates(id: self.id,
                        latitud: self.latitud,
                        longitud: self.longitud,
                        dateShow: self.dateShow)
    }
}
