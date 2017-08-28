//
//  AppDelegate.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import UserNotifications
import FirebaseMessaging
import FBSDKCoreKit
import GoogleSignIn


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,GIDSignInDelegate{

    var window: UIWindow?
    var timer = Timer()
    var counter = 0
    
    override init() {
        FirebaseApp.configure()
       
    }
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
 
        
        if self.window!.rootViewController as? UITabBarController != nil {
            let tababarController = self.window!.rootViewController as! UITabBarController
            tababarController.selectedIndex = 1
        }
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
  
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        
        registerBackgroundTask()
   
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

        
        return true
    } 
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
     
        if let error = error {
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        print(authentication)
        UserController().loginWithGoogle(token: authentication.idToken, accessToken:  authentication.accessToken, profile: user.profile) { (result) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissLogin"), object: 1)
        }
    }
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
      
        UserController().logOut { (result) in
            signIn.disconnect()
            print(result)
        }
    }
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        if(url.absoluteString.contains("google") == true)
        {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissLogin"), object: 0)
            
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
        }
        else
        {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissLogin"), object: 0)
            
             return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: options[.sourceApplication] as! String!, annotation: options[.annotation])
        }
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    //Use this function if you are using iOS9, handleOpenUrl has been deprecated
    func application(app: UIApplication, openURL url: URL, options: [String : AnyObject]) -> Bool
    {
        print(url)
        print(options)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissLogin"), object: 0)
        
        FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options["UIApplicationOpenURLOptionsSourceApplicationKey"] as! String, annotation: options["UIApplicationOpenURLOptionsAnnotationKey"])
        return true
        
    }
 
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
         
         //   self?.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskInvalid)
        timer = Timer.scheduledTimer(timeInterval: 1200.0, target:self, selector: #selector(getData), userInfo: nil, repeats: true)
        timer.fire()
 
    }
 
    
    func getData(){

            DispatchQueue.global(qos: .background).async { // 1
                if(Messaging.messaging().fcmToken != nil)
                {
                    _ = MessageController().upcomingLectures(reciver:  Messaging.messaging().fcmToken!, completion: { (result) in
                        print("messageSendt")
                    })
                }
                DispatchQueue.main.async { // 2
                    
                }
            }
        print("get")
        print(counter)
    }
    
        
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken as Data
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        Messaging.messaging().subscribe(toTopic: "all")
        
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
      
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }

    
   

}

