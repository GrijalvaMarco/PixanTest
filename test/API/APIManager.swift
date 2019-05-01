//
//  APIManager.swift
//  test
//
//  Created by Sergio Yáñez on 4/22/19.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class APIManager {
    
    static let shared = APIManager()
    
    let baseURL = NSURL(string: Constants().BASE_URL)
    //DEV
    let globalPath = "BR_iOS_CodingExam_2015_Server/"
    
    func requestServer(_ method: HTTPMethod,_ path: String,_ params: [String: Any]?,_ encoding: ParameterEncoding,_ completionHandler: @escaping (JSON) -> Void ) {
        
        let headers = ["Accept": "application/json"]
        let url = self.baseURL?.appendingPathComponent(path)
        print("URL: \(url!)")
        
        Alamofire.request(url!, method: method, parameters: params, encoding: encoding, headers: headers).responseJSON{ response in
            print("REQUEST: method: \(method) parameters:\(params!)")
            print("RESPONSE: \(response)")
            
            //MARK: -Manage http errors if needed
            if(response.response?.statusCode == 500){
                print("Error 500")
                return
            }
            
            switch response.result {
            case .success(let value):
                let jsonData = JSON(value)
                completionHandler(jsonData)
                break
                
            case .failure:
                print("Fallo")
                completionHandler(nil)
                break
            }
        }
    }
    
    //MARK: -Declare all methods to make http requests
    
    // API - getRestaurants.
    func getRestaurants(completionHandler: @escaping (JSON) -> Void) {
        let path = "\(globalPath)restaurants.json"
        let params: [String: Any] = [ : ]
        print("request restaurants")
        requestServer(.get, path, params, URLEncoding(), completionHandler)
    }
    
}


