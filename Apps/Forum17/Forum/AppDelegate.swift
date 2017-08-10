//
//  AppDelegate.swift
//  Forum
//
//  Created by Joachim Dittman on 03/08/2016.
//  Copyright © 2016 Joachim Dittman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import SwiftyJSON
import UserNotifications
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    var window: UIWindow?
    var count = 0
    var updateTimer: Timer?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = MainView()
        window!.makeKeyAndVisible()
       _ =  preferredStatusBarStyle()
 
      /*    NotificationCenter.default.addObserver(self, selector: #selector(reinstateBackgroundTask), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        updateTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self,
                                           selector: #selector(refresh), userInfo: nil, repeats: true)
        registerBackgroundTask()

        */
        let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
      //  UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        return true
    }
  
 
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.lightContent;
    }
    
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
         application.applicationIconBadgeNumber = 0
    }
    
    func registerForPushNotifications(_ application: UIApplication) {
        let notificationSettings = UIUserNotificationSettings(
            types: [.badge, .sound, .alert], categories: nil)
        application.registerUserNotificationSettings(notificationSettings)
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != UIUserNotificationType() {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print(userInfo)
        let json  = JSON(userInfo)
        
       _ =  SweetAlert().showAlert("Besked", subTitle: "\(json["aps"]["alert"].stringValue)", style: AlertStyle.success)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenChars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
        var tokenString = ""
        
        for i in 0..<deviceToken.count {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        //Tricky line
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.unknown)
        print("Device Token:", tokenString)
    }


}

