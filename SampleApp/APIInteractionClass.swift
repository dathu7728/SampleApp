//
//  APIInteractionClass.swift
//  Spectrocarer
//
//  Created by Dathu on 12/12/19.
//  Copyright © 2019 Dathu. All rights reserved.
//

import Foundation
import Alamofire



var accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String


let headerYes: HTTPHeaders = ["accessTokenTyoe": accessToken ?? ""]
let headerNil: HTTPHeaders? = nil
var alamoFireManager : Session?//SessionManager?

func communicateWithBackendForResponseData(endPoint: String,
                               params: [String: Any]?,
                               httpMethod: HTTPMethod,
                               headers: HTTPHeaders?,
                               successCallBack: @escaping (_ responseData: Any) -> Void,
                               failureCallBack: @escaping ( _ error: Error) -> Void) {
    
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 20
    configuration.timeoutIntervalForResource = 15
    configuration.httpShouldUsePipelining = true
    
    alamoFireManager = Session(configuration: configuration, startRequestsImmediately: true)
    
    //configuration.httpAdditionalHeaders = headers
    //alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    
    alamoFireManager?.request(endPoint, method: httpMethod, parameters: params,encoding: JSONEncoding.default).responseData { response in
        switch response.result
        {
        case .success:
            let statusCode: Int = response.response!.statusCode
            print(statusCode)
            successCallBack(response.value as Any)//result
            break
        case .failure(let error):
            print("RESPONSE ERROR: \(error)")
            failureCallBack(error)
            break
        }
    }
}

func communicateWithBackendForResponseJSON(endPoint: String,
                                            params: [String: Any]?,
                                            httpMethod: HTTPMethod,
                                            headers: HTTPHeaders?,
                                            successCallBack: @escaping (_ responseData: Any) -> Void,
                                            failureCallBack: @escaping ( _ error: Error) -> Void) {
    
    AF.request(endPoint, method: httpMethod,
                      parameters: params, encoding: JSONEncoding.default,
                      headers: headers).validate(statusCode: 200..<300).responseJSON { response in
                        switch response.result {
                        case .success(let responseObject):
                            let statusCode: Int = response.response!.statusCode
                            print(statusCode)
                            successCallBack(responseObject)
                        case.failure(let error):
                            print("RESPONSE ERROR: \(error)")
                            failureCallBack(error)
                            return
                        }
    }
}

func communicateWithBackendForResponseJSONData(endPoint: String,
                                               params: [String: Any]?,
                                               httpMethod: HTTPMethod,
                                               headers: HTTPHeaders?,
                                               successCallBack: @escaping (_ responseData: Any) -> Void,
                                               failureCallBack: @escaping ( _ error: Error) -> Void) {
    
    AF.request(endPoint, method: httpMethod,
                      parameters: params, encoding: JSONEncoding.default,
                      headers: headers).validate(statusCode: 200..<300).responseJSON { response in
                        switch response.result {
                        case .success(let responseObject):
                            let statusCode: Int = response.response!.statusCode
                            print(statusCode)
                            
                            successCallBack(response.data as Any)

                            //successCallBack(responseObject)
                        case.failure(let error):
                            print("RESPONSE ERROR: \(error)")
                            failureCallBack(error)
                            return
                        }
    }
}



