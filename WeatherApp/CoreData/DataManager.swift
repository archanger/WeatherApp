//
//  DataManager.swift
//  WeatherApp
//
//  Created by Kirill on 06.06.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import Foundation
import CoreData

typealias DataManagerCallback = (NSManagedObjectContext) -> Void

class DataManager {
  
  static var shared: DataManager = DataManager()
  
  func makeTransaction(completion: DataManagerCallback) {
    
    let newContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    newContext.parent = _privateContext
    
    completion(newContext)
    
    if newContext.hasChanges {
      try? newContext.save()
      try? _privateContext.save()
    }
    
  }
  
  private init() {
    
    let modelURL = Bundle.main.url(forResource: "WeatherHistory", withExtension: "momd")
    _managedObjectModel = NSManagedObjectModel(contentsOf: modelURL!)!
    _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: _managedObjectModel)
    _privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    _privateContext.persistentStoreCoordinator = _persistentStoreCoordinator
    let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    let storeURL = docURL?.appendingPathComponent("data.sqlite")
    try! _persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
  }
  
  private var _persistentStoreCoordinator: NSPersistentStoreCoordinator
  private var _managedObjectModel: NSManagedObjectModel
  private var _privateContext: NSManagedObjectContext
}
