    //
    //  Weather.swift
    //  myWeather
    //
    //  Created by Abhir Vaidya on 29/03/17.
    //  Copyright © 2017 Abhir Vaidya. All rights reserved.
    //

    import Foundation

    struct Weather {
        var date : String?
        var minTempC : String?
        var maxTempC : String?
    }

    extension Weather {
        init?(dictionary: JSONDictionary) {
            guard let date = dictionary["date"] as? String,
                let minTempC = dictionary["mintempC"] as? String,
                let maxTempC = dictionary["maxtempC"] as? String else { return nil }
            self.date = date
            self.minTempC = minTempC
            self.maxTempC = maxTempC
        }
    }

    struct CurrentCondition {
        var observationTime : String?
        var windSpeedMiles : String?
        var humidity : String?
        var visibility : String?
        var weatherIconUrl : String?
        var weatherDesc : String?
        var temperature : String?

    }

    extension CurrentCondition{
        init?(dictionary: JSONDictionary) {
            guard let observationTime = dictionary["observation_time"] as? String,
                let windSpeedMiles = dictionary["windspeedMiles"] as? String,
                let humidity = dictionary["humidity"] as? String,
                let visibility = dictionary["visibility"] as? String,
            let temperature = dictionary["temp_C"] as? String,
            let weatherIconUrl = ((dictionary["weatherIconUrl"] as? [JSONDictionary])?[0])?["value"] as? String,
            let weatherDesc = ((dictionary["weatherDesc"] as? [JSONDictionary])?[0])?["value"] as? String else { return nil }
            
            self.observationTime = observationTime
            self.windSpeedMiles = windSpeedMiles
            self.humidity = humidity
            self.visibility =  visibility
            self.temperature = temperature
            self.weatherIconUrl =  weatherIconUrl
            self.weatherDesc = weatherDesc
        }
    }
