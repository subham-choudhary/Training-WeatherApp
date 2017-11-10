//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Choudhury,Subham on 1/10/17.
//  Copyright © 2017 Choudhury,Subham. All rights reserved.
//

import Foundation

class WeatherData
{
    let longitude:Double
    let clouds:String
    let dewPoint:String
    let temperature:String
    let humidity:Double
    let stationName:String
    let weatherCondition:String
    let windDirection:Double
    let windSpeed:String
    let latitude:Double
    
    init (longitude:Double,clouds:String,dewPoint:String,temperature:String,humidity:Double,weatherCondition:String,windDirection:Double,windSpeed:String,latitude:Double,stationName:String)
    {
        self.longitude = longitude
        self.clouds = clouds
        self.dewPoint = dewPoint
        self.temperature = temperature
        self.stationName = stationName
        self.humidity = humidity
        self.weatherCondition = weatherCondition
        self.windDirection = windDirection
        self.windSpeed = windSpeed
        self.latitude = latitude
    }
}
