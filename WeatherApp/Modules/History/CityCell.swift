//
//  CityCell.swift
//  WeatherApp
//
//  Created by Kirill on 06.06.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  @IBOutlet weak var _labelView: UILabel!
  
}

struct CityCellModel {
  let cityName: String
}

extension CityCell: ModeledCell {
  func update(with model: CityCellModel) {
    self._labelView.text = model.cityName
  }
}

extension CityCellModel: CellModel {
  
  typealias CellType = CityCell
  var identifier: String {
    return CityCell.identifier
  }
  
  func dequeCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    return tableView.cell(for: self, indexPath: indexPath)
  }
  
}
