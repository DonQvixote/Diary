//
//  Helper.swift
//  Diary
//
//  Created by 夏语诚 on 2017/6/26.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit

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

func numberToChinese(_ number: Int) -> String {
    let numbers = Array(String(number).characters)
    var finalString = ""
    for singleNumber in numbers {
        let string = singleNumberToChinese(singleNumber)
        finalString = "\(finalString)\(string)"
    }
    
    return finalString
}

func singleNumberToChinese(_ number: Character) -> String {
    switch number {
    case "0":
        return "零"
    case "1":
        return "一"
    case "2":
        return "二"
    case "3":
        return "三"
    case "4":
        return "四"
    case "5":
        return "五"
    case "6":
        return "六"
    case "7":
        return "七"
    case "8":
        return "八"
    case "9":
        return "九"
    default:
        return ""
    }
}

func numberToChineseWithUnit(_ number: Int) -> String {
    let numbers = Array(String(number).characters)
    var units = unitParse(numbers.count)
    var finalString = ""
    
    for (index, singleNumber) in numbers.enumerated() {
        let string = singleNumberToChinese(singleNumber)
        if !(string == "零" && (index+1) == numbers.count) {
            finalString = "\(finalString)\(string)\(units[index])"
        }
    }
    return finalString
}

func unitParse(_ unit: Int) -> [String] {
    var units = Array(["万", "千", "百", "十", ""].reversed())
    let parseUnits = units[0..<unit].reversed()
    let slicedUnits: ArraySlice<String> = ArraySlice(parseUnits)
    let final: [String] = Array(slicedUnits)
    return final
}

extension UIWebView {
    func captureView() -> UIImage {
        let tmpFrame = self.frame // 存储初始大小
        var aFrame = self.frame // 新的Frame
        aFrame.size.width = self.sizeThatFits(UIScreen.main.bounds.size).width
        self.frame = aFrame // 展开Frame
        
        // 初始化 ImageContext
        UIGraphicsBeginImageContextWithOptions(self.sizeThatFits(UIScreen.main.bounds.size), false, UIScreen.main.scale)
        
        // 创建新的 Context
        let resizedContext = UIGraphicsGetCurrentContext()
        self.layer.render(in: resizedContext!)
        
        // 重新渲染到新的resizedContext
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 还原Frame
        self.frame = tmpFrame
        return image!
    }
}
