//
//  CoreDataManager.swift
//  EventsApp
//
//  Created by Jonathan Go on 16.02.22.
//

import CoreData
import UIKit

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "EventsApp")
        persistentContainer.loadPersistentStores { _, error in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func get<T: NSManagedObject>(_ id: NSManagedObjectID) -> T? {
        do {
            return try moc.existingObject(with: id) as? T
        } catch {
            print(error)
        }
        return nil
    }
    
    func getAll<T: NSManagedObject>() -> [T] {
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
//            let backgroundContext = persistentContainer.newBackgroundContext()
//            backgroundContext.perform {
//                <#code#>
//            }
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return []
        }
    }
    
    
    func save() {
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
}
