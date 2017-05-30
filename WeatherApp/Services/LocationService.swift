//
//  LocationService.swift
//  WeatherApp
//
//  Created by Kirill on 30.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol {
  func requestAuthorization(completion: @escaping (Bool) -> Void)
  func requestCurrentLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void)
}

class LocationService: NSObject, LocationServiceProtocol {
  
  override init() {
    super.init()
    _location.delegate = self
  }
  
  func requestAuthorization(completion: @escaping (Bool) -> Void) {
  
    if (_currentStatus != .authorizedWhenInUse) {
      _location.requestWhenInUseAuthorization()
      _completionAuth = completion
    } else {
      _completionAuth?(_currentStatus == .authorizedWhenInUse)
    }
  }
  
  func requestCurrentLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
    _location.requestLocation()
  }
  
  private var _location = CLLocationManager()
  fileprivate var _currentStatus = CLLocationManager.authorizationStatus()
  fileprivate var _completionAuth: ((Bool) -> Void)?
  fileprivate var _completionLocation: ((CLLocationCoordinate2D?) -> Void)?
}

extension LocationService: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    _currentStatus = status
    _completionAuth?(_currentStatus == .authorizedWhenInUse)
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    _completionLocation?(nil)
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let lastLocation = locations.last
    _completionLocation?(lastLocation?.coordinate)
  }
}
