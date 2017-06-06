//
//  HistoryViewController.swift
//  WeatherApp
//
//  Created by Kirill on 06.06.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import UIKit

protocol HistorySource: UITableViewDataSource, UITableViewDelegate {
  func fetchCellTypesForRegistration()
}

class HistoryViewController: UIViewController {
  
  static var fromNib: HistoryViewController {
    return HistoryViewController(nibName: String(describing: self), bundle: nil)
  }
  
  var completion: ((Int) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let interactor = HistoryInteractor()
    interactor.output = self
    _source = interactor
    _tableView.dataSource = _source
    _tableView.delegate = _source
    _tableView.rowHeight = UITableViewAutomaticDimension
    _tableView.estimatedRowHeight = 44
    
    _source.fetchCellTypesForRegistration()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  @IBOutlet weak var _tableView: UITableView!
  private var _source: HistorySource!
}

extension HistoryViewController: HistoryView {

  func done(for id: Int) {
    completion?(id)
    self.navigationController?.popViewController(animated: true)
  }

  func register(cells: [UITableViewCellRegisterable.Type]) {
    self._tableView.register(cells: cells)
  }
  
  func reload() {
    self._tableView.reloadData()
  }
}
