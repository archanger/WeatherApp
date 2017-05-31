//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by Kirill on 30.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherServiceProtocol {
  func requestWeather(for location: CLLocationCoordinate2D, completion: @escaping (Weather?) -> Void)
  func requestWeather(for city: String, completion: @escaping (Weather?) -> Void)
  func requestWeather(for cityId: Int, completion: @escaping (Weather?) -> Void)
}

class WeatherService: WeatherServiceProtocol {
  
  
  func requestWeather(for city: String, completion: @escaping (Weather?) -> Void) {
    let url = WeatherAPIRequest().url(for: city)
    request(with: url, completion: completion)
  }
  
  func requestWeather(for location: CLLocationCoordinate2D, completion: @escaping (Weather?) -> Void) {
    let url = WeatherAPIRequest().url(for: location)
    request(with: url, completion: completion)
  }
  
  func requestWeather(for cityId: Int, completion: @escaping (Weather?) -> Void) {
    let url = WeatherAPIRequest().url(for: cityId)
    request(with: url, completion: completion)
  }
  
  private func request(with URL: URL?, completion: @escaping (Weather?) -> Void) {
    guard let url = URL else {
      completion(nil)
      return
    }
    
    _urlSession.dataTask(with: url) { (data, resp, error) in
      
      guard error == nil, let data = data else {
        completion(nil)
        return
      }
      
      if let jsonDict = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
        completion(Weather(from: jsonDict))
      } else {
        completion(nil)
      }
      
    }.resume()
  }
  
  private var _urlSession = URLSession.shared
}

fileprivate struct WeatherAPIRequest {
  
  func url(for city: String) -> URL? {
  
    if let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
      let resultPath = _entrypoint + "q=\(encodedCity)" + _params
      return URL(string: resultPath)
    }
    return nil
  }
  
  func url(for coordinate: CLLocationCoordinate2D) -> URL? {
    let resultPath = _entrypoint + "lat=\(coordinate.latitude)&lon=\(coordinate.longitude)" + _params
    return URL(string: resultPath)
  }
  
  func url(for id: Int) -> URL? {
    let resultPath = _entrypoint + "id=\(id)" + _params
    return URL(string: resultPath)
  }
  
  private var _entrypoint = "http://api.openweathermap.org/data/2.5/weather?"
  private var _params = "&units=metric&lang=ru&APPID=ec4b97636fc8d92c33f903d884349820"
}
