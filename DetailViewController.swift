//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Choudhury,Subham on 1/18/17.
//  Copyright © 2017 Choudhury,Subham. All rights reserved.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController,MFMailComposeViewControllerDelegate {

    @IBOutlet var stationName: UILabel!
    @IBOutlet var temp: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var windSpeed: UILabel!
    @IBOutlet var cloud: UILabel!
    @IBOutlet var windDirection: UILabel!
    @IBOutlet var dewPoint: UILabel!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var share: UIButton!
    @IBOutlet var prevButton: UIButton!
    ////////
    var weathers:[WeatherData] = []
    var selectedItem:Int? = nil
    ////////
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setData()
        if selectedItem == 0
        {
            prevButton.setTitle("", for: .normal)
        }
        if selectedItem == weathers.count - 1
        {
            nextButton.setTitle("", for: .normal)
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    ////////
    @IBAction func nextAction(_ sender: Any)
    {
        rightAction()
    }
    
    @IBAction func prevAction(_ sender: Any)
    {
        leftAction()
    }
    
    @IBAction func shareAction(_ sender: Any)
    {
//       let text = "XYZ"
//        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = self.view
//        self.present(activityViewController, animated: true)
        sendMail()
    }
    ////////
    func leftAction()
    {
    nextButton.setTitle(">", for: .normal)
    if selectedItem! > 0
        {
            selectedItem = selectedItem! - 1
            setData()
        }
        if selectedItem == 0
        {
            prevButton.setTitle("", for: .normal)
        }
    }
    func rightAction()
    {
        prevButton.setTitle("<", for: .normal)
        
        if selectedItem! < (weathers.count-1)
        {
            selectedItem = selectedItem! + 1
            setData()
        }
        if selectedItem == weathers.count - 1
        {
            nextButton.setTitle("", for: .normal)
        }
    }
    func setData()
    {
        stationName.text = weathers[selectedItem!].stationName
        temp.text = "\((weathers[selectedItem!].temperature))°c"
        humidity.text = "\((weathers[selectedItem!].humidity)) %"
        windSpeed.text = "\((weathers[selectedItem!].windSpeed)) km/h"
        cloud.text = weathers[selectedItem!].clouds
        windDirection.text = "\((weathers[selectedItem!].windDirection))"
        dewPoint.text = "\((weathers[selectedItem!].dewPoint))°"
    }
    func sendMail()
    {
        if MFMailComposeViewController.canSendMail()
        {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            mailVC.setToRecipients(["subhamchoudhary.dgp@gmail.com"])
            mailVC.setMessageBody("This is Demo Mail.", isHTML: true)
            self.present(mailVC, animated: true)
        }
        else
        {
            self.showAlert(title: "Alert!", errorMsg: "Could not send Email. Please check your mail configration.",actionTitle: "OK", handler: nil)
        }
    }
}
