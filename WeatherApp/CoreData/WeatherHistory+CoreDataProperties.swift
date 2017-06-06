//
//  WeatherHistory+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Kirill on 06.06.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import Foundation
import CoreData


extension WeatherHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherHistory> {
        return NSFetchRequest<WeatherHistory>(entityName: "WeatherHistory")
    }

    @NSManaged public var location: String?
    @NSManaged public var cityId: Int32
    @NSManaged public var requestDate: NSDate?

}
