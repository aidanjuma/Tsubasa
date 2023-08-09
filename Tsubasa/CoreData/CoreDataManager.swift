//
//  CoreDataManager.swift
//  Tsubasa
//
//  Created by Aidan Juma on 09/08/2023.
//

import CoreData
import Foundation

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()

    lazy var airportContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AirportModel")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var airportViewContext: NSManagedObjectContext { return airportContainer.viewContext }
}
