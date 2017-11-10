//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Choudhury,Subham on 1/10/17.
//  Copyright © 2017 Choudhury,Subham. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {

    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var segment: UISegmentedControl!
    var weatherObservation = [WeatherData]()
    var selectedItem:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "Back",style: UIBarButtonItemStyle.plain,target: nil,action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        mapView.delegate = self
        showPin()
    }
    @IBAction func segmentSelectAction(_ sender: Any) {
        
        if segment.selectedSegmentIndex == 0
        {
            mapView.mapType = .standard
        }
        else
        {
            mapView.mapType = .satellite
        }
    }
    // Mapview Delegate methods ***
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var customAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView
        if customAnnotation == nil
        {
            customAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            customAnnotation?.canShowCallout = true
        }
        customAnnotation?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return customAnnotation
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
 
        var count = 0
        for item in weatherObservation
        {
            if item.stationName == (view.annotation?.title)!
            {
                selectedItem = count
            }
            count += 1
        }
        performSegue(withIdentifier: "detailView", sender: nil)
    }
    // Prepare for segue ***
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let destination = segue.destination as! DetailViewController
        destination.weathers = weatherObservation
        destination.selectedItem = self.selectedItem
    }
    
    // Function to show pin im map ***
    func showPin()
    {
        let span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
        var count = 1
        var tempRegion = MKCoordinateRegion()
        for item in weatherObservation
        {
            let pinLocation = CLLocationCoordinate2DMake(item.latitude,item.longitude)
            let region = MKCoordinateRegionMake(pinLocation, span)
            mapView.setRegion(tempRegion, animated: true)
            
            let anotation = MKPointAnnotation()
            anotation.coordinate = pinLocation
            anotation.title = "\(item.stationName)"
            anotation.subtitle = "Temp: \(item.temperature) °c"
            self.mapView.addAnnotation(anotation)
           
            if count == 4{
                tempRegion = region
            }
            count += 1
        }
        mapView.setRegion(tempRegion, animated: true)
    }
}
