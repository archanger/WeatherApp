//
//  Extensions.swift
//  WeatherApp
//
//  Created by Kirill on 30.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import UIKit

protocol ViewFromNib: class {
  static func fromNib() -> Self?
}

extension ViewFromNib {//where Self: UIView {
  static func fromNib() -> Self? {
    return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil).first as? Self
  }
}
