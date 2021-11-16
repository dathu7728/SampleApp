//
//  ViewPresenter.swift
//  SampleApp
//
//  Created by Prathap Reddy on 9/19/21.
//

import UIKit

class ViewPresenter: ViewToPresenterProtocal {
    var view: ViewPresenterToViewProtocol?
    
    var router: Router?
    
    var interector: ViewPresentorToInterectorProtocol?
    
    func checkTheHitsAPI(queryType: String) {
        
        guard InternetStatusClass.sharedInstance.isConnected else {
        
            view?.showError(title: "Error", message: "No connection")
            return
        }
        
        interector?.executeTheHitsAPI(queryType: queryType)
        
        
    }
    
    

}

extension ViewPresenter: ViewInterectorToPresenterProtocol {
    func hitsResult(status: Bool, message: String?) {
        if status {
            
            view?.hitsSuccess()
            
        } else {
            guard let messageString = message else {
                return
            }
            view?.showError(title: "Error", message: messageString)
        }
    }
    
    
}
