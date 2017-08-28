//
//  AuctionList.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import UIKit
import Kingfisher

class AuctionListView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var ac = AuctionController()
    var uc = UserController()
    var tableView = UITableView()
    var line = UIView(frame:CGRect(x:5,y:55, width:UIScreen.main.bounds.width - 10,height:1))
    var titleLabel = UILabel(frame:CGRect(x:10,y:27, width:UIScreen.main.bounds.width - 20,height:20))
    var container = [AuctionItem]()
    var blurEffectView = UIVisualEffectView()
    var loggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        titleLabel.text = "Auktionen".uppercased()
        titleLabel.font = UIFont (name: "HelveticaNeue-Bold", size: 25)
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
        
        line.backgroundColor = .black
        self.view.addSubview(line)
        
        
        tableView.frame         =   CGRect(x:0,y:56, width:self.view.frame.width,height:self.view.frame.height - 103);
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.register(AuctionListCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 110
        tableView.separatorColor = .clear
        
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.0
        self.tableView.addSubview(blurEffectView)
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(uc.uc.userContainer.count == 0)
        {
            loggedIn = false
        }
        else
        {
            loggedIn = true
        }
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            self.blurEffectView.alpha = 0.0
        }, completion: nil)
        container = ac.a.AuctionItemContainer
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return container.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AuctionListCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AuctionListCell
        cell.backgroundColor = .clear
        let item = container[indexPath.row]
        if(item.image !=  "" && item.image !=  nil)
        {
            if((URL(string:item.image!)) != nil)
            {
                cell.profileImageView.kf.setImage(with:URL(string:item.image!)!, placeholder: UIImage(named:"noPic"), options: nil, progressBlock: nil, completionHandler: { (image, error, CacheType, imageURL) in  })
            }
        }
        else
        {
            cell.profileImageView.image = UIImage(named: "noPic")
        }
        cell.titleLabel.text = item.name?.uppercased()
        cell.donator.text = "Startbud: \(item.startBid!) DKK"
        cell.startBid.text = "\(item.donator!)"
        cell.selectionStyle = .none
        print(User.favoriteAuctionItems.count)
        if((User.favoriteAuctionItems.filter{$0.id == item.id}.count) > 0)
        {   container[indexPath.row].favorit = true
            cell.favorite.setImage(UIImage(named:"heartDark"), for: UIControlState())
            cell.favorite.addTarget(self, action: #selector(addFavorite(_:)), for: UIControlEvents.touchUpInside)
            cell.favorite.tag = indexPath.row
            
        }
        else
        {
            container[indexPath.row].favorit = false
            cell.favorite.setImage(UIImage(named:"heart"), for: UIControlState())
            cell.favorite.addTarget(self, action: #selector(addFavorite(_:)), for: UIControlEvents.touchUpInside)
            cell.favorite.tag = indexPath.row
        }
        if(loggedIn == false)
        {
            cell.favorite.alpha = 0.0
        }
        else
        {
            cell.favorite.alpha = 1.0
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {  
            self.blurEffectView.alpha = 1.0
        }, completion: nil)
        
        let vc = AuctionItemView()
        let item = container[indexPath.row]
        vc.ac = [item]
        vc.row = indexPath.row
        
        
         self.present(vc, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let favorite = UITableViewRowAction(style: .normal, title: "RET") { action, index in
            print("favorite button tapped")
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                
                self.blurEffectView.alpha = 1.0
            }, completion: nil)
            
            let vc = EditView()
            let item = self.container[editActionsForRowAt.row]
            vc.row = editActionsForRowAt.row
            vc.ac = [item]
            self.present(vc, animated: true, completion: nil)
        }
        
        favorite.backgroundColor = .lightGray
        
        return [favorite]
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if(uc.uc.userContainer.count > 0 && uc.uc.userContainer[0].admin == 1)
        {
            return true
        }
        else
        {
            return false
        }
    }
    func addFavorite(_ sender:AnyObject)
    {
        
        let item = container[sender.tag]
        
        if(item.favorit  ==  false)
        {
            print("addFavorite")
            container[sender.tag].favorit = true
            _ = uc.addToFavoritList(type: "auction", lecture: nil, auctionItem:item)
        }
        else
        {
            print("removeFavorite")
            container[sender.tag].favorit = false
            _ = uc.removeFromFavoritList(type: "auction", lecture: nil, auctionItem:item)
        }
        let indexPath = IndexPath(item:sender.tag, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .fade)
        
    }
    
    func add(sender:AnyObject)
    {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
          
            self.blurEffectView.alpha = 1.0
        }, completion: nil)
        
        let vc = EditView()
        vc.ac = [AuctionItem(JSON: ["id" : "","name":"","desc":"","donator":"","image":"","donatorImage":"","endDate":"16-09-2019 20:00","startBid":0.0,"status":0.0])!]
        self.present(vc, animated: true, completion: nil)
    }
}
