//
//  DataManager.swift
//  GetirToDoApp
//
//  Created by Töre Bayındır on 8.09.2019.
//  Copyright © 2019 Töre Bayındır. All rights reserved.
//

import Foundation
import CoreData

public final class DataManager {

  private let dataContainer: NSPersistentContainer!
  private var managedContext: NSManagedObjectContext {
    return dataContainer.viewContext
  }

  private static let items = "Items"

  public init(container: NSPersistentContainer) {
    self.dataContainer = container
  }

  public func fetchItems() -> [NSManagedObject]? {

    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: DataManager.items)
    fetchRequest.returnsObjectsAsFaults = false

    do {
      return try managedContext.fetch(fetchRequest) as? [NSManagedObject]
    }
    catch {
      return nil
    }
  }

  public func fetchItem(id: String) -> NSManagedObject? {

    if let objectUrl = id.url(), let id = managedContext.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: objectUrl) {

      return managedContext.object(with: id)
    }

    return nil
  }

  public func addItem(title: String, text: String) {

    let entity = NSEntityDescription.entity(forEntityName: DataManager.items, in: managedContext)!
    let item = NSManagedObject(entity: entity, insertInto: managedContext)
    item.setValue(text, forKey: "text")
    item.setValue(title, forKey: "title")
    item.setValue(Date.currentDateString(), forKey: "date")
    item.setValue(false, forKey: "edited")

    save()
  }

  public func deleteItem(id: String, completion:@escaping VoidCallback) {
    if let objectUrl = id.url(), let id = managedContext.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: objectUrl) {

      let object = managedContext.object(with: id)
      managedContext.delete(object)
      save()

    }
  }

  public func editItem(id:String, title: String, text: String) {

    let itemObject = fetchItem(id: id)

    if let object = itemObject {
      object.setValue(title, forKey: "title")
      object.setValue(text, forKey: "text")
      object.setValue(true, forKey: "edited")
      object.setValue(Date.currentDateString(), forKey: "date")
    }
    save()
  }

  private func save() {
    do {
      try managedContext.save()
    }
    catch let error as NSError {
      print("Save failed, \(error), \(error.userInfo)")
    }
  }
}
