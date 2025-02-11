//
//  AppDelegate.swift
//  parseFoursquareClone
//
//  Created by Caner Uçar on 14.09.2018.
//  Copyright © 2018 Caner Uçar. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //Uygulama ilk açıldığında yapılacaklar
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "387h4lEB23IHmOaigS19LKgTORgWzsoO8NuEKMKd"
            $0.clientKey = "nnTaPAbPkMZHyS55D8J2nnjcKKd7Kh5QZaG61Szf"
            $0.server = "https://parseapi.back4app.com/"
        }
        Parse.initialize(with: configuration)
        saveInstallationObject()
      
        rememberLogIn()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func saveInstallationObject(){
        if let installation = PFInstallation.current(){
            installation.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    print("You have successfully connected your app to Back4App!")
                } else {
                    if let myError = error{
                        print(myError.localizedDescription)
                    }else{
                        print("Uknown error")
                    }
                }
            }
        }
    }
    
    func rememberLogIn() {
        
        let user : String? = UserDefaults.standard.string(forKey: "userLoggedIn") //böyle bir şey var mı kontrol et
        if user != nil {
            
            let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationController = board.instantiateViewController(withIdentifier: "navigationVC") as! UINavigationController
            window?.rootViewController = navigationController
            
        }
        
    }


}

