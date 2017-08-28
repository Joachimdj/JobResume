//
//  LoadMapController.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import UIKit

class MapController
{

    //Loads map image file from database
    func loadMap(completion:@escaping (_ result:String) -> Void)
    {
        Network().getMapURL(test: false) { (result) in
          
       
        completion(result.stringValue)
        }
    }
}
