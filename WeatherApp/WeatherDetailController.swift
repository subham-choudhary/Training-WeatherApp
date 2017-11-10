//
//  WeatherDetailController.swift
//  WeatherApp
//
//  Created by Choudhury,Subham on 1/18/17.
//  Copyright © 2017 Choudhury,Subham. All rights reserved.
//

import UIKit

class WeatherDetailController: UIViewController {
    
    @IBOutlet var clouds: UILabel!
    var weather = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
