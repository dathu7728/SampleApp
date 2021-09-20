//
//  ViewProtocals.swift
//  SampleApp
//
//  Created by Prathap Reddy on 9/19/21.
//

import UIKit

protocol ViewToPresenterProtocal: class {
    var view: ViewPresenterToViewProtocol? {get set}
    var router:Router? {get set}
    var interector: ViewPresentorToInterectorProtocol? {get set}
    
    func checkTheHitsAPI(queryType:String)

    
}

protocol ViewPresentorToInterectorProtocol: class {
    var presenter: ViewInterectorToPresenterProtocol? {get set}
    
    func executeTheHitsAPI(queryType:String)


}

protocol  ViewInterectorToPresenterProtocol: class {
    func hitsResult(status: Bool, message: String?)

    
}

protocol ViewPresenterToViewProtocol: class {
    func showError(title: String, message: String)
    func showToast(message: String)
    func hitsSuccess()
    
}


