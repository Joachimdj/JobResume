//
//  EditView.swift
//  Forum
//
//  Created by Joachim Dittman on 16/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import UIKit
import Eureka

class EditView: FormViewController {

    var ac = [AuctionItem]() 
    var lc = [Lecture]()
    var row = 0
    var day = 0
    var dayString = ["Fredag","Lørdag","Søndag"]
    let typeImagesArray = ["Workshop","Social","Debat","Fire","3round","Talk"]
    var formChanged = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = UIView(frame:CGRect(x:0,y:0, width:UIScreen.main.bounds.width,height:60))
        let close = UIButton()
        close.frame = CGRect(x: -10,y: 0,width: 70,height: 70)
        close.setImage(UIImage(named: "ic_close")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
        close.tintColor = UIColor.black
        close.addTarget(self, action: #selector(close(sender:)), for: UIControlEvents.touchUpInside)
        header.addSubview(close)
        
        let add = UIButton()
        add.frame = CGRect(x: UIScreen.main.bounds.width - 60,y: 0,width: 70,height: 70)
        add.setImage(UIImage(named: "ic_done")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
        add.tintColor = UIColor.black
        add.addTarget(self, action: #selector(add(sender:)), for: UIControlEvents.touchUpInside)
    
        header.backgroundColor = .white
        header.addSubview(add)
        self.view.addSubview(header)
        if(lc.count > 0)
        {
            initializeLectureForm()
        }
        else
        {
            initializeAuctionForm()
        }
        self.tableView.frame = CGRect(x: 0,y: 60,width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height - 60)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tableView.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initializeLectureForm() {
        
        var add:Condition = false
        if(lc[0].id == "")
        {
            add = true
        }
        
        var openDate = Date()
        var closeDate = Date()
        
            let date: Date = Date()
            
            let cal: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
            let openDateArray = lc[0].startTime?.components(separatedBy: ":")
            
            
            openDate  = (cal as NSCalendar).date(bySettingHour: Int((openDateArray?[0])!)!, minute: Int((openDateArray?[1])!)!, second: 0, of: date, options: NSCalendar.Options())!
        
            
            let closeDateArray = lc[0].endTime?.components(separatedBy: ":")
            
            closeDate = (cal as NSCalendar).date(bySettingHour: Int((closeDateArray?[0])!)!, minute: Int((closeDateArray?[1])!)!, second: 0, of: date, options: NSCalendar.Options())!
        
        form
        /*    +++  TextRow() {
                $0.title = "Titel"
                $0.value = lc[0].name
        
            }.onChange({ (row) in
                self.lc[0].name = row.value
                self.formChanged = true
            })
            <<< TextRow() {
                $0.title = "Sted"
                $0.value = lc[0].place
                }.onChange({ (row) in
                    self.lc[0].place = row.value
                    self.formChanged = true
                })
           
       <<< SegmentedRow<String>("day") {
            $0.title =  "Dag"
            $0.options = dayString
            $0.value = dayString[lc[0].day]
        }.onChange({ (row) in
            var index = 0
            for i in self.dayString
            {
                if(i == row.value)
                {
                     self.lc[0].day = index
                    self.formChanged = true
                }
                index += 1
            }
           
        })
            
            
            <<< TimeRow() {
                $0.title = "Start"
                $0.tag = "open"
                $0.value = openDate
                }.onChange({ (row) in
                    let dateFormat = DateFormatter()
                    dateFormat.dateFormat = "HH:mm"
                    
                    self.lc[0].startTime = dateFormat.string(from: row.value!)
                    self.formChanged = true
                })
            
            <<< TimeRow() {
                $0.title = "Stop"
                $0.tag = "close"
                $0.value = closeDate
                }.onChange({ (row) in
                    let dateFormat = DateFormatter()
                    dateFormat.dateFormat = "HH:mm"
                    
                    self.lc[0].endTime = dateFormat.string(from: row.value!)
                    self.formChanged = true
                })
            
            <<< SegmentedRow<String>()
                {
                    $0.options = typeImagesArray
                    $0.value =  typeImagesArray[Int(lc[0].type!)!]
                
                }.onChange({ (row) in
                    var index = 0
                    for i in self.typeImagesArray
                    {
                        if(i == row.value)
                        {
                             self.lc[0].type = "\(index)"
                            self.formChanged = true
                        }
                        index += 1
                    }
                   
                })
            <<< TextAreaRow() {
                $0.value = lc[0].desc
                $0.placeholder = "Beskrivelse"
                $0.textAreaHeight = .dynamic(initialTextViewHeight:50)
                }.onChange({ (row) in
                   self.lc[0].desc = row.value
                    self.formChanged = true
                })
            <<< SwitchRow() {
                $0.title = "Vis"
                if(lc[0].status == 0){$0.value = true} else {$0.value = false}
                }.onChange({ (result) in
                    if(result.value == true){self.lc[0].status = 0} else {self.lc[0].status = 0}
                    self.formChanged = true
                })
          */
         
            +++ Section("Deltagere med programpunkt som favorit.")
                <<< TextAreaRow() {
                    $0.textAreaHeight = .dynamic(initialTextViewHeight:50)
                    $0.placeholder = "Skriv din besked her"
                    $0.tag = "participantFavoritDesc"
                }
                <<< ButtonRow(){
                $0.title = "Send besked"
                
                    }.onCellSelection { cell, row in
                        let message = self.form.rowBy(tag:"participantFavoritDesc")?.baseValue
                        let reciveres = [""]
                        if(message != nil && reciveres.count > 0)
                        {
                            if(MessageController().sendMessage(id: self.lc[0].id, type:"likes", topic:"lecture-likes-\(self.lc[0].id)",message:message as! String) == true)
                            {
                                self.form.rowBy(tag:"participantFavoritDesc")?.baseValue = ""
                                self.form.rowBy(tag:"participantFavoritDesc")?.reload()
                                print("message sent ")
                                
                            }
                            else
                            {
                                print("message error")
                            }
                        } 
        
    }
    }
    
    
    private func initializeAuctionForm() {
         
        var endDate: Date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy HH:mm"
        endDate = dateFormatter.date(from: ac[0].endDate!)!
        
        var add:Condition = false
        if(ac[0].id == "")
        {
            add = true
        }
        
        
        form
       /*     +++   TextRow() {
                $0.title = "Titel"
                $0.value = ac[0].name
                
                }.onChange({ (row) in
                    self.ac[0].name = row.value!
                    self.formChanged = true
                })
            <<< TextRow() {
                $0.title = "donator"
                $0.value = ac[0].donator
                }.onChange({ (row) in
                    self.ac[0].donator = row.value!
                    self.formChanged = true
                })
           
            <<< DateRow() {
                $0.title = "Udløbsdato"
                $0.value = endDate
                }.onChange({ (row) in
                    let dateFormat = DateFormatter()
                    dateFormat.dateFormat = "dd-mm-yyyy HH:mm"
                    self.ac[0].endDate = dateFormat.string(from: row.value!)
                    self.formChanged = true
                })
            
            
          
            <<< TextAreaRow() {
                $0.value = ac[0].desc
                $0.placeholder = "Beskrivelse"
                $0.textAreaHeight = .dynamic(initialTextViewHeight:50)
                }.onChange({ (row) in
                    self.ac[0].desc = row.value
                    self.formChanged = true
                })
            <<< SwitchRow() {
                $0.title = "Vis"
                $0.tag = "vis"
                if(ac[0].status == 0 || ac[0].status == 1){$0.value = true} else {$0.value = false}
                }.onChange({ (result) in
                    if(result.value == true){self.ac[0].status = 1} else {self.ac[0].status = 2}
                    self.formChanged = true
                })
            <<< SwitchRow() {
                $0.title = "Aktiver online auktion"
                $0.hidden = "$vis == false"
                if(ac[0].status == 0){$0.value = true} else {$0.value = false}
                }.onChange({ (result) in
                    if(result.value == true){self.ac[0].status = 0} else {self.ac[0].status = 1}
                    self.formChanged = true
                })
            <<< SwitchRow() {
                $0.title = "Send beskeder"
                $0.tag = "showMessage"
                $0.value = false
                $0.hidden = add
            }
            */
            +++ Section("Deltagere med auktions item som favorit.")
            
           
            <<< TextAreaRow() {
                $0.textAreaHeight = .dynamic(initialTextViewHeight:50)
                $0.placeholder = "Skriv din besked her"
                $0.tag = "participantFavoritDesc"
            }
            <<< ButtonRow(){
                $0.title = "Send push besked"
            
                }.onCellSelection { cell, row in
                    let message = self.form.rowBy(tag:"participantFavoritDesc")?.baseValue
                    let reciveres = [""]
                    if(message != nil && reciveres.count > 0)
                    {
                        if(MessageController().sendMessage(id: self.ac[0].id!, type:"likes", topic:"auction-likes-\(self.ac[0].id!)",message:message as! String) == true)
                        {
                            self.form.rowBy(tag:"participantFavoritDesc")?.baseValue = ""
                            self.form.rowBy(tag:"participantFavoritDesc")?.reload()
                            print("message sent ")
                            
                        }
                        else
                        {
                            print("message error")
                        }
                    }
            
            }
        
        
    }
    
    func close(sender:AnyObject)
    {
        if(formChanged == true)
        {
            if(lc.count > 0)
            {
                LectureController().update(lecture: lc[0], row:row, day:day, completion: { (result) in
                     self.dismiss(animated: true, completion: nil)
                })
            }
            else
            {
                AuctionController().update(auction: ac[0], row: row, completion: { (result) in
                    self.dismiss(animated: true, completion: nil)
                })
            }
            
        }
        else
        {
            self.dismiss(animated: true, completion: nil)
        }
       
    }
    
    func add(sender:AnyObject)
    {
        if(formChanged == true)
        {
            if(lc.count > 0)
            {
                if(lc[0].name != "" && lc[0].place != "")
                {
                LectureController().update(lecture: lc[0], row:row, day:day, completion: { (result) in
                    self.dismiss(animated: true, completion: nil)
                })
                }
                else
                {
                    print("error in form")
                }

            }
            else
            {
                if(ac.count > 0 && ac[0].name != "" && ac[0].donator != "" )
                {

                AuctionController().update(auction: ac[0], row: row, completion: { (result) in
                    self.dismiss(animated: true, completion: nil)
                })
                }
                else
                {
                   print("error in form")
                }
            }
            
        }
        else
        {
            print("error in form")
        }
        
    }
 
}
