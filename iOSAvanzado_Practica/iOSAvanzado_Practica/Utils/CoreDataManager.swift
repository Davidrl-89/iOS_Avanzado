//
//  CoreDataManager.swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 21/2/23.
//

import Foundation
import CoreData

final class CoreDataManager {
    
  
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DBZ")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    
   
    static let shared = CoreDataManager()
    
  
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
   
    func saveContext() {
        context.saveContext()
    }
    
    
    func deleteAll() {
        saveContext()
    }
    

    func fetchHeros() -> [CDHero] {
        let request = CDHero.createFetchRequest()
        
        do {
            let result = try context.fetch(request)
            return result
        }catch {
            print("error getting heroes")
        }
        return []
    }
    
   
    func fetchHeros(id heroId: String) -> CDHero? {
        let request = CDHero.createFetchRequest()
        let predicate = NSPredicate(format: "id==%@", heroId)
        request.predicate = predicate
        request.fetchBatchSize = 1
        
        do {
            let result = try context.fetch(request)
            return result.first
        }catch {
            print("error getting heroes")
        }
        return nil
    }
    
   
    func fetchLocations(for heroId: String) -> [CDLocations] {
        let request = CDLocations.createFetchRequest()
      
        let predicate = NSPredicate(format: "hero.id == %@", heroId)
        request.predicate = predicate
    
        let sort = NSSortDescriptor(key: "dateShow", ascending: false, selector: #selector(NSString.localizedStandardCompare))
        request.sortDescriptors = [sort]
        
        do {
            let result = try context.fetch(request)
            return result
        }catch {
            print("error getting locations")
        }
        return []
    }
}




extension NSManagedObjectContext {
    func saveContext() {
        
        guard hasChanges else {return}
        do {
            try save()
        }catch {
            fatalError("Error: \(error.localizedDescription)")
        }
    }
}
