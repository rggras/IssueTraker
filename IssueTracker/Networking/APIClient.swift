//
//  APIClient.swift
//  LCPremium
//
//  Created by Rodrigo Gras on 11/02/2019.
//  Copyright © 2019 Progentec Diagnostics, Inc. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class APICLient {
    
    func getEntity<T:BaseModel>(endpoint: String, parameters: [String : Any]? = nil, completion:@escaping (_ entity: T?, _ error: NSError?) -> ()) -> DataRequest {
        let request = createRequest(endpoint: endpoint, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .responseObject { response -> Void in
                APIErrorHandler().validateObject(response, completion: { (entity, error) in
                    completion(entity, error)
                })
        }
        
        return request
    }
    
    func getEntities<T:BaseModel>(endpoint: String, parameters: [String : Any]? = nil, completion:@escaping (_ entities: [T]?, _ error: NSError?) -> ()) -> DataRequest {
        let request = createRequest(endpoint: endpoint, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .responseArray { response -> Void in
                APIErrorHandler().validateArray(response, completion: { (entities, error) in
                    completion(entities, error)
                })
        }
        
        return request
    }
    
    func postEntity<T:BaseModel>(endpoint: String, parameters: [String : Any]? = nil, completion:@escaping (_ entity: T?, _ error: NSError?) -> ()) -> DataRequest {
        let request = createRequest(endpoint: endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseObject { response -> Void in
                APIErrorHandler().validateObject(response, completion: { (entity, error) in
                    completion(entity, error)
                })
        }
        
        return request
    }
    
    func postEntities<T:BaseModel>(endpoint: String, parameters: [String : Any]? = nil, completion:@escaping (_ entities: [T]?, _ error: NSError?) -> ()) -> DataRequest {
        let request = createRequest(endpoint: endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseArray { response -> Void in
                APIErrorHandler().validateArray(response, completion: { (entities, error) in
                    completion(entities, error)
                })
        }
        
        return request
    }
    
    func putEntity<T:BaseModel>(endpoint: String, parameters: [String : Any]? = nil, completion:@escaping (_ entity: T?, _ error: NSError?) -> ()) -> DataRequest {
        let request = createRequest(endpoint: endpoint, method: .put, parameters: parameters, encoding: URLEncoding.default)
            .responseObject { response -> Void in
                APIErrorHandler().validateObject(response, completion: { (entity, error) in
                    completion(entity, error)
                })
        }
        
        return request
    }

    func deleteEntity<T:BaseModel>(endpoint: String, parameters: [String : Any]? = nil, completion:@escaping (_ entity: T?, _ error: NSError?) -> ()) -> DataRequest {
        let request = createRequest(endpoint: endpoint, method: .delete, parameters: parameters, encoding: URLEncoding.default)
            .responseObject { response -> Void in
                APIErrorHandler().validateObject(response, completion: { (entity, error) in
                    completion(entity, error)
                })
        }
        
        return request
    }
    
    func postMultipartEntity<T:BaseModel>(endpoint: String, parameters: [String : Any]? = nil, image: UIImage?, imageKey: String?, completion: @escaping (_ entity: T?, _ error: NSError?) -> ()) {
        if let image = image, let key = imageKey {
            createMultipartRequest(endpoint: endpoint, method: .post, parameters: parameters, image: image, imageKey: key, completion: completion)
        } else {
            _ = postEntity(endpoint: endpoint, parameters: parameters, completion: completion)
        }
    }
    
    func putMultipartEntity<T:BaseModel>(endpoint: String, parameters: [String : Any]? = nil, image: UIImage?, imageKey: String?, completion: @escaping (_ entity: T?, _ error: NSError?) -> ()) {
        if let image = image, let key = imageKey {
            createMultipartRequest(endpoint: endpoint, method: .put, parameters: parameters, image: image, imageKey: key, completion: completion)
        } else {
            _ = putEntity(endpoint: endpoint, parameters: parameters, completion: completion)
        }
    }

    func createRequest(endpoint: String, method: Alamofire.HTTPMethod, parameters: [String : Any]?, encoding: ParameterEncoding) -> DataRequest {
        let urlString = APIEnvironments().apiPath(endpoint)
        var params = parameters ?? [:]
        
        let userDefaultsManager = UserDefaultsManager(userDefaults: .standard)
        if let token = userDefaultsManager.auth0IdToken {
            params["token"] = token
        }

        let request = Alamofire.request(urlString, method: method, parameters: params, encoding: encoding)
            .responseString { response in
                debugPrint("Response: \(response)")
        }
        
        debugPrint(request)
        return request
    }
    
    func createMultipartRequest<T:BaseModel>(endpoint: String, method: Alamofire.HTTPMethod, parameters: [String : Any]?, image: UIImage, imageKey: String, completion:@escaping (_ entity: T?, _ error: NSError?) -> ()) {
        let urlString = APIEnvironments().apiPath(endpoint)
        let defaults = UserDefaultsManager(userDefaults: .standard)
        let header = HTTPHeaders(dictionaryLiteral: ("x-access-token", defaults.auth0IdToken!))
        let params = (parameters ?? [:]) as! [String: String]
        
        if let data = image.jpegData(compressionQuality: 0.2) {
            
            Alamofire.upload(
                multipartFormData: { (multipartFormData) in
                    multipartFormData.append(data, withName: imageKey, fileName: imageKey + ".jpeg", mimeType: "image/jpeg")
                    
                    for (key, value) in params {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
            },
                to: urlString,
                method: method,
                headers: header) { (encodingResult) in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload
                            .responseString { response in
                                debugPrint("Response: \(response)")
                            }
                            
                            .responseObject { response -> Void in
                                APIErrorHandler().validateObject(response, completion: { (entity, error) in
                                    completion(entity, error)
                                })
                        }
                    default:
                        print("APIClient createMultipartRequest - Error trying to upload the profile picture")
                    }
            }
        }
    }
}
