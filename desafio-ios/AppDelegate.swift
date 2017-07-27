    //
//  AppDelegate.swift
//  desafio-ios
//
//  Created by Felipe Marino on 2/24/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var session: WCSession!
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        watchConnectivitySetup()
        UserDefaultsManager.configureLastSelectedLanguage()
        
        UIApplication.shared.statusBarStyle = .lightContent
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

    func application(_ application: UIApplication, handleWatchKitExtensionRequest userInfo: [AnyHashable : Any]?, reply: @escaping ([AnyHashable : Any]?) -> Void) {
        print("received info: \(userInfo)")
    }
    
    private func watchConnectivitySetup() {
        if WCSession.isSupported() {
            session = WCSession.default()
            session.delegate = self
            session.activate()
        }
    }
}

extension AppDelegate: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("session did activate with state: \(activationState.rawValue), and error: \(error)")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("session did become inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("session did deactivate")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        //FIXME: Send reply of updated succeeded
        print("did receive message: \(message)")

        if let language = message["selectedLanguage"] as? String {
            if UIApplication.shared.applicationState == .background {
                updateLanguageOnBackground(language: language, replyHandler: { (wasSuccessful) in
                    replyHandler(["updated": wasSuccessful])
                })
            }
            else {
                RepositoriesUpdateManager.shared.update(withLanguage: language, completion: { (wasSuccessful) in
                    replyHandler(["updated": wasSuccessful!])
                })
            }
        }
        replyHandler(["updated": false])
    }
    
    private func updateLanguageOnBackground(language: String, replyHandler: @escaping ([String : Any]) -> Void) {
        let taskID = self.beginBackgroundUpdateTask()
        
        RepositoriesUpdateManager.shared.update(withLanguage: language, completion: { (wasSuccessful) in
            replyHandler(["updated": true])
            self.endBackgroundUpdate(taskID: taskID)
        })
        replyHandler(["updated": false])
        self.endBackgroundUpdate(taskID: taskID)
    }
    
    func beginBackgroundUpdateTask() -> UIBackgroundTaskIdentifier {
        return UIApplication.shared.beginBackgroundTask(expirationHandler: {})
    }
    
    func endBackgroundUpdate(taskID: UIBackgroundTaskIdentifier) {
        UIApplication.shared.endBackgroundTask(taskID)
    }
}
