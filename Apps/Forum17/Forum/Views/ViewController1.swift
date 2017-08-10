//
//  ViewController.swift
//  Pager
//
//  Created by Lucas Oceano on 12/03/2015.
//  Copyright (c) 2015 Cheesecake. All rights reserved.
//

import UIKit
import AASquaresLoading
class ViewController1: PagerController, PagerDataSource {

	var titles: [String] = []

	override func viewDidLoad() {
		super.viewDidLoad()
        loadAuctionItems()
		self.dataSource = self
 
        NotificationCenter.default.addObserver(self, selector: #selector(openIntro), name:NSNotification.Name(rawValue: "openIntro"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openMap), name:NSNotification.Name(rawValue: "openMap"), object: nil)
		// Setting up the PagerController with Name of the Tabs and their respective ViewControllers
		self.setupPager(
			tabNames: ["Fredag", "Lørdag", "Søndag"],
			tabControllers: [Program(),Program(),Program()])
        
        loadingSquare = AASquaresLoading(target: self.view, size: 40)
        loadingSquare.backgroundColor = UIColor(red: 142.0/255, green: 122.0/255, blue: 183.0/255, alpha: 1.0)
        loadingSquare.color = UIColor.white
        self.view.addSubview(loadingSquare)
        
	}
    
    func openIntro(_ notification:Notification)
    {
        self.present(ProgramInfo(), animated: true, completion: nil)
    }
    func openMap(_ notification:Notification)
    {
        self.present(Map(), animated: true, completion: nil)
     
    }

	// Customising the Tab's View
 
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
 

}
