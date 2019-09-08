//
//  BaseInteractor.swift
//  GetirToDoApp
//
//  Created by Töre Bayındır on 8.09.2019.
//  Copyright © 2019 Töre Bayındır. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class BaseInteractor {
  public let service: DataManager

  public init(container: NSPersistentContainer? = nil) {
    if let container = container {
      service = DataManager(container: container)
    }
    else {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      service = DataManager(container: appDelegate.persistentContainer)
    }
  }
}
