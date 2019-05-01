//
//  ShowRestaurantsViewController.swift
//  test
//
//  Created by Marco Antonio Grijalva Fregozo on 5/1/19.
//

import UIKit
import MapKit

class ShowRestaurantsViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var restaurants = RestaurantsShared.shared.restaurants
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAnnotations()
    }
    
    func focusMapView(lat: Double, lng: Double) {
        let mapCenter = CLLocationCoordinate2DMake(lat, lng)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: mapCenter, span: span)
        mapView.region = region
    }

    func createAnnotations(){
        if(restaurants != nil){
            for restaurant in restaurants!{
                let annotations = MKPointAnnotation()
                annotations.title = restaurant.name
                annotations.coordinate = CLLocationCoordinate2D(latitude: (restaurant.location?.lat)!, longitude: (restaurant.location?.lng)!)
                self.mapView.addAnnotation(annotations)
            }
            focusMapView(lat: (restaurants?.last?.location?.lat)!, lng:(restaurants?.last?.location?.lng)!)
        }else{
            AlertMessages.createMessage("Error Data!", in: self)
        }
    }
    
}
