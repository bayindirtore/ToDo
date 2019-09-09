//
//  ItemViewModel.swift
//  GetirToDoApp
//
//  Created by Töre Bayındır on 8.09.2019.
//  Copyright © 2019 Töre Bayındır. All rights reserved.
//

import Foundation
import CoreData

public struct ItemViewModel {
  public let id: String
  public let text: String?
  public let title: String?
  public let dateString: String
  public let edited: Bool

  public init(with entity: NSManagedObject) {
    let entityId = entity.objectID.uriRepresentation().absoluteString
    let entityText = entity.value(forKeyPath: "text") as?  String
    let entityTitle = entity.value(forKey: "title") as? String
    
    edited = entity.value(forKey: "edited") as! Bool
    let editedText = edited ? "Last Edited:" : "Created:"
    dateString = editedText + (entity.value(forKey: "date")  as! String)
    text = entityText
    title = entityTitle
    id = entityId
  }
}
