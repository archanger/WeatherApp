//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Kirill on 30.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import UIKit

protocol WeatherViewProtocol: class {
  func set(date: Date)
  func set(city: String)
  func set(description: String)
  func set(icon: URL)
  func set(temperature: Float)
  func set(windSpeed: Float)
  func set(pressure: Float)
  func set(humidity: Int)
  func set(cloudness: Int)
}

class WeatherView: UIView {


  @IBOutlet private weak var _dateLabel: UILabel!
  @IBOutlet private weak var _cityLabel: UILabel!
  @IBOutlet private weak var _descriptionLabel: UILabel!
  @IBOutlet private weak var _iconView: UIImageView!
  @IBOutlet private weak var _temperatureLabel: UILabel!
  @IBOutlet private weak var _windSpeedLabel: UILabel!
  @IBOutlet private weak var _pressureLabel: UILabel!
  @IBOutlet private weak var _humidityLabel: UILabel!
  @IBOutlet private weak var _cloudnessLabel: UILabel!
}

extension WeatherView: ViewFromNib {}
