//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kirill on 29.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _service.requestWeather(fro: 2643743) { (weather) in
      print("\(weather)")
    }
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  private var _service = ServiceFactory.weatherService
}

