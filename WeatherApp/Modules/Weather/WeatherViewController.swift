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
    navigationItem.leftBarButtonItems = [locationButton]
    
    let historyButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(historyTapped))
    navigationItem.rightBarButtonItems = [historyButton]
    
    _setupWeatherView()
    _setupLoadingView()
  }
  
  @objc private func locationTapped() {
    _loadingView.setState(LoadingState())
    setVisibleLoadingView(1.0)
    self._source.fetchWeatherForCurrentLocation()
  }
  
  @objc private func historyTapped() {
    let vc = HistoryViewController.fromNib
    vc.completion = { [weak self] id in
      self?._loadingView.setState(LoadingState())
      self?.setVisibleLoadingView(1.0)
      self?._source.fetchWeather(for: id)
    }
    self.navigationController?.pushViewController(vc, animated: true)
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
  
  private func _setupLoadingView() {
    let view = LoadingView.fromNib()!
    view.translatesAutoresizingMaskIntoConstraints = false
    _containerView.addSubview(view)
    
    var constraints =
      NSLayoutConstraint.constraints(withVisualFormat: "V:|-[loadingView]-|", options: [], metrics: nil, views: ["loadingView" : view])
    constraints.append(contentsOf:
      NSLayoutConstraint.constraints(withVisualFormat: "H:|-[loadingView]-|", options: [], metrics: nil, views: ["loadingView" : view])
    )
    
    _containerView.addConstraints(constraints)
    view.setState(WaitingState())
    _loadingView = view
  }
  
  fileprivate func setVisibleLoadingView(_ alpha: Float) {
    UIView.animate(withDuration: 0.2) {
      self._loadingView.set(alpha: alpha)
    }
  }
  
  @IBOutlet private weak var _searchBarView: UISearchBar! {
    didSet {
      _searchBarView.delegate = self
    }
  }
  @IBOutlet private weak var _containerView: UIView!
  fileprivate var _weatherView: WeatherViewProtocol!
  fileprivate var _loadingView: StatusViewProtocol!
  fileprivate var _source: WeatherSource!
}

extension WeatherViewController: WeatherOutput {
  func noWeather() {
    _loadingView.setState(ErrorState())
    setVisibleLoadingView(1.0)
  }
  
  func receive(weather: WeatherViewModel) {
    DispatchQueue.main.async {
      self._weatherView.set(model: weather)
      self.setVisibleLoadingView(0.0)
    }
  }
}

extension WeatherViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    _loadingView.setState(LoadingState())
    setVisibleLoadingView(1.0)
    _source.fetchWeather(for: searchBar.text ?? "")
    searchBar.resignFirstResponder()
  }
}
