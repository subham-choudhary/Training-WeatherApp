//
//  WeatherDetailTableViewController.swift
//  WeatherApp
//
//  Created by Choudhury,Subham on 1/18/17.
//  Copyright © 2017 Choudhury,Subham. All rights reserved.
//

import UIKit

class WeatherDetailTableViewController: UITableViewController {

    var weather:WeatherData?
    var element = (key:String(),value:String())
    var detailList:[element]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for () in weather
        {
            
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 11
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        if indexPath.row == 0
        {
            cell.textLabel?.text = weather?.stationName
        }

        return cell
    }
}
