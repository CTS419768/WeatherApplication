//
//  WeatherContentDetailPageViewController.swift
//  myWeather
//
//  Created by Abhir Vaidya on 29/03/17.
//  Copyright © 2017 Abhir Vaidya. All rights reserved.
//

import Foundation
import UIKit

class WeatherContentDetailPageViewController: UIViewController {
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var visibilityValue: UILabel!
    @IBOutlet weak var humadityValue: UILabel!

    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!

    @IBOutlet weak var windSpeedValue: UILabel!
    
    var pageIndex: Int = 0
    var currentCity : String?
    var currentCondition : CurrentCondition?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
 
    func updateUI(){
        guard let current = currentCondition else {
            return
        }
        let str = current.temperature
        let temperatureStr = str! + "\u{00B0}" + "C"
        
        visibilityValue.text = current.visibility
        humadityValue.text = current.humidity
        windSpeedValue.text = current.windSpeedMiles
        weatherCondition.text = current.weatherDesc
        temperature.text = temperatureStr
        date.text = current.observationTime
        weatherImage.imageFromServerURL(urlString: current.weatherIconUrl!)
        cityName.text = currentCity
        
    }
    
}
