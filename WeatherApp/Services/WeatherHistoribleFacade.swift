//
//  WeatherHistoribleFacade.swift
//  WeatherApp
//
//  Created by Kirill on 06.06.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherHistoribleFacade: WeatherServiceProtocol {

  init(weatherService: WeatherServiceProtocol, historyService: DataServiceProtocol) {
    _historyService = historyService
    _weatherService = weatherService
  }
  
  func requestWeather(for location: CLLocationCoordinate2D, completion: @escaping (Weather?) -> Void) {
    _weatherService.requestWeather(for: location) { [weak self] (weather) in
      self?._write(weather: weather)
      completion(weather)
    }
  }
  
  func requestWeather(for city: String, completion: @escaping (Weather?) -> Void) {
    _weatherService.requestWeather(for: city) { [weak self] (weather) in
      self?._write(weather: weather)
      completion(weather)
    }
  }
  
  func requestWeather(for cityId: Int, completion: @escaping (Weather?) -> Void) {
    _weatherService.requestWeather(for: cityId) { [weak self] (weather) in
      self?._write(weather: weather)
      completion(weather)
    }
  }
  
  private func _write(weather: Weather?) {
    if let w = weather {
      self._historyService.writeToHistory(weather: w)
    }
  }
  
  private var _historyService: DataServiceProtocol
  private var _weatherService: WeatherServiceProtocol
}
