//
//  ConnectionManager.swift
//  WeatherApp
//
//  Created by Choudhury,Subham on 1/17/17.
//  Copyright © 2017 Choudhury,Subham. All rights reserved.
//

import UIKit
protocol ConnectionManagerDelegate {
    
    func getData(data:([WeatherData],String))
}

class ConnectionManager{

    var delegate:ConnectionManagerDelegate?
    func getWeatherObject(dataUrl:URL)
    {
        let dataRequest = URLRequest(url: dataUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        URLSession.shared.dataTask(with: dataRequest)
        {
            (data, response, error) in
            if error == nil
            {
                
                do
                {
                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    var dictKey:String = ""
                    var message:String = ""
                    var weatherDataList = [WeatherData]()
                    
                    for item in dictionary
                    {
                        dictKey = item.key
                    }
                    if dictKey == "weatherObservations"
                    {
                        let weatherObservations = dictionary[dictKey] as! [Any]
                        if weatherObservations.isEmpty
                        {
                            message = "0"
                        }
                        else
                        {
                            message = "1"
                            weatherDataList = Utility().getWeatherList(data: weatherObservations as! [[String:Any]])
                        }
                    }
                    if dictKey == "status"
                    {
                        let status = dictionary[dictKey] as! [String:Any]
                        message = status["message"] as! String
                    }
                    
                    DispatchQueue.main.async {
                        self.delegate?.getData(data: (weatherDataList,message))
                    }
                }
                catch
                {
                    print("serializationError!")
                }
            }
            else
            {
                print("UrlSessionError!")
            }
            }.resume()
    }
    

}
