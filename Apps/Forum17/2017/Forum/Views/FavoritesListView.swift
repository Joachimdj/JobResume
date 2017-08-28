//
//  FavoritesList.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import UIKit

class FavoritesListView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
 
    var uc = UserController()
    
    var tableView = UITableView()
    
    var lectureContainer = [Lecture]()
    var auctionContainer = [AuctionItem]()
    let typeImagesArray = ["cirkel_workshop","cirkel_social","Cirkel_debat","cirkel_firehose","cirkel_3roundBurst","cirkel_talk"]
    var dayNames = ["Fredag","Lørdag","Søndag"]
    
    let items = ["Program","Auktion"]
    var daySC = UISegmentedControl()
    var type = 0
    
    var line = UIView(frame:CGRect(x:5,y:55, width:UIScreen.main.bounds.width - 10,height:1))
    var titleLabel = UILabel(frame:CGRect(x:10,y:27, width:UIScreen.main.bounds.width - 20,height:20))
    
    var blurEffectView = UIVisualEffectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        titleLabel.text = "Din oversigt".uppercased()
        titleLabel.font = UIFont (name: "HelveticaNeue-Bold", size: 25)
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
        
        line.backgroundColor = .black
        self.view.addSubview(line)
        
        
        let bImage = UIButton()
        bImage.frame = CGRect(x: -10,y: 2,width: 70,height: 70)
        bImage.setImage(UIImage(named: "ic_exit_to_app")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
        bImage.tintColor = UIColor.black
        bImage.addTarget(self, action: #selector(logOut(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(bImage)
        
        daySC = UISegmentedControl(items: items)
        daySC.selectedSegmentIndex = 0
        let frame = UIScreen.main.bounds
        daySC.frame = CGRect(x:-2, y:55, width: frame.width + 4,height: 30)
        daySC.addTarget(self, action: #selector(changeColor(sender:)), for: .valueChanged)
        daySC.tintColor = .black
        self.view.addSubview(daySC)
        
        tableView.frame         =   CGRect(x:0,y:85, width:self.view.frame.width,height:self.view.frame.height - 132);
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.register(LectureCell.self, forCellReuseIdentifier: "LectureCell")
        tableView.register(AuctionListCell.self, forCellReuseIdentifier: "AuctionListCell")
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 75
        tableView.separatorColor = .clear
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
        print("FavoriteListView")
        if(type == 0)
        {   tableView.rowHeight = 75
            if(User.userContainer.count > 0)
            {
                
                reloadLectureFavorite()
            }
            
        
        }
        else
        {   tableView.rowHeight = 110
            if(User.userContainer.count > 0)
            {
             
                reloadAuctionFavorite()
            }
          
        }
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.blurEffectView.alpha = 0.0
        }, completion: nil)
    }
    
    func changeColor(sender: UISegmentedControl) {
        type = sender.selectedSegmentIndex
        if(type == 0)
        {     tableView.rowHeight = 75
              reloadLectureFavorite()
            
        }
        else
        {   tableView.rowHeight = 110
            reloadAuctionFavorite()
            
        }
        self.tableView.reloadData()
    }
    func reloadLectureFavorite()
    {
        lectureContainer.removeAll()
        let con = uc.uc.favoriteLectures
        var index = 0
        while (index < 3) {
            for i in con[index]!
            {
                i.day = index
                lectureContainer.append(i)
            }
            index += 1
        }
           self.tableView.reloadData()
    }
    
    func reloadAuctionFavorite()
    {
        print("reload auction")
        auctionContainer = uc.uc.favoriteAuctionItems
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(type == 0)
        {
        return  lectureContainer.count
        }
        else
        {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(type == 0){
        let i = lectureContainer
        var index = section
        if(section - 1 < 0)
        {
            index = 0
        }
        if(index > 0)
        {
            
            if("\(dayNames[i[section].day])\(i[section].startTime!)\(i[section].endTime!)" != "\(dayNames[0])\(i[section - 1].startTime!)\(i[section - 1].endTime!)")
            {
                return"\(dayNames[i[section].day]) \(String(describing: i[section].startTime!)) - \(i[section].endTime!)"
            }
            else
            {
                return ""
            }
        }
        else
        {
            return "\(dayNames[i[section].day]) \(String(describing:i[section].startTime!)) - \(i[section].endTime!)"
        }
        }
        else
        {
            return ""
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(type == 1)
        {
            return auctionContainer.count
        }
        return 1
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if(type == 0)
        {
        let cell:LectureCell = tableView.dequeueReusableCell(withIdentifier: "LectureCell", for: indexPath) as! LectureCell
        cell.favorite.setImage(UIImage(named:"heartDark"), for: UIControlState())
        cell.favorite.addTarget(self, action: #selector(updateFavorite(_:)), for: UIControlEvents.touchUpInside)
      
        let item = lectureContainer[indexPath.section]
        cell.typeImage.image = UIImage(named: typeImagesArray[Int(item.type!)!])
        cell.titleLabel.text = item.name?.uppercased()
        cell.placeLabel.text = item.place
        cell.favorite.tag = indexPath.section
        cell.selectionStyle = .none
            
        return cell
        }
        else
        {
            let cell:AuctionListCell = tableView.dequeueReusableCell(withIdentifier: "AuctionListCell", for: indexPath) as! AuctionListCell
            cell.favorite.setImage(UIImage(named:"heartDark"), for: UIControlState())
            cell.favorite.addTarget(self, action: #selector(updateFavorite(_:)), for: UIControlEvents.touchUpInside)
            
            let item = auctionContainer[indexPath.row]
            if(item.image !=  nil)
            {
                if((URL(string:item.image!)) != nil)
                {
                    cell.profileImageView.kf.setImage(with:URL(string:item.image!)!, placeholder: UIImage(named:"noPic"), options: nil, progressBlock: nil, completionHandler: { (image, error, CacheType, imageURL) in  })
                }
            }
            cell.titleLabel.text = item.name?.uppercased()
            cell.startBid.text = "Startbud: \(item.startBid!) DKK"
            cell.donator.text = "\(item.donator!)"
            cell.favorite.tag = indexPath.row
            cell.selectionStyle = .none
            
            return cell
        }
  
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.blurEffectView.alpha = 1.0
        }, completion: nil)
        if(type == 0)
        {
        let vc = LectureItemView()
        let item = lectureContainer[indexPath.section]
        vc.lc = [item]
        
        self.present(vc, animated: true, completion: nil)
        }
        else
        {
            let vc = AuctionItemView()
            let item = auctionContainer[indexPath.section]
            vc.ac = [item]
            self.present(vc, animated: true, completion: nil)
        }
    }
    
 
    func updateFavorite(_ sender:AnyObject)
    {
        
        if(type == 0)
        {
        let item = lectureContainer[sender.tag]
        print("updateFavorite")
        _ = uc.removeFromFavoritList(type: "lecture", lecture: item, auctionItem: nil)
        reloadLectureFavorite()
        }
        else
        {
            let item = auctionContainer[sender.tag]
            print("updateFavorite")
            _ = uc.removeFromFavoritList(type: "auction", lecture: nil, auctionItem: item)
            reloadAuctionFavorite()
        }
        
    }
    
    func logOut(sender:AnyObject)
    {
        loadedFirst = false
        loggedIn = false
        self.tabBarController?.selectedIndex = 1
        let vc = LoginView()
        vc.logOut = true
        self.present(vc,animated: true,completion: nil)
    }
    
}
