//
//  Restaurant.swift
//  test
//
//  Created by Sergio Yáñez on 4/22/19.
//

import Foundation

class Restaurant{
    
    var name: String = String()
    var backgroundImageURL: String = String()
    var category: String = String()
    var contact: Contact?
    var location: Location?
    
    init?(name:String, backgroundImageURL:String, category:String,
          contact:Contact?, location:Location?){
        
        self.name = name
        self.backgroundImageURL =  backgroundImageURL
        self.category = category
        self.contact = contact
        self.location = location
    }
   
}

class Contact{
    
    var phone: String = String()
    var formattedPhone: String = String()
    var twitter: String?
    var facebook: String?
    var facebookUsername: String?
    var facebookName: String?
    
    init?(phone:String, formattedPhone:String, twitter:String?, facebook:String?,
          facebookUsername:String?, facebookName:String?){
        
        self.phone = phone
        self.formattedPhone =  formattedPhone
        self.twitter = twitter
        self.facebook = facebook
        self.facebookName = facebookName
        self.facebookUsername = facebookUsername
    }
    
}

class Location{
    
    var address: String = String()
    var crossStreet: String? //optionalField
    var lat: Double = Double()
    var lng: Double = Double()
    var postalCode: String?
    var cc: String = String()
    var city: String = String()
    var state: String = String()
    var country: String = String()
    //var formattedAddress: Array = Array()
    
    init?(address:String, crossStreet:String?, lat:Double, lng:Double, postalCode:String?,
          cc:String, city:String, state:String, country:String){
        
        self.address = address
        self.crossStreet =  crossStreet
        self.lat = lat
        self.lng = lng
        self.postalCode = postalCode
        self.cc = cc
        self.city = city
        self.state = state
        self.country = country
        
    }
    
}

// A persistent variable to use wherever you want
class RestaurantsShared{
    static let shared = RestaurantsShared()
    var restaurants: Array<Restaurant>?
}


