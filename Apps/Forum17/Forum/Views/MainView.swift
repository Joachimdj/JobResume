//
//  Mainview.swift
//
//
//  Created by Goktug Yilmaz on 14/11/15.
//  Copyright © 2015 Goktug Yilmaz. All rights reserved.
//

import UIKit 
import EZSwipeController // if using Cocoapods


class MainView: EZSwipeController {
    let discoverButton = UIButton()
    let happeningButton = UIButton()
    override func setupView() {
        datasource = self
        //        navigationBarShouldBeOnBottom = true
        //        navigationBarShouldNotExist = true
        //        cancelStandardButtonEvents = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.moveToPage(1)
        
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
extension MainView: EZSwipeControllerDataSource {
    
    func viewControllerData() -> [UIViewController] {
        
        
        return [MyProgram(), ViewController1(), Auction()]
    }
    
    func navigationBarDataForPageIndex(_ index: Int) -> UINavigationBar {
        var title = ""
        if index == 0 {
            title = "Dit program"
        } else if index == 1 {
            title = "Programmet"
        } else if index == 2 {
            title = "Auktionen"
        }
        
        let navigationBar = UINavigationBar()
        navigationBar.barStyle = UIBarStyle.default
        navigationBar.barTintColor = UIColor(red: 142.0/255, green: 122.0/255, blue: 183.0/255, alpha: 1.0)
        
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        
        let navigationItem = UINavigationItem(title: title)
        navigationItem.hidesBackButton = true
      
        navigationBar.pushItem(navigationItem, animated: false)
        
       if index == 0 {
            var sImage = UIImage(named: "ic_list")!
            sImage = scaleTo(image: sImage, w: 22, h: 22)
            let rightButtonItem = UIBarButtonItem(image: sImage, style: .plain, target: self, action: nil)
             rightButtonItem.tintColor = UIColor.white
            
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = rightButtonItem
        } else if index == 1 {
            var cImage = UIImage(named: "heartDark")!
            cImage = scaleTo(image: cImage, w: 22, h: 22)
            let leftButtonItem = UIBarButtonItem(image: cImage, style: .plain, target: self, action: nil)
            leftButtonItem.tintColor = UIColor.white
            
            var bImage = UIImage(named: "auction")!
            bImage = scaleTo(image: bImage, w: 22, h: 22)
            let rightButtonItem = UIBarButtonItem(image: bImage, style: .plain, target: self, action: nil)
            rightButtonItem.tintColor = UIColor.white
            
            navigationItem.leftBarButtonItem = leftButtonItem
            navigationItem.rightBarButtonItem = rightButtonItem
            
        } else if index == 2 {
            var sImage = UIImage(named: "ic_list")!
            sImage = scaleTo(image: sImage, w: 22, h: 22)
            let leftButtonItem = UIBarButtonItem(image: sImage, style: .plain, target: self, action: nil)
            leftButtonItem.tintColor = UIColor.white
            
            navigationItem.leftBarButtonItem = leftButtonItem
            navigationItem.rightBarButtonItem = nil
        }
 
        
        return navigationBar
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent;
    }
    func animateButton(_ sender:AnyObject) {
        print("animateButton")
        
        
        
        if(sender.tag == 0){
            happeningButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: 0.2,delay: 0, usingSpringWithDamping: 0.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.allowUserInteraction,  animations: {
                self.happeningButton.transform = CGAffineTransform.identity
                },
                                       completion: { finished in
                                        self.discoverButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                                        self.happeningButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                                        NotificationCenter.default.post(name: Notification.Name(rawValue: "loadNewCards"), object: 0)
                                        
                }
            )
            
        }
        else
        {
            discoverButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: 0.2,delay: 0, usingSpringWithDamping: 0.0, initialSpringVelocity: 0.0,  options: UIViewAnimationOptions.allowUserInteraction,  animations: {
                self.discoverButton.transform = CGAffineTransform.identity
                },
                                       completion: { finished in
                                        self.happeningButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                                        self.discoverButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                                        NotificationCenter.default.post(name: Notification.Name(rawValue: "loadNewCards"), object: 1)
                                        
                                        
                }
            )
        }
    }
    
    func changedToPageIndex(_ index: Int) {
        print("Page has changed to: \(index)")
        if(index == 1){
            
            
            UIView.animate(withDuration: 0.2, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                mapButton.alpha = 1.0
                
                }, completion: nil)
        
        } else {
            UIView.animate(withDuration: 0.2, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                mapButton.alpha = 0.0
                
                }, completion: nil)
            }
        
        
    }
    
    func moveToEnd() {
        self.moveToPage(2)
    }
    
    func alert(title: String?, message: String, action: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

private func scaleTo(image: UIImage, w: CGFloat, h: CGFloat) -> UIImage {
    let newSize = CGSize(width: w, height: h)
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
}
 
