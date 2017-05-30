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
    
    
    let view = WeatherView.fromNib()!
    self.view.addSubview(<#T##view: UIView##UIView#>)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  @IBOutlet private weak var _searchBarView: UISearchBar!
  private var _weatherView: WeatherViewProtocol!
}
