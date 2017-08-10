//
//  MyProgram.swift
//  Forum
//
//  Created by Joachim Dittman on 05/08/2016.
//  Copyright © 2016 Joachim Dittman. All rights reserved.
//

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


var dict1 = [String]()

class MyProgram: UIViewController,UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
 
 
    
    var tableView: UITableView  =   UITableView()
     var quotesView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var qArray = ["Så her får du svaret til \n livet, universet og alting.",""]
        var aArray = ["42",""]
        
        
        tableView.frame         =   CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height - 60);
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.rowHeight = 70
        tableView.register(ProgramCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
        
        quotesView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width - 20, height: screenSize.height))
        
        let quotesText = UITextView(frame: CGRect(x: 0, y: 100, width: screenWidth, height: 100))
        
        quotesText.textAlignment = .center
        quotesText.font = UIFont (name: "HelveticaNeue", size: 18)
        quotesText.text = "Du har ikke valgt nogle \nprogrampunkter?"
        quotesText.isUserInteractionEnabled = false
        quotesView.addSubview(quotesText)
        
        let quotesText1 = UITextView(frame: CGRect(x: 0, y: 200, width: screenWidth, height: 100))
        quotesText1.textAlignment = .center
        quotesText1.font = UIFont (name: "HelveticaNeue", size: 20)
        quotesText1.text = qArray[0]
        quotesText1.isUserInteractionEnabled = false
        quotesView.addSubview(quotesText1)
        
        let quotesText2 = UITextView(frame: CGRect(x: 0, y:  300, width: screenWidth, height: 100))
        quotesText2.textAlignment = .center
        quotesText2.font = UIFont (name: "HelveticaNeue-Bold", size: 40)
        quotesText2.text = aArray[0]
        quotesText2.textColor = UIColor.brown
        quotesText2.isUserInteractionEnabled = false
        quotesView.addSubview(quotesText2)
        self.view.addSubview(quotesView)
        quotesView.alpha = 0.0
        
        let defaults = UserDefaults.standard 
        dict1 = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        
        print(dict1)
        
      
            favoriteContainer =  programContainer
            self.tableView.reloadData()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        print(dict1)
        var tempProgramContainer = [ProgramObject]()
        
        for d in dateContainer{
        for p in d.programObjects
        {
            print("\(p.date)\(p.id)")
            if(dict1.contains("\(p.date)\(p.id)"))
            {
                 tempProgramContainer.append(p)
            }
            
        }
        }
        favoriteContainer.removeAll()
        favoriteContainer = tempProgramContainer
         
        self.tableView.reloadData()
        
        self.tableView.separatorColor = UIColor.clear
      
        print(favoriteContainer.count)
        if(favoriteContainer.count == 0)
        {
            print("fav")
            quotesView.alpha = 1.0
        }
        else
        {
            quotesView.alpha = 0.0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(favoriteContainer.count > 0){return favoriteContainer.count} else {return 0}
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss"
        let date = dayTimePeriodFormatter.date(from: "\(favoriteContainer[section].date) 00:00:00")
        
        let dayTimePeriodFormatter1 = DateFormatter()
        dayTimePeriodFormatter1.dateFormat = "EEEE"
        print(date!)
        let dateString = dayTimePeriodFormatter1.string(from: date!)
        print(dateString)
        
        return "\(dateString) \(favoriteContainer[section].startTime) - \(favoriteContainer[section].endTime)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ProgramCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProgramCell
        let object = favoriteContainer[indexPath.section]
        cell.firstMessage.text = object.name
        cell.userName.text = object.place
        cell.secondMessage.text = typeArray[object.type]
        cell.profileImageView.image = UIImage(named: typeImagesArray[object.type])
        cell.favorite.addTarget(self, action: #selector(MyProgram.removeFavorite(_:)), for: UIControlEvents.touchUpInside)
        cell.favorite.tag = indexPath.section
        cell.favorite.setImage(UIImage(named: "heartDark"), for: UIControlState())
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        selectedItem = indexPath.section
        yourdProgram = true
        DispatchQueue.main.async(execute: {
              self.present(ProgramInfo(), animated: true, completion: nil)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func removeFavorite(_ sender:AnyObject)
    {
        print("favorite")
        let itemString = "\(favoriteContainer[sender.tag].date)\(favoriteContainer[sender.tag].id)"
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
        var tempProgramContainer = [ProgramObject]()
        for d in dateContainer{
            for p in d.programObjects
        {
            print("\(p.date)\(p.id)")
            if(dict1.contains("\(p.date)\(p.id)"))
            {
                tempProgramContainer.append(p)
            }
            
        }
        }
        favoriteContainer.removeAll()
        favoriteContainer = tempProgramContainer
        self.tableView.reloadData()
        let defaults = UserDefaults.standard
        defaults.set(dict1, forKey: "SavedArray")
        
        if(favoriteContainer.count == 0)
        {
            print("fav")
            UIView.animate(withDuration: 0.5, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                self.quotesView.alpha = 1.0
                
                }, completion: nil)
            
      
        }
        else
        {
            quotesView.alpha = 0.0
        }
    }
    
    
    
}
