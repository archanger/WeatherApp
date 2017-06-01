//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Kirill on 01.06.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import UIKit

protocol StatusViewState {
  var text: String { get }
  var isActive: Bool { get }
}

struct LoadingState: StatusViewState {
  var text: String = "Waiting For Response..."
  var isActive: Bool = true
}

struct WaitingState: StatusViewState {
  var text: String = "Try to find wether on yyour location..."
  var isActive: Bool = false
}

struct ErrorState: StatusViewState {
  var text: String = "Something went wrong"
  var isActive: Bool = false
}

protocol StatusViewProtocol {
  func setState(_ state: StatusViewState)
  func set(alpha: Float)
}

final class LoadingView: UIView {

  
  @IBOutlet fileprivate weak var _statusLabel: UILabel!
  @IBOutlet fileprivate weak var _activityIndicator: UIActivityIndicatorView!
}

extension LoadingView: ViewFromNib { }

extension LoadingView: StatusViewProtocol {
  func setState(_ state: StatusViewState) {
    _statusLabel.text = state.text
    if state.isActive {
      _activityIndicator.startAnimating()
    } else {
      _activityIndicator.stopAnimating()
    }
  }
  
  func set(alpha: Float) {
    self.alpha = CGFloat(alpha)
  }
}
