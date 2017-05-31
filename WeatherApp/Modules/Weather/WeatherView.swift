//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Kirill on 30.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import UIKit

struct WeatherViewModel {
  var date: Date
  var city: String
  var description: String
  var icon: URL?
  var temperature: Float
  var windspeed: Float
  var pressure: Float
  var humidity: Int
  var cloudness: Int
}

protocol WeatherViewProtocol: class {
  func set(model: WeatherViewModel)
}

final class WeatherView: UIView {


  @IBOutlet fileprivate weak var _dateLabel: UILabel!
  @IBOutlet fileprivate weak var _cityLabel: UILabel!
  @IBOutlet fileprivate weak var _descriptionLabel: UILabel!
  @IBOutlet fileprivate weak var _iconView: UIImageView!
  @IBOutlet fileprivate weak var _temperatureLabel: UILabel!
  @IBOutlet fileprivate weak var _windSpeedLabel: UILabel!
  @IBOutlet fileprivate weak var _pressureLabel: UILabel!
  @IBOutlet fileprivate weak var _humidityLabel: UILabel!
  @IBOutlet fileprivate weak var _cloudnessLabel: UILabel!
}

extension WeatherView: ViewFromNib { }

extension WeatherView: WeatherViewProtocol {

  func set(model: WeatherViewModel) {
    self._dateLabel.text = "\(model.date)"
    self._cityLabel.text = model.city
    self._descriptionLabel.text = model.description
    if let url = model.icon {
      if let data = try? Data(contentsOf: url) {
        self._iconView.image = UIImage(data: data)
      }
    }
    self._temperatureLabel.text = "\(model.temperature > 0 ? "+" : "")\(model.temperature)"
    self._windSpeedLabel.text = "\(model.windspeed)"
    self._pressureLabel.text = "\(model.pressure)"
    self._humidityLabel.text = "\(model.humidity)%"
    self._cloudnessLabel.text = "\(model.cloudness)%"
  }
}
