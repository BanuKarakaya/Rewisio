import CoreData

public final class CoreDataStack {

    @MainActor public static let shared = CoreDataStack()

    public let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(
            name: "ArticlesDemo",
            managedObjectModel: {
                let bundle = Bundle.module
                let url = bundle.url(forResource: "ArticlesDemo", withExtension: "momd")!
                return NSManagedObjectModel(contentsOf: url)!
            }()
        )

        let storeURL = FileManager.default
            .containerURL(
                forSecurityApplicationGroupIdentifier:
                    "group.com.banu.rewisio"
            )!
            .appendingPathComponent("shared.sqlite")
        
        let description = NSPersistentStoreDescription(url: storeURL)
        
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        
        description.setOption(true as NSNumber,
                              forKey: NSPersistentHistoryTrackingKey)
        description.setOption(true as NSNumber,
                              forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("CoreData error \(error)")
            }
        }
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    public var context: NSManagedObjectContext {
        container.viewContext
    }
    
    public func newBackgroundContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return context
    }
}

