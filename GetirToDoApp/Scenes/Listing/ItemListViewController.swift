//
//  ItemListViewController.swift
//  GetirToDoApp
//
//  Created by Töre Bayındır on 8.09.2019.
//  Copyright © 2019 Töre Bayındır. All rights reserved.
//

import UIKit

public class ItemListViewController: UIViewController {

  @IBOutlet private weak var tableView: UITableView!
  public var interactor: ItemListInteractor!
  private let cellIdentifier = "ItemCellIdentifier"

  private var items: [ItemViewModel] = .empty {
    didSet {
      tableView.reloadData()
    }
  }

  private lazy var rightButtonItem: UIBarButtonItem = {
    return UIBarButtonItem(barButtonSystemItem: .add,
                           target: self,
                           action: #selector(addButtonAction(sender:)))
  }()

  public override func viewDidLoad() {
    super.viewDidLoad()
    prepareView()
    fetchItems()

  }

  private func fetchItems() {
    interactor.fetchItems() { [weak self] items in
      if let notes = items {
        self?.items = notes
      }
    }
  }

  private func prepareView() {

    navigationItem.title = "Notes List"
    navigationItem.rightBarButtonItem = rightButtonItem

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    tableView.hideEmptyRows()
  }
}
// MARK: Actions

public extension ItemListViewController {

  @objc func addButtonAction(sender: UIBarButtonItem?) {
    interactor.coordinator.showAdd(delegate: self)
  }
}

// MARK: TableView DataSource

extension ItemListViewController: UITableViewDataSource {

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let itemCell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
    let item = items[indexPath.row]

    itemCell.textLabel?.text = item.title
    itemCell.detailTextLabel?.text = item.dateString
    itemCell.accessoryType = .detailDisclosureButton

    return itemCell
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  public func tableView(_ tableView: UITableView,
                        commit editingStyle: UITableViewCell.EditingStyle,
                        forRowAt indexPath: IndexPath) {

    if editingStyle == .delete {
      interactor.deleteItem(id: items[indexPath.row].id) { [weak self] in
        self?.items.remove(at: indexPath.row)
      }
    }
  }

  public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
}

// MARK: TableView Delegate

extension ItemListViewController: UITableViewDelegate {

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let item = items[indexPath.row]
    interactor.coordinator.showEdit(with: item.id, delegate: self)
  }
}

// MARK: TableView extension

public extension UITableView {

  func hideEmptyRows() {
    tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize.zero))
    tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize.zero))
  }
}

extension ItemListViewController: ItemDetailDelegate {
  public func saveOperationDone() {
    fetchItems()
  }
}
