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
  func isServiceEnabled() -> Bool
}

class LocationService: NSObject, LocationServiceProtocol {
  
  override init() {
    super.init()
    _location.delegate = self
  }
  
  func isServiceEnabled() -> Bool {
    return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
  }
  
  func requestAuthorization(completion: @escaping (Bool) -> Void) {
    if (CLLocationManager.authorizationStatus() == .notDetermined) {
      _location.requestWhenInUseAuthorization()
      _completionAuth = completion
    } else {
      completion(isServiceEnabled())
    }
  }
  
  func requestCurrentLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
    _completionLocation = completion
    _location.requestLocation()
  }
  
  private var _location = CLLocationManager()
  fileprivate var _completionAuth: ((Bool) -> Void)?
  fileprivate var _completionLocation: ((CLLocationCoordinate2D?) -> Void)?
}

extension LocationService: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    _completionAuth?(isServiceEnabled())
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    _completionLocation?(nil)
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let lastLocation = locations.last
    _completionLocation?(lastLocation?.coordinate)
  }
}
