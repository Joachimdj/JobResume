//
//  LectureList.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import UIKit
import FirebaseAuth
import pop

var loadedFirst = false
var loggedIn = false
var tableLoaded = false

class LectureListView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var ll = LectureController()
    var uc = UserController()
    var ac = AuctionController()
    
    var tableView = UITableView()
    
    var container = [Lecture]()
    let typeImagesArray = ["cirkel_workshop","cirkel_social","Cirkel_debat","cirkel_firehose","cirkel_3roundBurst","cirkel_talk"]
    
    var line = UIView(frame:CGRect(x:5,y:55, width:UIScreen.main.bounds.width - 10,height:1))
    var titleLabel = UILabel(frame:CGRect(x:10,y:27, width:UIScreen.main.bounds.width - 20,height:20))
    
    var blurEffectView = UIVisualEffectView()
    
    let items = ["Fredag", "Lørdag", "Søndag"]
    var daySC = UISegmentedControl()
    var day = 0
    var dataLoaded = false
    
    var loadingImage = UIImageView()
    
   let defaults = UserDefaults.standard
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        if(defaults.object(forKey:"newDownload") == nil)
        {
           
            uc.logOut(completion: { (Bool) in
               self.defaults.set(true, forKey: "newDownload")
            })
        }
        
      
        titleLabel.text = "Programmet".uppercased()
        titleLabel.font = UIFont (name: "HelveticaNeue-Bold", size: 25)
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
     
        line.backgroundColor = .black
        self.view.addSubview(line)

        loadingImage.image = UIImage(named: "bifrostLogo")
        loadingImage.frame = CGRect(x: (UIScreen.main.bounds.width/2) - 37.5, y:(UIScreen.main.bounds.height/2) - 37.5, width:75, height: 75)
        
        
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
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        UIView.animate(withDuration: 0.5) {
            self.blurEffectView.alpha = 1.0
            self.pulsate(object: self.loadingImage)
        }
        self.view.addSubview(blurEffectView)
        self.blurEffectView.addSubview(loadingImage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
           print("users\(uc.uc.userContainer.count)")
      if(uc.uc.userContainer.count > 0)
      {
     
        loggedIn = true
      }
        if(loadedFirst == false)
        {
              print("loadedFirst")
            
            uc.checkUsersLoginStatus(test: false, completion: { (result) in
                if(result == true)
                {
                    print("loadedIN")
                self.ll.loadLectures(test: false) { (result) in
                    self.container = result[0]!
                    //Loading auction items
                    _ =   self.uc.getFavoriteLectures(test: false, completion: { (result) in
                        self.tableView.reloadData()
                        self.dataLoaded = true
                        UIView.animate(withDuration: 0.5) {
                        self.blurEffectView.alpha = 0.0
                        }
                               loggedIn = true
                     
                    })
                    
                    
                    }
                self.ac.loadAuctionItems { (result) in
                    
                    _ = self.uc.getFavoriteAuctionItems(test: false, completion: { (result) in
                    })
                }
                    loadedFirst = true
                }
                else
                {
                    print("usercheck failed")
                    let vc = LoginView()
                     self.present(vc, animated: false, completion: nil)
                }
            })
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
         UIApplication.shared.applicationIconBadgeNumber = 0
        if(dataLoaded == true)
        {
        ll.lecturesFromLocalMemory(day: day) { (result) in
            self.container = result 
            self.tableView.reloadData()
        }
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.blurEffectView.alpha = 0.0
        }, completion: nil)
        }
    }
    
    func changeColor(sender: UISegmentedControl) {
            day = sender.selectedSegmentIndex
            ll.lecturesFromLocalMemory(day: day, completion: { (result) in
               container = result
               self.tableView.reloadData()
            })
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
        
        cell.alpha = 0.0
        var duration = 0
        var delay = 0.0
        if(tableLoaded == false)
        {
            duration = 1
            delay = Double(0.25)
        }
        UIView.animate(withDuration: TimeInterval(duration), delay: delay * Double(indexPath.section),options: UIViewAnimationOptions.curveEaseIn,animations: {
            if(loggedIn == false)
            {
                cell.alpha = 0.0
            }
            else
            {
                cell.alpha = 1.0
            }
        })
     
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        view.alpha = 0.0
        var duration = 0
        var delay = 0.0
        if(tableLoaded == false)
        {
            duration = 1
            delay = Double(0.25)
        }
        UIView.animate(withDuration: TimeInterval(duration), delay: delay * Double(section),options: UIViewAnimationOptions.curveEaseIn,animations: {
           view.alpha = 1.0
        })
        if(section == container.count - 1)
        {
            print("tableLoaded")
            tableLoaded = true
        }
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.blurEffectView.alpha = 1.0
        }, completion: nil)
        
        let vc = LectureItemView()
        let item = container[indexPath.section]
         vc.lc = [item]
        
        self.present(vc, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
    
        let favorite = UITableViewRowAction(style: .normal, title: "RET") { action, index in
            print("favorite button tapped")
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.blurEffectView.alpha = 1.0
            }, completion: nil)
            let vc = EditView()
            let item = self.container[editActionsForRowAt.section]
            vc.lc = [item]
            vc.day = self.day
            vc.row = editActionsForRowAt.section
            
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
    
    func add(sender:AnyObject)
    {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.blurEffectView.alpha = 1.0
        }, completion: nil)
        let vc = EditView()
        let item = Lecture(JSON: ["id" : "","title":"","endTime":"10:00","startTime":"12:00","place":"","type":"1","headerImage":"","lecturer":["":["":""]],"description":""])!
        item.day = day
        
        vc.lc = [item]
        vc.day = self.day
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func pulsate(object: UIImageView) {
        let pulsateAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        object.layer.pop_add(pulsateAnim, forKey: "layerScaleSpringAnimation")
        pulsateAnim?.velocity = CGPoint(x:0.1, y:0.1)
        pulsateAnim?.toValue = CGPoint(x:1.2, y:1.2)
        pulsateAnim?.springBounciness = 40
        pulsateAnim?.dynamicsFriction = 20
        pulsateAnim?.springSpeed = 5.0
        
    }
}
