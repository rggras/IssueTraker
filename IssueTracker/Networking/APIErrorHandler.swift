//
//  APIErrorHandler.swift
//  LCPremium
//
//  Created by Rodrigo Gras on 12/02/2019.
//  Copyright © 2019 Progentec Diagnostics, Inc. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class APIErrorHandler {
    
    func validateObject<T:BaseModel>(_ response : DataResponse<T>, completion:(_ entity: T?, _ error: NSError?) -> ()) {
        
        if let error = response.result.error {
            if let errorMessage = validateHTTPCode(response.response) {
                completion(nil, errorMessage)
                return
            }
            
            completion(nil, error as NSError)
        }
        else {
            let requestMessage = response.result.value?.message ?? ""
            
            if let _ = self.validateHTTPCode(response.response) {
                let userInfo = [NSLocalizedDescriptionKey : requestMessage]
                let errorMessage = NSError(domain: Constants.Error.domain, code: response.response?.statusCode ?? 0, userInfo: userInfo)
                
                if response.response?.statusCode == 401 {
                    NotificationCenter.default.post(name: .unauthorized, object: nil)
                }
                
                completion(nil, errorMessage)
                return
                
            }
            
            let object = response.result.value
            completion(object, nil)
        }
    }
    
    func validateArray<T:BaseModel>(_ response : DataResponse<[T]>, completion:(_ entities: [T]?, _ error: NSError?) -> ()) {
        
        if let error = response.result.error {
            if let errorMessage = self.validateHTTPCode(response.response) {
                completion(nil, errorMessage)
                return
            }
            
            completion(nil, error as NSError)
        }
        else {
            if let errorMessage = self.validateHTTPCode(response.response) {
                completion(nil, errorMessage)
                return
            }
            
            let objects = response.result.value
            completion(objects, nil)
        }
    }
    
    func validateHTTPCode(_ response : HTTPURLResponse?) -> NSError? {
        if let _response = response {
            var error : NSError?
            var messageError = Constants.Error.defaultMessage
            
            switch _response.statusCode {
            case 200..<299:
                return nil
            default:
                messageError = HTTPURLResponse.localizedString(forStatusCode: _response.statusCode)
            }
            
            let userInfo : [String: Any] = [NSLocalizedDescriptionKey : messageError]
            error = NSError(domain: Constants.Error.domain, code: 0, userInfo: userInfo)
            return error
        }
        
        return nil
    }
}
