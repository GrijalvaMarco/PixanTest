//
//  DetailRestaurantViewController.swift
//  test
//
//  Created by Marco Antonio Grijalva Fregozo on 5/1/19.
//

import UIKit
import MapKit

class DetailRestaurantViewController: UIViewController {
    @IBOutlet weak var restaurantNameLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var twitterLbl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var facebookLbl: UILabel!
    
    var restaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lat = restaurant?.location?.lat
        let lng = restaurant?.location?.lng
        
        fillView()
        addPin(lat: lat!, lng: lng!)
        focusMapView(lat: lat!, lng: lng!)
        
    }
    
    func addPin(lat: Double, lng: Double) {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: lat, longitude:lng)
        annotation.coordinate = centerCoordinate
        annotation.title = restaurant?.name
        mapView.addAnnotation(annotation)
    }
    
    func focusMapView(lat: Double, lng: Double) {
        let mapCenter = CLLocationCoordinate2DMake(lat, lng)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: mapCenter, span: span)
        mapView.region = region
    }
    
    func fillView(){
        restaurantNameLbl.text = restaurant?.name
        categoryLbl.text = restaurant?.category
        
        let address = restaurant?.contact?.formattedPhone
        if(address != nil){
            addressLbl.text = "Address: \(address!)"
        }
        addressLbl.text = restaurant?.location?.address
        
        let phone = restaurant?.contact?.formattedPhone
        if(phone != nil){
            phoneLbl.text = "Phone: \(phone!)"
        }
        
        let twitter = restaurant?.contact?.twitter
        if(twitter != nil){
            twitterLbl.text = "Twitter: \(twitter!)"
        }
        
        let facebook = restaurant?.contact?.facebookUsername
        if(facebook != nil){
            facebookLbl.text = "Facebook: \(facebook!)"
        }
        
    }
       

}
