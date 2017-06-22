//
//  DiaryMonthCollectionViewController.swift
//  Diary
//
//  Created by 夏语诚 on 2017/6/22.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit

private let reuseIdentifier = "DiaryCell"

class DiaryMonthCollectionViewController: UICollectionViewController {
    
    var month: Int!
    var yearLabel: DiaryLabel!
    var monthLabel: DiaryLabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let layout = DiaryLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.collectionView?.setCollectionViewLayout(layout, animated: false)
        
        yearLabel = DiaryLabel(fontname: "Wyue-GutiFangsong-NC", labelText: "二零一七年", fontSize: 16.0, lineHeight: 5.0, color: .black)
        yearLabel.frame = CGRect(x: screenSize.width - yearLabel.frame.size.width - 20,
                                 y: 20,
                                 width: yearLabel.frame.size.width,
                                 height: yearLabel.frame.size.height)
        self.view.addSubview(yearLabel)
        
        monthLabel = DiaryLabel(fontname: "Wyue-GutiFangsong-NC", labelText: "三月", fontSize: 16.0, lineHeight: 5.0, color: DiaryRed)
        monthLabel.frame = CGRect(x: screenSize.width - monthLabel.frame.size.width - 20,
                                  y: screenSize.height / 2.0 - monthLabel.frame.size.height / 2.0,
                                  width: monthLabel.frame.size.width,
                                  height: monthLabel.frame.size.height)
        self.view.addSubview(monthLabel)
        
        let composeButton = diaryButtonWith(text: "撰", fontSize: 14.0, width: 40.0, normalImageName: "Oval", highlightedImageName: "Oval_pressed")
        composeButton.center = CGPoint(x: yearLabel.center.x, y: 38 + yearLabel.frame.size.height + 26.0 / 2.0)
        composeButton.addTarget(self, action: #selector(newCompose), for: .touchUpInside)
        self.view.addSubview(composeButton)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func newCompose() {
        let identifier = "DiaryComposeViewController"
        let composeViewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) as! DiaryComposeViewController
        self.present(composeViewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DiaryCell
    
        // Configure the cell
        cell.textInt = 1
        cell.labelText = "季风气候"
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
