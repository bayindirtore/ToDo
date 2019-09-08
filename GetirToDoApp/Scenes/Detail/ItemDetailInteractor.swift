//
//  ItemDetailInteractor.swift
//  GetirToDoApp
//
//  Created by Töre Bayındır on 8.09.2019.
//  Copyright © 2019 Töre Bayındır. All rights reserved.
//

import Foundation

public protocol ItemDetailDelegate: class {
  func saveOperationDone()
}

public final class ItemDetailInteractor: BaseInteractor {

  public enum Kind {
    case add
    case edit
  }
  private var itemId: String?
  public let type: Kind

  public weak var delegate: ItemDetailDelegate?

  public init(itemId: String?, type: Kind) {
    self.itemId = itemId
    self.type = type
  }

  public func save(title: String, text: String, completion: @escaping VoidCallback) {

    let titleString = title.isEmpty ? "New Note" : title
    switch type {
    case .add:
      saveNewNote(title: titleString, text: text)
    case .edit:
      editNote(title: titleString, text: text)
    }

    self.delegate?.saveOperationDone()
    completion()
  }

  private func saveNewNote(title: String, text: String) {
    service.addItem(title: title, text: text)
  }

  private func editNote(title: String, text: String) {
    if let id = itemId {
      service.editItem(id: id, title: title, text: text)
    }
  }
  
  // MARK: Fetch to edit note
  public func fetchItem(completion: @escaping Callback<ItemViewModel>) {

    if type == .edit, let id = itemId, let item = service.fetchItem(id: id) {
      completion(ItemViewModel(with: item))
    } else {
      completion(nil)
    }
  }
}
