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
let managedContext = appDelegate.managedObjectContext

let itemHeight: CGFloat = 150.0
let itemWidth: CGFloat = 60
let collectionViewWidth = itemWidth * 3
let screenSize = UIWindow().screen.bounds
let DiaryRed = UIColor(colorLiteralRed: 192.0/255.0, green: 23/255.0, blue: 48.0/255.0, alpha: 1)

func diaryButtonWith(text: String, fontSize: CGFloat, width: CGFloat, normalImageName: String, highlightedImageName: String) -> UIButton {
    let button = UIButton(type: .custom)
    button.frame = CGRect(x: 0, y: 0, width: width, height: width)
    let font = UIFont(name: "Wyue-GutiFangsong-NC", size: fontSize)
    let textAttributes: [String: AnyObject] = [ NSFontAttributeName: font!,
                                                NSForegroundColorAttributeName: UIColor.white]
    let attributedText = NSAttributedString(string: text, attributes: textAttributes)
    button.setAttributedTitle(attributedText, for: .normal)
    button.setBackgroundImage(UIImage(named: normalImageName), for: .normal)
    button.setBackgroundImage(UIImage(named: highlightedImageName), for: .highlighted)
    return button
}
