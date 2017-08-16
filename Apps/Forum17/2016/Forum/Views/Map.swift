//
//  Map.swift
//  Forum
//
//  Created by Joachim Dittman on 05/08/2016.
//  Copyright © 2016 Joachim Dittman. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase


class Map: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let mapButton = UIButton()
         let map = UIImageView(frame: CGRect(x: 0,y: 20, width: screenWidth, height: screenHeight))
        mapButton.frame = CGRect(x: 10,y: 30, width: 40,height: 40);
        mapButton.setImage(UIImage(named: "ic_close")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
        mapButton.layer.borderWidth = 4.0
        mapButton.layer.borderColor = UIColor.black.cgColor
        mapButton.tintColor = UIColor.white
        mapButton.clipsToBounds = true;
        mapButton.backgroundColor = UIColor.red
        mapButton.layer.cornerRadius = mapButton.frame.width/2;
        mapButton.addTarget(self, action: #selector(Map.dismissView(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(mapButton)
        
        let ref = FIRDatabase.database().reference()
        ref.child("mapUrl").observe(FIRDataEventType.value, with: { (snapshot) in
            
            let dataString =  snapshot.value!
            print(dataString)
          
                let URLProfile = URL(string:dataString as! String)!
                map.kf.setImage(with: URLProfile, placeholder: UIImage(named: "bifrost"), options: nil, progressBlock: nil, completionHandler: { (image, error, CacheType, imageURL) in
               
                })
            self.view.addSubview(map)
          
            self.view.addSubview(mapButton)
        })
        
      
      
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dismissView(_ sender:AnyObject)
    {
    self.dismiss(animated: true, completion: nil)
        mapButton.alpha = 1.0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
