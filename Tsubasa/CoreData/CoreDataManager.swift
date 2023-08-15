//
//  CoreDataManager.swift
//  Tsubasa
//
//  Created by Aidan Juma on 09/08/2023.
//

import ComposableArchitecture
import CoreData
import Foundation

class CoreDataManager: ObservableObject {
    var insertAirports: @Sendable ([Airport]) -> Void

    init(insertAirports: @Sendable @escaping ([Airport]) -> Void) {
        self.insertAirports = insertAirports
    }

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

extension CoreDataManager {
    private static var sharedAirportViewContext: NSManagedObjectContext {
        shared.airportContainer.viewContext
    }

    static func createSharedInstance() -> CoreDataManager {
        return CoreDataManager(
            insertAirports: { airports in
                let context = sharedAirportViewContext

                for airport in airports {
                    let entity = AirportInfo(context: context)
                    entity.id = airport.id
                    entity.iataCode = airport.iataCode
                    entity.icaoCode = airport.icaoCode
                    entity.name = airport.name
                    entity.city = airport.city
                    entity.country = airport.country
                    entity.elevation = airport.elevation
                    entity.latitude = airport.latitude
                    entity.longitude = airport.longitude
                    entity.timezone = airport.timezone
                }

                do {
                    try context.save()
                } catch {
                    fatalError("Error saving context: \(error)")
                }
            }
        )
    }

    static let shared = createSharedInstance()
}

private enum CoreDataManagerKey: DependencyKey {
    static let liveValue = CoreDataManager.shared
}

extension DependencyValues {
    var coreDataManager: CoreDataManager {
        get { self[CoreDataManagerKey.self] }
        set { self[CoreDataManagerKey.self] = newValue }
    }
}
