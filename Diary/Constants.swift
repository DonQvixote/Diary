//
//  Constants.swift
//  Diary
//
//  Created by 夏语诚 on 2017/6/22.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let managedContext = appDelegate.managedObjectContext!

let itemHeight: CGFloat = 150.0
let itemWidth: CGFloat = 60
let collectionViewWidth = itemWidth * 3
let screenSize = UIWindow().screen.bounds
let DiaryRed = UIColor(colorLiteralRed: 192.0/255.0, green: 23/255.0, blue: 48.0/255.0, alpha: 1)
