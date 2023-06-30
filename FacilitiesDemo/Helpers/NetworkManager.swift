//
//  NetworkManager.swift
//  FacilitiesDemo
//
//  Created by MAC-01 on 28/06/23.
//

import Foundation

enum HttpMethod:String{
    case get = "get"
    case post = "post"
    case delete = "delete"
    case patch = "patch"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func dataTask(serviceURL:String,httpMethod:HttpMethod,parameters:[String:Any]?,completion:@escaping (AnyObject?, Error?) -> Void) -> Void {
        requestResource(serviceURL: serviceURL, httpMethod: httpMethod, parameters: parameters, completion: completion)
    }
    
    private func requestResource(serviceURL:String,httpMethod:HttpMethod,parameters:[String:Any]?,completion:@escaping (AnyObject?, Error?) -> Void) -> Void {
        
        var request = URLRequest(url: "\(serviceURL.replacingOccurrences(of: " ", with: "%20"))".asUrl)
        
        request.httpMethod = httpMethod.rawValue
        
        print("parameters : \(parameters), with url : \(request.url!)")
        
        if (parameters != nil) {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
        }
        
        let sessionTask = URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
            
            if (data != nil){
                let result = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                completion (result as AnyObject, nil)
            }
            if (response != nil) {
                print(response as Any)
            }
            if (error != nil) {
                completion (nil,error!)
            }
        }
        sessionTask.resume()
    }
}
extension String {
    var asUrl : URL {
        return URL(string: self) ?? URL(string: "www.google.com")!
    }
}
