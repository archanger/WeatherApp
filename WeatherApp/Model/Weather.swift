//
//  Weather.swift
//  WeatherApp
//
//  Created by Kirill on 30.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import Foundation

class Weather {

  init(id: Int, city: String, date: Date) {
    self.id = id
    self.city = city
    self.relevantDate = date
  }

  var id: Int
  var city: String
  var relevantDate: Date
  
  var weatherDescription: String?
  var iconURL: URL?
  
  var windSpeed: Float = 0.0
  var temperature: Float = 0.0
  var pressure: Float = 0.0
  var humidity: Int = 0
  var cloudness: Int = 0
}
