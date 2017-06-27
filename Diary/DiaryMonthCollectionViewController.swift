//
//  DiaryMonthCollectionViewController.swift
//  Diary
//
//  Created by 夏语诚 on 2017/6/22.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "DiaryCell"

class DiaryMonthCollectionViewController: UICollectionViewController {
    
    var month: Int!
    var year: Int!
    var yearLabel: DiaryLabel!
    var monthLabel: DiaryLabel!
    var fetchedResultsController: NSFetchedResultsController<Diary>!
    var diaries = [Diary]()

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
        
        // 添加按钮
        let composeButton = diaryButtonWith(text: "撰", fontSize: 14.0, width: 40.0, normalImageName: "Oval", highlightedImageName: "Oval_pressed")
        composeButton.center = CGPoint(x: yearLabel.center.x, y: 38 + yearLabel.frame.size.height + 26.0 / 2.0)
        composeButton.addTarget(self, action: #selector(newCompose), for: .touchUpInside)
        self.view.addSubview(composeButton)
        
        do {
            let fetchRequest = NSFetchRequest<Diary>(entityName: "Diary")
            fetchRequest.predicate = NSPredicate(format: "year = \(year!) AND month = \(month!)")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: true)]
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self // 建立委托关系
            try fetchedResultsController.performFetch()
            if fetchedResultsController.sections?.count == 0 {
                print("没有储存结果")
            } else {
                diaries = fetchedResultsController.fetchedObjects!
            }
        } catch let error as NSError {
            print("发现错误 \(error.localizedDescription)")
        }

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
        return diaries.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DiaryCell
    
        // Configure the cell
        let diary = diaries[indexPath.row]
        cell.labelText = diary.title!
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: "DiaryViewController") as! DiaryViewController
        dvc.diary = diaries[indexPath.row]
        self.navigationController?.pushViewController(dvc, animated: true)
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

extension DiaryMonthCollectionViewController: NSFetchedResultsControllerDelegate {
    // 响应数据变化
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        // 重置数据源
        diaries = controller.fetchedObjects! as! [Diary]
        // 重载数据
        self.collectionView?.reloadData()
        // 更新布局
        self.collectionView?.setCollectionViewLayout(DiaryLayout(), animated: false)
    }
}
