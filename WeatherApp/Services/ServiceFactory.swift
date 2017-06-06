//
//  ServiceFactory.swift
//  WeatherApp
//
//  Created by Kirill on 30.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import Foundation

struct ServiceFactory {
  
  static var locationService: LocationServiceProtocol {
    return LocationService()
  }
  
  static var weatherService: WeatherServiceProtocol {
    return WeatherHistoribleFacade(
      weatherService: WeatherService(),
      historyService: DataService()
    )
  }
  
  static var dataService: DataServiceProtocol {
    return DataService()
  }
}
