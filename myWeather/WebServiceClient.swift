//
//  WebServiceClient.swift
//  myWeather
//
//  Created by Abhir Vaidya on 29/03/17.
//  Copyright © 2017 Abhir Vaidya. All rights reserved.
//

    import Foundation
    import CoreLocation

    typealias JSONDictionary = [String: AnyObject]

    typealias WeatherTuple = (currentCondition: CurrentCondition?, Weather: [Weather?])

//MARK: Error Condition enum
    enum WeatherError: Error {
        case requestFailed
        case noData
        case serializationFailed
        case parsingFailed
    }

//MARK: Weather Result Enum
    enum WeatherResult {
        case success(WeatherTuple)
        case failure(WeatherError)
    }

    class WebServiceClient{
        static let sharedInstance = WebServiceClient()
        let session = URLSession.shared
        
        //API and base URL Path for Weather API
        fileprivate let APIKey = "c4bbaea3c1c44601a9785657172903"
        fileprivate let baseURLPath = "https://api.worldweatheronline.com/premium/v1/weather.ashx?"
        
        typealias WeatherCompletion = (WeatherResult) -> Void
        
        
        //key=c4bbaea3c1c44601a9785657172903&q=Pune&format=json&num_of_days=5
        private func weatherURL(city:String) -> URL {
            let URLPath = baseURLPath + "key=\(APIKey)" + "&q=\(city)" + "&format=json" + "&num_of_days=5"
            return URL(string: URLPath)!
        }
        
        
        //Instance Method to fetch weather condition for city
        func weather(city: String, completion: @escaping WeatherCompletion) {
            session.dataTask(with: weatherURL(city:city)) { data, URLResponse, requestError in
                guard let data = data else {
                    if let _ = requestError {
                        completion(.failure(.requestFailed))
                    } else {
                        print("WeatherController: data is nil, but there is no error!")
                    }
                    
                    return
                }
                
                do {
                    guard let JSON = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary else {
                        completion(.failure(.serializationFailed))
                        return
                    }
                    
                    guard let weatherResult = self.parse(JSON) else {
                        completion(.failure(.parsingFailed))
                        return
                    }
                    
                    completion(.success(weatherResult))
                } catch {
                    completion(.failure(.serializationFailed))
                }
                }.resume()
        }
        
        //Parse Succes Result from Dictionary and Create Model classes
        private func parse(_ payload: JSONDictionary) -> WeatherTuple? {
            
            
            guard let temp = (payload["data"] as? JSONDictionary)?["weather"] as? [JSONDictionary] else{ return nil }
            var weatherArray : [Weather?] = []
            temp.forEach{dict in
                let weather = Weather.init(dictionary: dict) ?? nil
                weatherArray.append(weather)
            }
           
            guard let currentCondition = ((payload["data"] as? JSONDictionary)?["current_condition"] as? [JSONDictionary])?[0] else{ return nil }
            let condition = CurrentCondition.init(dictionary: currentCondition) ?? nil
            
            return (condition, weatherArray)
        }
    }
