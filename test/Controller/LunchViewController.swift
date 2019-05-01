//
//  HomeViewController.swift
//  test
//
//  Created by Sergio Yáñez on 4/22/19.
//
//

import UIKit
import AlamofireImage


class LunchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var numberOfList : Int = 0
    var list_array: Array<Restaurant> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
         getRestaurants()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let view = tableView.dequeueReusableCell(withIdentifier: "lunchcell", for: indexPath) as! LunchTableViewCell
        
        if(self.list_array.count > 0){
        view.itemRestaurantName.text = list_array[indexPath.row].name
        view.itemCategory.text = list_array[indexPath.row].category
        
        if let url = URL(string:list_array[indexPath.row].backgroundImageURL){
            view.itemImage.af_setImage(withURL: url)
        }
        }
        
        return view
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare segue")
        if let indexPath = self.tableView.indexPathForSelectedRow{
            print(indexPath)
            if segue.identifier! == "detailRestaurantSegue" {
                print("identifier id")
                let  destinationViewController = segue.destination as! DetailRestaurantViewController
                destinationViewController.restaurant = list_array[indexPath.row]
            }
        }
    }
    
    func getRestaurants(){
        if Reachability.isConnectedToNetwork(){
            LoadingView.shared.showProgressView(messageLabel: "")
            APIManager.shared.getRestaurants(completionHandler:{ (response) in
                if response["restaurants"] != nil {
                    print("response: \(response["restaurants"])")
                    
                    let list_array = response["restaurants"].array!
                    
                    for restaurant in list_array {
                        print("restaurants: \(restaurant["name"])")
                        //MARK: These 3 Fields are a must
                        if let name = restaurant["name"].string,
                            let backgroundImageURL = restaurant["backgroundImageURL"].string,
                            let category = restaurant["category"].string
                            {
                                var contact: Contact?
                                var location: Location?
                                //Optional CONTACT fields
                                if let jsonContact = restaurant["contact"].dictionary {
                                    let phone = jsonContact["phone"]?.description
                                    let formattedPhone = jsonContact["formattedPhone"]?.description
                                    var twitter: String?
                                    var facebook: String?
                                    var facebookUsername: String?
                                    var facebookName: String?
                                    
                                    if jsonContact["twitter"]?.exists() ?? false {
                                       twitter = jsonContact["twitter"]?.description
                                    }
                                    if jsonContact["facebook"]?.exists() ?? false {
                                        facebook = jsonContact["facebook"]?.description
                                    }
                                    if jsonContact["facebookUsername"]?.exists() ?? false {
                                        facebookUsername = jsonContact["facebookUsername"]?.description
                                    }
                                    if jsonContact["facebookName"]?.exists() ?? false {
                                        facebookName = jsonContact["facebookName"]?.description
                                    }

                                    
                                    contact = Contact.init(phone: phone!, formattedPhone: formattedPhone!, twitter: twitter, facebook: facebook, facebookUsername: facebookUsername, facebookName: facebookName)
                                } //End Optional CONTACT fields
                                
                                //LOCATION Fields
                                if let jsonLocation = restaurant["location"].dictionary {
                                    let address = jsonLocation["address"]?.description
                                    let lat = jsonLocation["lat"]?.double
                                    let lng = jsonLocation["lng"]?.double
                                    let cc = jsonLocation["cc"]?.description
                                    let city = jsonLocation["city"]?.description
                                    let state = jsonLocation["state"]?.description
                                    let country = jsonLocation["country"]?.description
                                    var postalCode: String?
                                    var crossStreet: String?
                                    
                                    if jsonLocation["postalCode"]?.exists() ?? false {
                                        postalCode = jsonLocation["postalCode"]?.description
                                    }
                                    if jsonLocation["crossStreet"]?.exists() ?? false {
                                        crossStreet = jsonLocation["crossStreet"]?.description
                                    }
                                    
                                    location = Location.init(address: address!, crossStreet: crossStreet, lat: lat!, lng: lng!, postalCode: postalCode, cc: cc!, city: city!, state: state!, country: country!)
                                } //End LOCATION field
                                
                                let restaurant = Restaurant.init(name: name, backgroundImageURL: backgroundImageURL, category: category, contact: contact, location: location)
                            self.list_array.append(restaurant!)
                            print("ARRAY \(self.list_array.count)")
                        }
                    }
                    self.numberOfList = self.list_array.count
                    RestaurantsShared.shared.restaurants = self.list_array
                    self.tableView.reloadData()
                }
                LoadingView.shared.hideProgressView()
            })
        }else{
            AlertMessages.createMessage("Error Internet Connection!", in: self)
        }
        
    }
}

