//
//  String+Utilities.swift
//  GetirToDoApp
//
//  Created by Töre Bayındır on 8.09.2019.
//  Copyright © 2019 Töre Bayındır. All rights reserved.
//

import Foundation

public extension String {

  static let empty = ""
  func url() -> URL? {
    return URL(string: self)
  }
}

extension Optional where Wrapped == String {

  var emptyIfNil: String {

    get {
      switch self {

      case .some(let value):
        return value

      case .none:
        return .empty
      }
    }
  }
}

