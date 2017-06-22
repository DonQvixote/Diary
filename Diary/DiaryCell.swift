//
//  DiaryCell.swift
//  Diary
//
//  Created by 夏语诚 on 2017/6/22.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit

class DiaryCell: UICollectionViewCell {
    var textLabel: DiaryLabel!
    var textInt: Int = 0
    var labelText: String = "" {
        didSet {
            textLabel.updateText(labelText: labelText)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textLabel = DiaryLabel(fontname: "Wyue-GutiFangsong-NC", labelText: labelText, fontSize: 16.0, lineHeight: 5.0, color: .black)
        self.contentView.addSubview(textLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel.center = CGPoint(x: itemWidth/2.0, y: itemHeight/2.0)
    }
}
