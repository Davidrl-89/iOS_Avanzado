//
//  CDLocations+CoreDataProperties.swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 21/2/23.
//

import Foundation
import CoreData

extension CDLocations {
    
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CDLocations> {
        return NSFetchRequest<CDLocations>(entityName: "CDLocations")
    }
    
    @NSManaged public var id: String
    @NSManaged public var latitud: String
    @NSManaged public var longitud: String
    @NSManaged public var dateShow: String
    @NSManaged public var hero: CDHero
    
}

extension CDLocations : Identifiable {
    
}
