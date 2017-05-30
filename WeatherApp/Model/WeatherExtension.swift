//
//  WeatherParsing.swift
//  WeatherApp
//
//  Created by Kirill on 30.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import Foundation

extension Weather {
  
  convenience init?(from jsonObject: [String: Any]) {
    
    if let id = jsonObject["id"] as? Int,
       let city = jsonObject["name"] as? String,
       let timestamp = jsonObject["dt"] as? Int {
      
      let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
      self.init(id: id, city: city, date: date)
      

      if let weather = (jsonObject["weather"] as? Array<[String:Any]>)?.first {
        self.weatherDescription = weather["description"] as? String
        if let icon = weather["icon"] as? String {
          self.iconURL = URL(string: "http://openweathermap.org/img/w/\(icon).png")
        }
      }
      
      if let wind =  (jsonObject["wind"] as? [String:Any])?["speed"] as? Float {
        self.windSpeed = wind
      }
      
      if let main = jsonObject["main"] as? [String: Any] {
        self.temperature = (main["temp"] as? Float) ?? 0.0
        self.pressure = (main["pressure"] as? Float) ?? 0.0
        self.humidity = (main["humidity"] as? Int) ?? 0
      }
      
      self.cloudness = (jsonObject["clouds"] as? [String:Any])?["all"] as? Int ?? 0
      
    } else {
      return nil
    }
  }
  
}
