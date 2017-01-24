//
//  NetworkClient.swift
//  CodingTestForMeltWater
//
//  Created by Jeswanth Bonthu on 1/20/17.
//  Copyright © 2017 Jeswanth Bonthu. All rights reserved.
//


import Alamofire
import ObjectMapper
import MobileCoreServices


enum NetworkError: Error {
    case networkFailure
    case parsingError
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .networkFailure:
            return "No Network Connection"
            
        case .parsingError:
            return "Data Parsing Error"
            
        default:
            return "Unknown Error"
        }
    }
}

class NetworkClient
{
    
   class func laodAPIMainUrlData(_ completionHandler: @escaping (_ posts: [Post]?, _ error: Error?) -> Void) {
        
        Alamofire.request(kMainURL).responseObject(completionHandler: { (response: DataResponse<MainResponse>) in
            
            let MainResponse = response.result.value
            switch response.result.isSuccess {
            case true:
               
                if response.response?.statusCode == kHTTPResponseStatusCodeSuccess || response.response?.statusCode == kHTTPResponseStatusCodeSuccess201 {
                    var postsArray:[Post] = []
                    if let posts = MainResponse?.postsData {
                        for post in posts {
                            print(post.user.avatarImage.url)
                            postsArray.append(post)
                        }
                        completionHandler(postsArray , nil)
                    }
                }
                else {
                    if let error = response.result.value as? Error {
                        completionHandler(nil , error)
                    }
                }
            case false:
                if let error = response.result.value as? Error {
                    switch error {
//                    case error.code:
//                       completionHandler(nil, NetworkError.networkFailure)
                    default:
                        completionHandler(nil, NetworkError.unknownError)
                    }
                } else {
                        completionHandler(nil, NetworkError.unknownError)
                    }
                }
     })
  }
    
    
    class func saveRequiredPostsData(_ posts: [Post], completion: @escaping (_ content: [PostObject]?, _ error: Error?) -> Void) {
    
        NetworkClient.downloadImageForPost(
            posts, completion: { (postObjects) in
                CachedDataManager().cacheFetchedPosts(postObjects, completion: { (postArray, error) in
                    completion(postArray , error)
                })
                
        })
    }
    
    class func downloadImageForPost(_ posts: [Post], completion: @escaping (_ posts: [Post]) -> Void) {
        
        if posts.isEmpty {
            completion(posts)
        }
        var postsWithImages = [Post]()
        
        var index = 0
        
        for  post in posts {
            self.fetchImageFromURL(post.user.avatarImage.url, completion: { (image) -> Void in
                post.user.avatharImg = image!
                postsWithImages.append(post)
                index += 1
                if index == posts.count {
                    completion(postsWithImages)
                }
                
            })
        }
    }
    
   class func fetchImageFromURL(_ url: String, completion:@escaping (_ image: UIImage?) -> Void) {
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if data != nil {
                
                if let unwrappedData = data as Data! {
                    completion(UIImage(data: unwrappedData))
                }
            } else {
                completion(nil)
            }
        }) .resume()
    }
}
