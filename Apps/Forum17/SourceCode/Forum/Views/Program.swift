//
//  Program.swift
//  Forum
//
//  Created by Joachim Dittman on 03/08/2016.
//  Copyright © 2016 Joachim Dittman. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import AASquaresLoading

class Program: UIViewController,UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
     
    var tableView: UITableView  =   UITableView()
    var lectureContainer = [lectureObject]()
    var firstLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        // Do any additional setup after loading the view, typically from a nib.
      
        tableView.frame         =   CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height - 100);
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.rowHeight = 70
        tableView.register(ProgramCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
        
      
        mapButton.frame = CGRect(x: screenWidth/2 - 30,y: screenHeight - 70, width: 60,height: 60);
        mapButton.setImage(UIImage(named: "map"), for: UIControlState())
        mapButton.layer.borderWidth = 4.0
        mapButton.layer.borderColor = UIColor.black.cgColor
        mapButton.clipsToBounds = true;
        mapButton.backgroundColor = UIColor.green
        mapButton.layer.cornerRadius = mapButton.frame.width/2;
        mapButton.addTarget(self, action: #selector(Program.showMap(_:)), for: UIControlEvents.touchUpInside)
        UIApplication.shared.keyWindow?.addSubview(mapButton)
  
        let ref = FIRDatabase.database().reference()
       
        ref.child("eventDates").observe(FIRDataEventType.value, with: { (snapshot) in
            
            let dataString = JSON(snapshot.value!)
           
            dateContainer.removeAll()
            for i in dataString
            {
                 programContainer.removeAll()
                for k in i.1["programItems"]
                {
                    self.lectureContainer.removeAll()
                    for l in k.1["lecturer"]
                    {
                        self.lectureContainer.append(lectureObject(id: l.0, name: l.1["name"].stringValue, image: l.1["image"].stringValue))
                    }
                    print(k.1["headerImage"].stringValue)
                     if(k.1["status"].intValue == 0){
                    programContainer.append(ProgramObject(id: k.0, name: k.1["title"].stringValue,date:i.1["date"].stringValue, headerImage:k.1["headerImage"].stringValue,lecturer:self.lectureContainer, startTime:k.1["startTime"].stringValue ,endTime:k.1["endTime"].stringValue,desc:k.1["description"].stringValue,place:k.1["place"].stringValue,type:k.1["type"].intValue))
                    }
                }
               programContainer.sort{$0.0.startTime < $0.1.startTime}
            
             dateContainer.append(dateObject(id: i.0, name: i.1["date"].stringValue, programObjects:  programContainer))
              
            } 
            self.tableView.reloadData()
            
             loadingSquare.stop()
            self.firstLoad = true
        })
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
         if(firstLoad == false){
        loadingSquare.start()
        }
        self.tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(firstLoad == true){
        loadingSquare.stop()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if(dateContainer.count > 0){return dateContainer[selectedProgram].programObjects.count + 1} else {return 0}
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(dateContainer[selectedProgram].programObjects.count > section)
        {
            return "\(dateContainer[selectedProgram].programObjects[section].startTime) - \(dateContainer[selectedProgram].programObjects[section].endTime)"
        }
        else
        {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ProgramCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProgramCell
         if(dateContainer[selectedProgram].programObjects.count > indexPath.section){
        let object = dateContainer[selectedProgram].programObjects[indexPath.section]
       
        cell.firstMessage.text = object.name
        cell.userName.text = object.place
        cell.secondMessage.text = typeArray[object.type]
        cell.profileImageView.image = UIImage(named: typeImagesArray[object.type])
        
        cell.favorite.addTarget(self, action: #selector(Program.addFavorite(_:)), for: UIControlEvents.touchUpInside)
        cell.favorite.tag = indexPath.section
        if(dict1.contains("\(dateContainer[selectedProgram].name)\(dateContainer[selectedProgram].programObjects[indexPath.section].id)"))
        {
            cell.favorite.setImage(UIImage(named:"heartDark"), for: UIControlState())
            
        }
        else
        {
         cell.favorite.setImage(UIImage(named:"heart"), for: UIControlState())
        }
        }
        else
        {
        cell.firstMessage.text = ""
        cell.profileImageView.image = UIImage(named: "")
        cell.secondMessage.text = ""
        cell.favorite.setImage(UIImage(named:""), for: UIControlState())
        cell.userName.text = ""
        
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
       selectedItem = indexPath.section
        yourdProgram = false
        DispatchQueue.main.async(execute: {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "openIntro"), object: 1)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func addFavorite(_ sender:AnyObject)
    {
        print("favorite")
        let itemString = "\(dateContainer[selectedProgram].name)\(dateContainer[selectedProgram].programObjects[sender.tag].id)"
        if(dict1.contains(itemString))
        {
            var tempDict = [String]()
            for i in dict1
            {
                print(i)
                print(itemString)
                
                if(i != itemString)
                {
                tempDict.append(i)
                }
                
            }
            dict1.removeAll()
            dict1 = tempDict
            print(dict1)
            
        }
        else
        {
            dict1.append("\(dateContainer[selectedProgram].name)\(dateContainer[selectedProgram].programObjects[sender.tag].id)")
        }
      self.tableView.reloadData()
        let defaults = UserDefaults.standard
        defaults.set(dict1, forKey: "SavedArray")
    }

    
    func showMap(_ sender:AnyObject)
    {
       mapButton.alpha = 0.0
        
           NotificationCenter.default.post(name: Notification.Name(rawValue: "openMap"), object: 1)
    }
}
extension UITableView {
    func scrollToBottom(_ animated: Bool = true) {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: sections - 1)
        self.scrollToRow(at: IndexPath(row: rows - 1, section: sections - 1), at: .bottom, animated: true)
    }
}
