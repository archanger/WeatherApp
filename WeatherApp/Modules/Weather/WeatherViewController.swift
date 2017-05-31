//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Kirill on 30.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let s = WeatherInteractor()
    s.output = self
    _source = s
    
    _setupUI()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  private func _setupUI() {
    
    self.title = "Weather"
    self.navigationController?.navigationBar.isTranslucent = false
    
    let locationButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(locationTapped))
    locationButton.isEnabled = _source.isLocationServiceEnabled()
    navigationItem.leftBarButtonItems = [locationButton]
    
    _setupWeatherView()
    
  }
  
  @objc private func locationTapped() {
    self._source.fetchWeatherForCurrentLocation()
  }
  
  private func _setupWeatherView() {
    let view = WeatherView.fromNib()!
    view.translatesAutoresizingMaskIntoConstraints = false
    self._containerView.addSubview(view)
    
    var constraints =
      NSLayoutConstraint.constraints(withVisualFormat: "V:|-[weatherView]-|", options: [], metrics: nil, views: ["weatherView" : view])
    constraints.append(contentsOf:
      NSLayoutConstraint.constraints(withVisualFormat: "H:|-[weatherView]-|", options: [], metrics: nil, views: ["weatherView" : view])
    )
    
    self._containerView.addConstraints(constraints)
    _weatherView = view
  }
  
  @IBOutlet private weak var _searchBarView: UISearchBar! {
    didSet {
      _searchBarView.delegate = self
    }
  }
  @IBOutlet private weak var _containerView: UIView!
  fileprivate var _weatherView: WeatherViewProtocol!
  fileprivate var _source: WeatherSource!
}

extension WeatherViewController: WeatherOutput {
  func noWeather() {
    
  }
  
  func receive(weather: WeatherViewModel) {
    DispatchQueue.main.async {
      self._weatherView.set(model: weather)
    }
  }
}

extension WeatherViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    _source.fetchWeather(for: searchBar.text ?? "")
    searchBar.resignFirstResponder()
  }
}
