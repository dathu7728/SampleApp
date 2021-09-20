//
//  Router.swift
//  VIPERTest
//
//  Created by Teja's MacBook on 11/09/19.
//  Copyright © 2019 Vedas. All rights reserved.
//

import Foundation
import UIKit

class Router {
    static let shared = Router()
    private var navigationController = UINavigationController()
    private var storyBoard = UIStoryboard()

    func setStoryBoard(storyBoard: UIStoryboard?)  {
        guard let storyboardObj = storyBoard else {
            return
        }
        self.storyBoard = storyboardObj
    }
    
    private func getStoryBoard() -> UIStoryboard {
        return self.storyBoard
    }
    
    func setNavigationController(navigationController: UINavigationController?) {
        // For storyboard navigation controller
        guard let nController = navigationController else {
            return
        }
        
        self.navigationController = nController
    }
    private func navigator() -> UINavigationController {
        return navigationController
    }
    private func begin(withController controller: UIViewController) { // For App delegate  navigation controller (Programtical)
        navigationController = UINavigationController(rootViewController: controller)
    }
    
    private func navigatePopToView(_ objController: AnyClass, animation: Bool) {
        for controller in self.navigationController.viewControllers as Array {
            if controller.isKind(of: objController) {
                self.navigationController.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    func navigateTo(_ controller: UIViewController) {
        navigationController.pushViewController(controller, animated: true)
    }
    func navigateTo(_ controller: UIViewController, animation: Bool) {
        navigationController.pushViewController(controller, animated: animation)
    }
}

protocol Routable: class {
    func navigateToBrowsePage()
   
}

extension Router: Routable {
    
    func navigateToBrowsePage(){
        
//        guard let registerController = getStoryBoard().instantiateViewController(withIdentifier: "CancelAppointmentViewController") as? CancelAppointmentViewController else {
//            return
//        }
//        navigateTo(registerController, animation: false)

    }
    
   


    func navigateTopopToRootView() {
        navigator().popToRootViewController(animated: true)
    }
    
    func navigateBack() {
        navigator().popViewController(animated: true)
    }
    
    func navigatePopToViewController(controller: AnyClass, animation: Bool) {
        navigatePopToView(controller, animation: animation)
    }
    
}

