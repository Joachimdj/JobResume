//
//  MapView.swift
//  Forum
//
//  Created by Joachim Dittman on 16/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import UIKit

class MapView: UIViewController {

    var imageView = UIImageView()
    
    var scrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        MapController().loadMap { (result) in
        self.imageView.kf.setImage(with: URL(string:result)!, placeholder: nil, options: nil, progressBlock: { (start, end) in
            
        }) { (image, error, CacheType, URL) in
            // 1
            self.imageView = UIImageView(image: image)
            self.imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size:(image?.size)!)
            self.scrollView.addSubview(self.imageView)
            
            // 2
            self.scrollView.contentSize = (image?.size)!
            
            // 4
            let scrollViewFrame = self.scrollView.frame
            let scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width
            let scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height
            let minScale = min(scaleWidth, scaleHeight);
            self.scrollView.minimumZoomScale = minScale;
            
            // 5
            self.scrollView.maximumZoomScale = 0.5
            self.scrollView.zoomScale = minScale;
            self.scrollView.backgroundColor = .white
            
            // 6
            self.scrollView.frame = CGRect(x:0,y:20,width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height - 65)
            self.centerScrollViewContents()
            self.view.addSubview(self.scrollView)
            }
        }
             // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = imageView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        imageView.frame = contentsFrame
    }
 
 
}
