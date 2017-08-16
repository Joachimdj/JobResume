//
//  MyProgram.swift
//  Forum
//
//  Created by Joachim Dittman on 04/08/2016.
//  Copyright © 2016 Joachim Dittman. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class Auction: UIViewController,UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    
    
    var tableView: UITableView  =   UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
        
        tableView.frame         =   CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height - 60);
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.rowHeight = 70
        tableView.register(ProgramCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
       
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    func reloadTable(_ notification:Notification) {
        print("reload")
        self.tableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        auctionContainer = auctionContainer.sorted{$0.0.createdAt < $0.1.createdAt}
        return  auctionContainer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ProgramCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProgramCell
        let AC = auctionContainer[indexPath.row]
   
        if(AC.image !=  "")
        {

        let URLProfile = URL(string:AC.image)!
        cell.profileImageView.kf.setImage(with: URLProfile, placeholder: UIImage(named: "bifrost"), options: nil, progressBlock: nil, completionHandler: { (image, error, CacheType, imageURL) in
            
        })
        }
        cell.firstMessage.text = "\(AC.name)"
        cell.userName.text = "Startbud: \(AC.bid) DKK"
        cell.secondMessage.text = "\(AC.donator)"
        cell.favorite.alpha = 0.0

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        selectedItem = indexPath.row
  
        DispatchQueue.main.async(execute: {
            self.present(AuctionInfo(), animated: true, completion: nil)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
