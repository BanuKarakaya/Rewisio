import CoreData

public final class CoreDataStack {

    @MainActor public static let shared = CoreDataStack()

    public let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "ArticlesModel")

        let storeURL = FileManager.default
            .containerURL(
                forSecurityApplicationGroupIdentifier:
                "group.com.banu.rewisio"
            )!
            .appendingPathComponent("shared.sqlite")

        let description = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("CoreData error \(error)")
            }
        }
    }

    public var context: NSManagedObjectContext {
        container.viewContext
    }
}

