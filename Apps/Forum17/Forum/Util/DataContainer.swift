//
//  DataContainer.swift
//  Forum
//
//  Created by Joachim Dittman on 05/08/2016.
//  Copyright © 2016 Joachim Dittman. All rights reserved.
//

import UIKit
import FirebaseStorage

let storageRef = FIRStorage.storage().reference(forURL: "gs://forumapp-4d3f7.appspot.com")
let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
var selectedProgram = 0
var selectedItem = 0
var auctionContainer = [auctionObject]()
var programContainer = [ProgramObject]()
var favoriteContainer = [ProgramObject]()
var dateContainer  = [dateObject]()
let mapButton =  UIButton()
let typeArray = ["","Workshop","Social","Debat","Firehose","Three-round burst","Foredrag"]
let typeImagesArray = ["","cirkel_workshop","cirkel_social","Cirkel_debat","cirkel_firehose","cirkel_3roundBurst","cirkel_talk"]
var yourdProgram = false
