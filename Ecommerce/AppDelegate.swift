//
//  AppDelegate.swift
//  Ecommerce
//
//  Created by Ivan Borinschi on 10.02.2022.
// ANISH

import UIKit
import DSKit
import Branch

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?  // declare a new window property

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // enable pasteboard check
        Branch.getInstance().enableLogging()
        
        // listener for Branch Deep Link data
        Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
            // do stuff with deep link data (nav to page, display content, etc)
            
            // print params dictionary
            print(params as? [String: AnyObject] ?? {})
            
            // store dictionary to data
            guard let data = params as? [String: AnyObject] else { return }
            
            // store value of cannonical url if present
            guard let options = data["$canonical_url"] as? String else { return }
            
            // switch case to route to views
            if let navigationVC = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                
                let deeplinkParams = options.replacingOccurrences(of: "https://nike.com/", with: "").components(separatedBy: "/")
                
                if deeplinkParams.first == "itemdetail" {
                    switch deeplinkParams.last {
                    case "1":
                        let launchVC = navigationVC.viewControllers.last as? ViewController
                            launchVC?.gotoItemOneDetailVC()
                    case "2":
                        let launchVC = navigationVC.viewControllers.last as? ViewController
                            launchVC?.push(Items2ViewController())
                    case "3":
                        let launchVC = navigationVC.viewControllers.last as? ViewController
                            launchVC?.push(Items3ViewController())
                    case "4":
                        let launchVC = navigationVC.viewControllers.last as? ViewController
                            launchVC?.push(ItemDetails4ViewController())
                    default: break
                    }
                }
                
//            switch options {
//            case "https://nike.com/":
//                let launchVC = navigationVC.viewControllers.last as? ViewController
//                launchVC?.gotoItemOneDetailVC()
//            case "https://google.com/":
//                let launchVC = navigationVC.viewControllers.last as? ViewController
//                launchVC?.gotoItemSecondDetailVC()
//            default: break
//            }
        }
           }
        
        DSAppearance.shared.main = ShopAppearance()
//        DSAppearance.shared.main = BlackToneAppearance()
//        DSAppearance.shared.main = DarkLightAppearance()
//        DSAppearance.shared.main = ShopCustomFontAppearance()
        DSAppearance.shared.userInterfaceStyle = .unspecified
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
   
}



