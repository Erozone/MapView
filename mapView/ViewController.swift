//
//  ViewController.swift
//  mapView
//
//  Created by Mohit Kumar on 26/01/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import MapKit

class Place{
    let latitude:CLLocationDegrees
    let longitude:CLLocationDegrees
    let placeName:String
    let comment:String
    
    init(lat:CLLocationDegrees,long:CLLocationDegrees,placeName:String,placeComment:String) {
        latitude = lat
        longitude = long
        self.placeName = placeName
        self.comment = placeComment
    }
}

class ViewController: UIViewController {

    //MARK:- Properties
    
    var currentIndex = -1
    var previousIndex = -1
    var places = [Place(lat:26.838208,long:80.996016,placeName: "Janeshwar Park",placeComment:"This is a Huge Park"),Place(lat:26.847858,long:80.975961,placeName: "Ambedkar Park",placeComment:"Ambedkar Dedicated"),Place(lat:26.850486,long:81.007209,placeName: "Nainital Momos",placeComment:"Large variety on momos"),Place(lat:26.848767,long:80.927371,placeName: "Tundey Kababi",placeComment:"heaven for foodies")]
    
    //MARK:- Outlet
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var previousButtonOutlet: UIButton!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    
    //MARK:- UIView Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previousButtonOutlet.isHighlighted = true
        myLocation(latitude: 26.963556, longitude: 80.926910, placeName: "Fauzi Dhaba", placeCommment: "This is defalt place")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //Janeshwar Park 26.838208, 80.996016,Ambedkar Park 26.847858, 80.975961,Lucknow Zoo 26.845693, 80.954894,Planetarium 26.865221, 80.923584
    // Tundey Kababi 26.848767, 80.927371,Nainital Momos 26.850486, 81.007209,Fauzi Dhaba 26.963556, 80.926910

    func myLocation(latitude:CLLocationDegrees,longitude:CLLocationDegrees,placeName:String,placeCommment:String){
        
        //Coordinates
        let placeLatitude: CLLocationDegrees = latitude
        let placeLongitude: CLLocationDegrees = longitude
        
        let myCoordinates:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: placeLatitude, longitude: placeLongitude)
        
        //Span
        
        let latDelta: CLLocationDegrees = 0.009
        let longDelta: CLLocationDegrees = 0.009
        let mySpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        let myRegion = MKCoordinateRegion(center: myCoordinates, span: mySpan)
        
        let annotation = MKPointAnnotation()
        annotation.title = placeName
        annotation.subtitle = placeCommment
        annotation.coordinate = myCoordinates
        
        mapView.addAnnotation(annotation)
        mapView.setRegion(myRegion, animated: true)
        
    }
    
    //MARK:- Actions
    
    @IBAction func nextButton(_ sender: UIButton) {
        previousIndex = currentIndex
        currentIndex += 1
        if(currentIndex >= places.count){
            currentIndex = 0
        }
        if(currentIndex >= 0 && currentIndex < places.count){
            let currentLocation = places[currentIndex]
            let currentLat = currentLocation.latitude
            let currentLog = currentLocation.longitude
            let currentPlace = currentLocation.placeName
            let currentComment = currentLocation.comment
            myLocation(latitude: currentLat, longitude: currentLog, placeName: currentPlace, placeCommment: currentComment)
            if(currentIndex == 1){
                previousButtonOutlet.isHighlighted = false
            }
        }
    }
    
    @IBAction func previousButton(_ sender: UIButton) {
        if(previousIndex != 0){
            previousButtonOutlet.isHighlighted = false
        }
        if previousIndex >= 0{
            let currentLocation = places[previousIndex]
            let currentLat = currentLocation.latitude
            let currentLog = currentLocation.longitude
            let currentPlace = currentLocation.placeName
            let currentComment = currentLocation.comment
            myLocation(latitude: currentLat, longitude: currentLog, placeName: currentPlace, placeCommment: currentComment)
            currentIndex = previousIndex
            previousIndex -= 1
        }
    }

}

