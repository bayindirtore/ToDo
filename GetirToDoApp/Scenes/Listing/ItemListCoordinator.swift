//
//  ItemListCoordinator.swift
//  GetirToDoApp
//
//  Created by Töre Bayındır on 8.09.2019.
//  Copyright © 2019 Töre Bayındır. All rights reserved.
//

import UIKit

public final class ItemListCoordinator {

  public var navigation: UINavigationController!
  public lazy var rootView: ItemListViewController = {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
  }()

  public func start() -> UINavigationController {
    let interactor = ItemListInteractor.init()
    interactor.coordinator = self
    rootView.interactor = interactor
    navigation = UINavigationController(rootViewController: rootView)
    return navigation
  }

  public func showEdit(with objectId: String, delegate: ItemDetailDelegate) {
    ItemDetailCoordinator().show(objectId: objectId, delegate: delegate, navigator: navigation, type: .edit)
  }

  public func showAdd(delegate: ItemDetailDelegate) {
    ItemDetailCoordinator().show(objectId: nil, delegate: delegate, navigator: navigation, type: .add)
  }
}
