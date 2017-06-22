//
//  DiaryLayout.swift
//  Diary
//
//  Created by 夏语诚 on 2017/6/22.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit

class DiaryLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        let itemSize = CGSize(width: itemWidth, height: itemHeight) // Cell大小
        self.itemSize = itemSize
        self.minimumInteritemSpacing = 0.0 // Cell左右间距
        self.minimumLineSpacing = 0 // Cell行间距
        self.sectionInset = UIEdgeInsetsMake((screenSize.height / 2.0) - (itemHeight / 2.0), (screenSize.width / 2.0) - (itemWidth / 2.0), (screenSize.height / 2.0), (screenSize.height / 2.0) - (itemHeight / 2.0)) // 增加内嵌
    }
}
