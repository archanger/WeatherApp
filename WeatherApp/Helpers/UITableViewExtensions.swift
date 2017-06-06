//
//  UITableViewExtensions.swift
//  WeatherApp
//
//  Created by Kirill on 06.06.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import UIKit

protocol UITableViewCellRegisterable {
  static var nib: UINib { get }
  static var identifier: String { get }
}

extension UITableViewCell: UITableViewCellRegisterable {
  static var nib: UINib {
    return UINib(
      nibName: String(describing: self),
      bundle: Bundle.main
    )
  }
  
  static var identifier: String {
    return String(describing: self)
  }
}

extension UITableView {
  func register(cells: [UITableViewCellRegisterable.Type]) {
    for cell in cells {
      self.register(cell.nib, forCellReuseIdentifier: cell.identifier)
    }
  }
}
