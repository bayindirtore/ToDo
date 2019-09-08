//
//  ItemDetailViewController.swift
//  GetirToDoApp
//
//  Created by Töre Bayındır on 8.09.2019.
//  Copyright © 2019 Töre Bayındır. All rights reserved.
//

import UIKit

public class ItemDetailViewController: UIViewController {

  public var interactor: ItemDetailInteractor!
  @IBOutlet weak var notesTextView: UITextView!
  @IBOutlet weak var titleField: UITextField!
  private lazy var rightButtonItem: UIBarButtonItem = {
    return UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonAction(sender:)))
  }()

  private var item: ItemViewModel? {
    didSet {
      notesTextView.text = item?.text
      titleField.text = item?.title
      navigationItem.title = "Edit Note"
    }
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    prepareView()
    
    interactor.fetchItem { [weak self] result in
      if let editNote = result {
        self?.item = editNote
      }
    }
  }

  private func prepareView() {

    navigationItem.title = "New Note"
    navigationItem.rightBarButtonItem = rightButtonItem
    titleField.becomeFirstResponder()
  }

}

// MARK: Button action
public extension ItemDetailViewController {

  @objc func saveButtonAction(sender: UIBarButtonItem?) {
    interactor.save(title: titleField.text.emptyIfNil, text: notesTextView.text.emptyIfNil) { [weak self] in

      self?.navigationController?.popViewController(animated: true)
    }
  }
}

