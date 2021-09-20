//
//  ViewInteractor.swift
//  SampleApp
//
//  Created by Prathap Reddy on 9/19/21.
//

import UIKit

class ViewInteractor: ViewPresentorToInterectorProtocol {
    var presenter: ViewInterectorToPresenterProtocol?
    

    
    func executeTheHitsAPI(queryType:String) {
    
        let url = "https://hn.algolia.com/api/v1/search?query=\(queryType)"
        

        communicateWithBackendForResponseData(endPoint: url, params: nil, httpMethod: .get, headers: headerNil, successCallBack: {(response) in
            do {
                
                let decoder = JSONDecoder()
                let screeningResponse = try decoder.decode(hitsResponse.self, from: response as! Data)
                DispatchQueue.main.async {
                    
                        
                        HitsModel.sharedInstance.FetchHitsList = screeningResponse.hits
                        
                        
                    self.presenter?.hitsResult(status: true, message: "Succesfully fetched \(queryType) list.")
                        
                    
                }
            }
            catch let jsonError {
                self.presenter?.hitsResult(status: false, message: "\(jsonError)")
                print("JsonParsing Error \(jsonError)")
            }
        }, failureCallBack: {(error: Error) in
            self.presenter?.hitsResult(status: false, message: error.localizedDescription)

            print(error.localizedDescription)
        })
        
    }
    
}
