//
//  LectureList.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import UIKit

class LectureListView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var ll = LectureController()
    var uc = UserController()
    var ac = AuctionController()
    
    var tableView = UITableView()
    
    var container = [Lecture]()
    let typeImagesArray = ["","cirkel_workshop","cirkel_social","Cirkel_debat","cirkel_firehose","cirkel_3roundBurst","cirkel_talk"]
    
    var line = UIView(frame:CGRect(x:5,y:55, width:UIScreen.main.bounds.width - 10,height:1))
    var titleLabel = UILabel(frame:CGRect(x:10,y:27, width:UIScreen.main.bounds.width - 20,height:20))
    
    
    let items = ["Fredag", "Lørdag", "Søndag"]
    var daySC = UISegmentedControl()
    var day = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        container = ll.loadLectures()[0]!
        _ = ac.loadAuctionItems()  
        _ = uc.getFavoriteAuctionItems()
        _ = uc.getFavoriteLectures()
       
        titleLabel.text = "Programmet".uppercased()
        titleLabel.font = UIFont (name: "HelveticaNeue-Bold", size: 25)
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
        
        line.backgroundColor = .black
        self.view.addSubview(line)
        
        
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
        tableView.register(LectureCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 75
        tableView.separatorColor = .clear
        self.view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func changeColor(sender: UISegmentedControl) {
           day = sender.selectedSegmentIndex
        switch sender.selectedSegmentIndex {
        case 0:
            container = ll.loadLectures()[0]!
            self.tableView.reloadData()
        case 1:
            container = ll.loadLectures()[1]!
            self.tableView.reloadData()
        default:
            container = ll.loadLectures()[2]!
        
            self.tableView.reloadData()
        }
     
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return  container.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var index = section
        if(section - 1 < 0)
        {
            index = 0
        }
        if(index > 0)
        {
            
        if("\(String(describing: container[section].startTime))\(container[section].endTime!)" != "\(String(describing: container[section - 1].startTime))\(container[section - 1].endTime!)")
        {
        return"\(String(describing: container[section].startTime!)) - \(container[section].endTime!)"
        }
        else
        {
            return ""
        }
        }
        else
        {
             return "\(String(describing: container[section].startTime!)) - \(container[section].endTime!)"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LectureCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LectureCell
        
        let item = container[indexPath.section]
        cell.typeImage.image = UIImage(named: typeImagesArray[Int(item.type!)!])
        cell.titleLabel.text = item.name?.uppercased()
        cell.placeLabel.text = item.place
        
        if((User.favoriteLectures[day]?.filter{$0.id == item.id}.count)! > 0)
        {   container[indexPath.section].favorit = true
            cell.favorite.setImage(UIImage(named:"heartDark"), for: UIControlState())
            cell.favorite.addTarget(self, action: #selector(addFavorite(_:)), for: UIControlEvents.touchUpInside)
            cell.favorite.tag = indexPath.section
            
        }
        else
        {
            container[indexPath.section].favorit = false
            cell.favorite.setImage(UIImage(named:"heart"), for: UIControlState())
            cell.favorite.addTarget(self, action: #selector(addFavorite(_:)), for: UIControlEvents.touchUpInside)
            cell.favorite.tag = indexPath.section
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = LectureItemView()
        let item = container[indexPath.section]
         vc.lc = [item]
        
        self.present(vc, animated: true, completion: nil)
    }

    
    func addFavorite(_ sender:AnyObject)
    {
    
        let item = container[sender.tag]
    
        if(item.favorit  ==  false)
        {
                print("addFavorite")
                container[sender.tag].favorit = true
            _ = uc.addToFavoritList(type: "lecture", lecture: item, auctionItem:nil)
        }
        else
        {
                print("removeFavorite")
             container[sender.tag].favorit = false
            _ = uc.removeFromFavoritList(type: "lecture", lecture: item, auctionItem: nil)
        }
        let indexPath = IndexPath(item: 0, section: sender.tag)
        self.tableView.reloadRows(at: [indexPath], with: .fade)
        
    }
}
