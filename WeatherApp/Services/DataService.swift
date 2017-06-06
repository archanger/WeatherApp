//
//  DataService.swift
//  WeatherApp
//
//  Created by Kirill on 06.06.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import Foundation
import CoreData

protocol DataServiceProtocol {
  func writeToHistory(weather: Weather)
  func history() -> [HistoryEntity]
}

class HistoryEntity {
  var id: Int
  var cityName: String
  
  init(id: Int, city: String) {
    self.id = id
    self.cityName = city
  }
}

class DataService: DataServiceProtocol {
  
  func writeToHistory(weather: Weather) {
    
    _dataManager.makeTransaction { (context) in
    
      let entity = NSEntityDescription.insertNewObject(forEntityName: "WeatherHistory", into: context) as! WeatherHistory
      entity.cityId = Int32(weather.id)
      entity.location = weather.city
      entity.requestDate = NSDate()
    }
    
  }
  
  func history() -> [HistoryEntity] {
  
    var result = [HistoryEntity]()
  
    _dataManager.makeTransaction { (context) in
      let request: NSFetchRequest<WeatherHistory> = WeatherHistory.fetchRequest()
      request.sortDescriptors = [NSSortDescriptor(key: "requestDate", ascending: false)]
      let res = try! context.fetch(request)
      
      result = res.map{ $0.historyEntity }
    }
    
    return result
  }
  
  private var _dataManager = DataManager.shared
}


extension WeatherHistory {
  var historyEntity: HistoryEntity {
    return HistoryEntity(id: Int(self.cityId), city: self.location ?? "")
  }
}
