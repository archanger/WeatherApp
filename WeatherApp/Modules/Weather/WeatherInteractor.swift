//
//  WeatherInteractor.swift
//  WeatherApp
//
//  Created by Kirill on 31.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherOutput: class {
  func noWeather()
  func receive(weather: WeatherViewModel)
}

protocol WeatherSource {
  func isLocationServiceEnabled() -> Bool
  func fetchWeather(for city: String)
  func fetchWeather(for cityId: Int)
  func fetchWeatherForCurrentLocation()
}

class WeatherInteractor {
  
  weak var output: WeatherOutput?
  
  fileprivate func receive(weather: Weather?) {
    DispatchQueue.main.async {
      if weather == nil {
        self.output?.noWeather()
      } else {
        self.output?.receive(weather: weather!.viewModel)
      }
    }
  }
  
  fileprivate var _weatherService: WeatherServiceProtocol = ServiceFactory.weatherService
  fileprivate var _locationService: LocationServiceProtocol = ServiceFactory.locationService
}

extension WeatherInteractor: WeatherSource {
  
  func fetchWeather(for cityId: Int) {
    _weatherService.requestWeather(for: cityId) {[unowned self] (weather) in
      self.receive(weather: weather)
    }
  }

  func isLocationServiceEnabled() -> Bool {
    return _locationService.isServiceEnabled()
  }

  func fetchWeather(for city: String) {
    _weatherService.requestWeather(for: city) {[unowned self] (weather) in
      self.receive(weather: weather)
    }
  }
  
  func fetchWeatherForCurrentLocation() {
    _locationService.requestAuthorization(completion: self.authorization(success:))
  }
  
  private func authorization(success: Bool) {
    if success {
      self._locationService.requestCurrentLocation(completion: self.requestLocation(_:))
    } else {
      self.output?.noWeather()
    }
  }
  
  private func requestLocation(_ location: CLLocationCoordinate2D?) {
    if location != nil {
      self._weatherService.requestWeather(for: location!, completion: self.receive(weather:))
    } else {
      self.output?.noWeather()
    }
  }
}

extension Weather {
  var viewModel: WeatherViewModel {
    
    return WeatherViewModel(
      date: self.relevantDate,
      city: self.city,
      description: self.weatherDescription ?? "",
      icon: self.iconURL,
      temperature: self.temperature,
      windspeed: self.windSpeed,
      pressure: self.pressure,
      humidity: self.humidity,
      cloudness: self.cloudness
    )
    
  }
}
