//
//  ItemListInteractor.swift
//  GetirToDoApp
//
//  Created by Töre Bayındır on 8.09.2019.
//  Copyright © 2019 Töre Bayındır. All rights reserved.
//

import Foundation

public final class ItemListInteractor: BaseInteractor {

  public var coordinator: ItemListCoordinator!

  public func deleteItem(id: String, completion: @escaping VoidCallback) {
    service.deleteItem(id: id, completion: completion)
  }

  public func fetchItems(completion: @escaping Callback<[ItemViewModel]>) {
    let items = service.fetchItems()?.compactMap { result in
      ItemViewModel(with: result)
    }
    completion(items ?? [])
  }
}
