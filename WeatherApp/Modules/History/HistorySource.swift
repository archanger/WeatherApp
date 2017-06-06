//
//  HistorySource.swift
//  WeatherApp
//
//  Created by Kirill on 06.06.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import UIKit

protocol HistoryView: class {
  func register(cells: [UITableViewCellRegisterable.Type])
  func reload()
  func done(for id: Int)
}

class HistoryInteractor: NSObject {
  
  weak var output: HistoryView?
  
  override init() {
    _service =  ServiceFactory.dataService
    super.init()
    
    _generateModels()
  }
  
  private func _generateModels() {
    _models = _service.history()
  }
  
  private var _service: DataServiceProtocol
  fileprivate var _models: [HistoryEntity] = []
}

extension HistoryInteractor: HistorySource {
  func fetchCellTypesForRegistration() {
    self.output?.register(cells: [CityCell.self])
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return _models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return _models[indexPath.row].cityCellModel.dequeCell(for: tableView, indexPath: indexPath)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.output?.done(for: _models[indexPath.row].id)
  }
}

fileprivate extension HistoryEntity {
  var cityCellModel: CityCellModel {
    return CityCellModel(cityName: self.cityName)
  }
}
