//
//  CustomCell.swift
//  myWeather
//
//  Created by Abhir Vaidya on 30/03/17.
//  Copyright © 2017 Abhir Vaidya. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!

    @IBOutlet weak var minTempC: UILabel!
    @IBOutlet weak var barView: UIView!
    
    @IBOutlet weak var maxtempC: UILabel!

}
