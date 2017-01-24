//
//  APIClient.swift
//  CodingTestForMeltWater
//
//  Created by Jeswanth Bonthu on 1/20/17.
//  Copyright © 2017 Jeswanth Bonthu. All rights reserved.
//


/* This File is just For Auth Purpose Not using in this project */
import Alamofire
import ObjectMapper
import MobileCoreServices

class APIClient
{
    enum httpMethod : String {
        case post = "POST"
        case delete = "DELETE"
        case update = "UPDATE"
        case put = "PUT"
        case get = "GET"
    }

    
    private let defaultHeaders : [String:String] = ["":""]
    
    //MARK: - Singleton 
    class var sharedClient:APIClient{
        struct Singleton{
         static let sharedClient = APIClient()
        }
        return Singleton.sharedClient
    }
    
    //MARK: - Request Method
      func request(_ URLString: URLConvertible,
                method:httpMethod,
                parameters: [String:AnyObject]? = nil) -> Request
    {
      switch method{
        case APIClient.httpMethod.post:
            return  Alamofire.request("", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: defaultHeaders)
        case APIClient.httpMethod.delete:
            return  Alamofire.request("", method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: defaultHeaders)
        case APIClient.httpMethod.put:
            return  Alamofire.request("", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: defaultHeaders)
        case APIClient.httpMethod.get:
           return  Alamofire.request("", method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: defaultHeaders)
        default:
         return  Alamofire.request("", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: defaultHeaders)
        }
    
    }
     func request(URLRequest : URLConvertible) -> Request
    {
      return  Alamofire.request(URLRequest)
    }
}
