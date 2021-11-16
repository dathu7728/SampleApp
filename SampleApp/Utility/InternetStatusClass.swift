//
//  InternetStatusClass.swift
//  Impulse8050
//
//  Created by VedsAshk on 28/09/16.
//  Copyright © 2016 Holux. All rights reserved.
//

import UIKit
import SystemConfiguration
class InternetStatusClass: NSObject {
    var reachability: Reachability!
    var isConnected = true
    
    class var sharedInstance: InternetStatusClass {
        struct Singleton {
            static let instance = InternetStatusClass()
        }
        return Singleton.instance
    }
    
    private override init() {
        super.init()
        reachability = Reachability(hostname: "www.google.com")
        reachabilityChanged()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged),
                                               name: reachabilityChangedNotification,
                                               object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged() {
        
        if reachability.currentReachabilityStatus == .notReachable {
            //UIApplication.statusBarBackgroundColor = UIColor.red
            isConnected = false
        } else {
            isConnected = true
            //UIApplication.statusBarBackgroundColor = appThemeColor
            // NotificationCenter.default.post(Notification.init(name:  wifiStatusNotification))
            //isConnectedToNetwork(completionHandler: {(status) in
            //              self.isConnected = status
            //              NotificationCenter.default.post(Notification.init(name:
            //         wifiStatusNotification))
            //          }
            //
        }
        
        // NotificationCenter.default.post(Notification.init(name: wifiStatusNotification))
        
    }
    
    //    func getWiFiSsid() -> String? {
    //        guard let interfaces = CNCopySupportedInterfaces() as? [String] else { return nil }
    //        let key = kCNNetworkInfoKeySSID as String
    //        for interface in interfaces {
    //            guard let interfaceInfo = CNCopyCurrentNetworkInfo(interface as CFString) as NSDictionary? else { continue }
    //            return interfaceInfo[key] as? String
    //        }
    //        return nil
    //    }
    
    public func isConnectedToNetwork(completionHandler:@escaping (Bool) -> Void) {
        
        let session: URLSession = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 3
            configuration.timeoutIntervalForResource = 3
            return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        }()
        let url = URL(string: "http://www.google.com/m")!
        let task = session.dataTask(with: url) {(data, response, error) in
            guard let error = error else {
                completionHandler(true)
                return
            }
            completionHandler(false)
            print(error)
            
        }
        
        task.resume()
    }
    
}
