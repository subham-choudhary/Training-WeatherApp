//
//  FirstViewController.swift
//  WeatherApp
//
//  Created by Choudhury,Subham on 1/10/17.
//  Copyright © 2017 Choudhury,Subham. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UITextFieldDelegate,ConnectionManagerDelegate {
    
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var north: UITextField!
    @IBOutlet var east: UITextField!
    @IBOutlet var south: UITextField!
    @IBOutlet var west: UITextField!
    @IBOutlet var userNameMark: UILabel!
    @IBOutlet var northMark: UILabel!
    @IBOutlet var southMark: UILabel!
    @IBOutlet var eastMark: UILabel!
    @IBOutlet var westMark: UILabel!
    @IBOutlet var newView: UIView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    var weatherDataList = ([WeatherData](),String())
    let manager = ConnectionManager()
    let utility = Utility()
    
    override func viewDidLoad(){
        super.viewDidLoad()
         manager.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        north.text = "10"
        south.text = "20"
        east.text = "30"
        west.text = "40"
    }
    @IBAction func tapOnScreenAction(_ sender: Any)
    {
        view.endEditing(true)
    }
    @IBAction func buttonAction(_ sender: Any)
    {
        newView.isHidden = false
        userName.text = userName.text?.trimmingCharacters(in: .whitespaces)
        north.text = north.text?.trimmingCharacters(in: .whitespaces)
        south.text = south.text?.trimmingCharacters(in: .whitespaces)
        east.text = east.text?.trimmingCharacters(in: .whitespaces)
        west.text = west.text?.trimmingCharacters(in: .whitespaces)
        
        if isTextFieldsValid()
        {
            newView.isHidden = false
            let dataUrl = URL(string:"http://api.geonames.org/weatherJSON?north=\(north.text!)&south=\(south.text!)&east=\(east.text!)&west=\(west.text!)&username=\(userName.text!)" )
            manager.getWeatherObject(dataUrl: dataUrl!)
        }
    }
    // Conforming to the protocol
    func getData(data: ([WeatherData], String)) {
        weatherDataList = data
        newView.isHidden = true
        if self.weatherDataList.1 == "1"
        {
            self.performSegue(withIdentifier: "mapController", sender: nil)
        }
        else if self.weatherDataList.1 == "0"
        {
            self.showAlert(title: "Alert!", errorMsg:"Invalid Coordinates! Please try again! ",actionTitle:"Try Again?", handler: nil)
        }
        else {
            
            self.showAlert(title: "Alert!", errorMsg:self.weatherDataList.1.capitalizingFirstLetter(), actionTitle:"Try Again?", handler: nil)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    //Perform Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let destination = segue.destination as! MapViewController
        destination.weatherObservation = weatherDataList.0
    }
    //MARK:- Check All Text Field Valid or Not
    //*****************************************
    func isTextFieldsValid()->Bool
    {
        var emptyFlag = 0
        var numFlag = 0
        var focusFlag:UITextField? = nil
        
        // Checking West
        if (west.text?.isEmpty)!
        {
            westMark.isHidden = false
            emptyFlag = 1
        }
        else
        {
            if utility.isDirectionNumber(coordinates: west.text!)
            {
                westMark.isHidden = true
            }
            else
            {
                westMark.isHidden = false
                numFlag = 1
            }
        }
        
        // Checking East
        if (east.text?.isEmpty)!
        {
            eastMark.isHidden = false
            emptyFlag = 1
            focusFlag = east
        }
        else
        {
            if utility.isDirectionNumber(coordinates: east.text!)
            {
                eastMark.isHidden = true
            }
            else
            {
                eastMark.isHidden = false
                numFlag = 1
                focusFlag = east
            }
        }
        // Checking South
        if (south.text?.isEmpty)!
        {
            southMark.isHidden = false
            emptyFlag = 1
            focusFlag = south
        }
        else
        {
            if utility.isDirectionNumber(coordinates: south.text!)
            {
                southMark.isHidden = true
            }
            else
            {
                southMark.isHidden = false
                numFlag = 1
                focusFlag = south
            }
        }
        
        // Checking North
        if (north.text?.isEmpty)!
        {
            northMark.isHidden = false
            emptyFlag = 1
            focusFlag = north
        }
        else
        {
            if utility.isDirectionNumber(coordinates: north.text!)
            {
                northMark.isHidden = true
            }
            else
            {
                northMark.isHidden = false
                numFlag = 1
                focusFlag = north
            }
        }
        
        //Checking Username
        if (userName.text?.isEmpty)!
        {
            userNameMark.isHidden = false
            emptyFlag = 1
            focusFlag = userName
        }
        else
        {
            userNameMark.isHidden = true
        }
        
        //Showing alert
        if focusFlag != nil
        {
            focusFlag?.becomeFirstResponder()
        }
        newView.isHidden = true
        var errorMsg = ""
        if emptyFlag == 1
        {
            errorMsg = "All fields are mandatory!"
        }
        if numFlag == 1
        {
            errorMsg = errorMsg + " Please give valid coordinates!"
        }
        if errorMsg != ""
        {
            self.showAlert(title: "Alert!", errorMsg: errorMsg, actionTitle:"Try Again?", handler: nil)
            return false
        }
        else
        {
            return true
        }
    }
}

