//
//  WeeklyWeatherDetailPageViewController.swift
//  myWeather
//
//  Created by Abhir Vaidya on 30/03/17.
//  Copyright © 2017 Abhir Vaidya. All rights reserved.
//

import Foundation
import UIKit

class weeklyWeatherDetailPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var weatherTableView: UITableView!
    var weatherConditionsArray : [Weather?] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // Don't forget to enter this in IB also
    let cellReuseIdentifier = "customCell"
    
    
    // number of rows in table view
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherConditionsArray.count
    }
    
    // create a cell for each table view row
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let cell:CustomCell = weatherTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CustomCell
        let weatherObject = weatherConditionsArray[indexPath.row]
        let strMinC = weatherObject?.minTempC
        let temperatureStrMin = strMinC! + "\u{00B0}" + "C"
        
        let strMaxC = weatherObject?.maxTempC
        let temperatureStrMax = strMaxC! + "\u{00B0}" + "C"
        
        cell.minTempC.text = temperatureStrMin
        cell.maxtempC.text = temperatureStrMax
        cell.day.text = Utility.getDayOfWeek((weatherObject?.date)!)
        return cell
    }
    
    // method to run when table view cell is tapped
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
}
