//
//  CommanClass.swift
//  SampleApp
//
//  Created by Prathap Reddy on 9/19/21.
//

import UIKit
import ANActivityIndicator


extension UIViewController {

    func showAlert(title: String, message: String ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func progressLoading() {
        self.showIndicator(
            CGSize.init(width: 100, height: 100), message: "Loading...", animationType: ANActivityIndicatorAnimationType.ballScaleMultiple,color:UIColor.white)
    }
    
    func hideprogressLoading() {
        self.hideIndicator()

    }

}

