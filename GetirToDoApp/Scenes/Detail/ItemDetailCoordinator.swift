//
//  ItemDetailCoordinator.swift
//  GetirToDoApp
//
//  Created by Töre Bayındır on 8.09.2019.
//  Copyright © 2019 Töre Bayındır. All rights reserved.
//

import Foundation
import UIKit

public final class ItemDetailCoordinator {

  public lazy var detailView: ItemDetailViewController = {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "ItemDetailViewController") as! ItemDetailViewController
  }()

  public func show(objectId: String?, delegate: ItemDetailDelegate, navigator: UINavigationController?, type: ItemDetailInteractor.Kind) {

    let interactor = ItemDetailInteractor(itemId: objectId, type: type)
    interactor.delegate = delegate
    detailView.interactor = interactor

    navigator?.pushViewController(detailView, animated: true)
  }
}
