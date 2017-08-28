 
//
//  LoginView.swift
//  Botler
//
//  Created by Joachim Dittman on 29/03/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import UIKit
import Eureka
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import FirebaseAuth
import GoogleSignIn
import pop
 
class LoginView: UIViewController,GIDSignInUIDelegate,FBSDKLoginButtonDelegate
{
    
    
    var uc = UserController()
    let facebookButton = FBSDKLoginButton()
    var loginButton = GIDSignInButton()
    var skipButton = UIButton()
    var imageView = UIImageView()
    var welcomeString = UILabel()
    var infoString = UITextView()
    var logOut = false
    var blurEffectView = UIVisualEffectView()
    var loadingImage = UIImageView()
    
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.global(qos: .default).async { // 1
            if(self.logOut == true)
            {
                self.uc.logOut { (result) in
                    GIDSignIn.sharedInstance().signOut()
                    FBSDKLoginManager().logOut()
                    self.logOut = false
                    UIView.animate(withDuration: 0.5) {
                        DispatchQueue.main.async { // 2
                              self.blurEffectView.alpha = 0.0
                        }
                   
                    }
                    
                }
            }
          
        }
     
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurEffectView.alpha = 0.0
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if(logOut == true)
        {
            blurEffectView.alpha = 1.0
        }
        else
        {
            blurEffectView.alpha = 0.0
        }
        
        self.view.backgroundColor =   .white
        
        GIDSignIn.sharedInstance().uiDelegate = self
    

        facebookButton.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(dismiss(notification:)), name: NSNotification.Name(rawValue: "dismissLogin"), object: nil)
        
        imageView.image = UIImage(named: "bifrost")
        imageView.frame = CGRect(x: (UIScreen.main.bounds.width/2.5) - (UIScreen.main.bounds.width/6), y:UIScreen.main.bounds.height/6, width:UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
        self.view.addSubview(imageView)
      
        
        loadingImage.image = UIImage(named: "bifrostLogo")
        loadingImage.frame = CGRect(x: (UIScreen.main.bounds.width/2) - 37.5, y:(UIScreen.main.bounds.height/2) - 37.5, width:75, height: 75)
        
        welcomeString.frame = CGRect(x:0, y:imageView.frame.origin.y * 2.2, width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/2)
        welcomeString.text = "Velkommen til Forum appen."
        welcomeString.textColor = .black
        welcomeString.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        
        welcomeString.textAlignment = .center
        
        self.view.addSubview(welcomeString)
        
        
        infoString.frame = CGRect(x:15, y:imageView.frame.origin.y * 3.5, width:UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.width/2)
        infoString.text = ""
        infoString.textColor = .black
        infoString.isUserInteractionEnabled = false
        infoString.font = UIFont(name: "AmericanTypewriter", size: 20)
        
        infoString.textAlignment = .center
        
        self.view.addSubview(infoString)
        
        
        facebookButton.frame = CGRect(x: 15, y:UIScreen.main.bounds.height - 145, width:UIScreen.main.bounds.width - 30, height: 40)
        loginButton.frame = CGRect(x: 10, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width - 21, height: 40)
        loginButton.style = .wide
        loginButton.colorScheme = .dark
        let buttonText = NSAttributedString(string: "Log ind med Facebook")
        facebookButton.setAttributedTitle(buttonText, for: .normal)
        facebookButton.backgroundColor = UIColor.init(fromHexString:"#3B5998")
        facebookButton.setTitle("Login with Facebook", for: UIControlState.normal)
        facebookButton.defaultAudience = .everyone 
        
        skipButton.frame =  CGRect(x:0,y:self.view.frame.height - 35, width:self.view.frame.width,height:20)
        skipButton.setTitle("Spring over", for: .normal)
        skipButton.setTitleColor(.blue, for: .normal)
        skipButton.backgroundColor = UIColor.white
        skipButton.titleLabel?.font = UIFont(name: "AmericanTypewriter-Light"   , size: 16)
        skipButton.addTarget(self, action: #selector(dismiss(sender:)), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(facebookButton)
         self.view.addSubview(loginButton)
        self.view.addSubview(skipButton)
        self.view.addSubview(blurEffectView)
        
        self.blurEffectView.addSubview(loadingImage)
    }
    
    func pulsate(object: UIImageView) {
        let pulsateAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY) 
        object.layer.pop_add(pulsateAnim, forKey: "layerScaleSpringAnimation")
        pulsateAnim?.velocity = CGPoint(x:0.1, y:0.1)
        pulsateAnim?.toValue = CGPoint(x:1.2, y:1.2)
        pulsateAnim?.springBounciness = 40
        pulsateAnim?.dynamicsFriction = 20
        pulsateAnim?.springSpeed = 5.0
     
    }
    
    func dismiss(sender:AnyObject)
    {
        print("dismiss")
       
 
        UIView.animate(withDuration: 0.5) {
            self.blurEffectView.alpha = 1.0
            self.pulsate(object: self.loadingImage)
        }
        pulsate(object: loadingImage)
        UserController().loginWithNoUser { (result) in
            
              self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    func dismiss(notification:NSNotification)
    {
        if(notification.object as! Int == 0)
        {
            
            UIView.animate(withDuration: 0.5) {
                self.blurEffectView.alpha = 1.0
                self.pulsate(object: self.loadingImage)
            }
        }
        else
        {
            UIView.animate(withDuration: 0.5) {
                self.blurEffectView.alpha = 0.0
                self.loadingImage.removeFromSuperview()
            }
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error?) {
        if let error = error {
            blurEffectView.alpha = 1.0
            pulsate(object: loadingImage)
            print(error.localizedDescription)
            return
        }
        
        returnUserData()
    }
    
 
 
    
    //returnUSerData from Facebook
    func returnUserData()
    {
        print("\(FBSDKAccessToken.current().tokenString)")
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me?fields=id,name,email,picture.type(large)", parameters: nil)
        graphRequest.start(completionHandler: { (connection, data, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error!)")
            }
            else
            {
                print(data!)
                
               UserController().loginWithFacebook(fbToken: FBSDKAccessToken.current().tokenString, fbResult: data,missingInfo:["":""],completion: { (result) in
                
                    self.dismiss(animated: true, completion: nil)
               })
                
        
            }
        })
    }
    
}
