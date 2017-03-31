    //
    //  Utility.swift
    //  myWeather
    //
    //  Created by Abhir Vaidya on 29/03/17.
    //  Copyright © 2017 Abhir Vaidya. All rights reserved.
    //

    import Foundation
    import UIKit

    class Utility{
        // Method to get Day of week from Date
        static func getDayOfWeek(_ today:String) -> String? {
            let formatter  = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            guard let todayDate = formatter.date(from: today) else { return nil }
            let myCalendar = Calendar(identifier: .gregorian)
            let weekDay = myCalendar.component(.weekday, from: todayDate)
            switch weekDay {
            case 1:
                return "Sunday"
            case 2:
                return "Monday"
            case 3:
                return "Tuesday"
            case 4:
                return "Wednesday"
            case 5:
                return "Thursday"
            case 6:
                return "Friday"
            case 7:
                return "Saturday"
            default:
                print("Error fetching days")
                return "Day"
            }
        }
    }

    
    // MARK: UIImageview extension to asynchronously download image and update it
extension UIImageView {
        public func imageFromServerURL(urlString: String) {
            
            URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
                
                if error != nil {
                    print(error)
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    self.image = image
                })
                
            }).resume()
}}
