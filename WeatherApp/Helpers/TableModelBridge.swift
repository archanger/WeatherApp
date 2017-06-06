//
//  TableModelBridge.swift
//  WeatherApp
//
//  Created by Kirill on 06.06.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import UIKit


protocol CellAnyModel {
  var identifier: String { get }
  func dequeCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol ModeledCell {
  associatedtype Model
  func update(with model: Model)
}

protocol CellModel: CellAnyModel {
  associatedtype CellType: UITableViewCell
  var identifier: String { get }
}

extension UITableView {
  
  func cell<Model: CellModel>(for model: Model, indexPath: IndexPath) -> UITableViewCell
  where Model.CellType : ModeledCell, Model.CellType.Model == Model {
  
    let cell = self.dequeueReusableCell(withIdentifier: model.identifier, for: indexPath) as! Model.CellType
    cell.update(with: model)
    
    return cell
  }
  
}
