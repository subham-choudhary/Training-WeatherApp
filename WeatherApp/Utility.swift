//
//  utility.swift
//  WeatherApp
//
//  Created by Choudhury,Subham on 1/13/17.
//  Copyright © 2017 Choudhury,Subham. All rights reserved.
//

import Foundation
import UIKit

class Utility
{
    
    //Mark:- Check Direction Number Or Not
    //**************************************
    func isDirectionNumber(coordinates:String)->Bool
    {
        let temp = Float(coordinates)
        if (temp != nil)
        {
            return true
        }
        else
        {
            return false
        }
    }
    //Mark:- Create model data
    //****************************
    func getWeatherList(data:[[String:Any]])->[WeatherData]
    {
        var weatherObservationList = [WeatherData]()
        for item in data
        {
            var windDirection = item["windDirection"]
            var humidity = item["humidity"]
            var windSpeed = item["windSpeed"]
            
            if windDirection == nil
            {
                windDirection = 0.0
            }
            if humidity == nil
            {
                humidity = 0.0
            }
            if windSpeed == nil
            {
                windSpeed = "Not available"
            }
            let tempWeather = WeatherData(
                longitude: item["lng"] as! Double,
                clouds: item["clouds"] as! String,
                dewPoint: item["dewPoint"] as! String,
                temperature: item["temperature"] as! String,
                humidity: humidity as! Double,
                weatherCondition: item["weatherCondition"] as! String,
                windDirection: windDirection as! Double,
                windSpeed: windSpeed as! String,
                latitude: item["lat"] as! Double,
                stationName:item["stationName"] as! String) as WeatherData
            
            weatherObservationList.append(tempWeather)
        }
        return weatherObservationList
    }
   
}


extension UIViewController
{
    //Alert Controller
    //******************
    func showAlert(title:String,errorMsg:String,actionTitle:String,handler:((UIAlertAction)->Void)?)
    {
        let alertController = UIAlertController(title: title, message: errorMsg, preferredStyle:.alert)
        let okAction = UIAlertAction(title:actionTitle, style: .cancel, handler: handler)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
extension String
    {
        func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
extension Double {
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
