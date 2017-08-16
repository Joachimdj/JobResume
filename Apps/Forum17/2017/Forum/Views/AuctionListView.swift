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

    override func viewDidLoad() {
        super.viewDidLoad()
   
        container = ac.a.AuctionItemContainer
        
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
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        if(item.image !=  nil)
        {
            if((URL(string:item.image!)) != nil)
            {
                cell.profileImageView.kf.setImage(with:URL(string:item.image!)!, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, CacheType, imageURL) in  })
            }
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AuctionItemView()
        let item = container[indexPath.row]
        vc.ac = [item]
        
        self.present(vc, animated: true, completion: nil)
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
}
