//
//  CDHero+CoreDataClass.swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 21/2/23.
//

import Foundation
import CoreData

@objc(CDHero)
public class CDHero: NSManagedObject {

    
}

//MARK: - EXTENSION -
extension CDHero {
    
    //MARK: FUNCON CREAR CDHERO
    static func create(from hero: Hero, context:NSManagedObjectContext) -> CDHero {
        
        let cdHero = CDHero(context: context)
        cdHero.id = hero.id
        cdHero.name = hero.name
        cdHero.favorite = hero.favorite
        cdHero.heroDescription = hero.description
        cdHero.photoUrl = hero.photo
        
        return cdHero
    }
    
    var hero: Hero {
        Hero(id: self.id,
             name: self.name,
             description: self.heroDescription,
             photo: self.photoUrl,
             favorite: self.favorite)
    }
}
