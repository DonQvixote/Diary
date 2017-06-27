//
//  DiaryYearCollectionViewController.swift
//  Diary
//
//  Created by 夏语诚 on 2017/6/22.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "DiaryCell"

class DiaryYearCollectionViewController: UICollectionViewController {
    
    var year: Int!
    var diaries = [Diary]()
    var fetchedResultsController: NSFetchedResultsController<Diary>!
    var monthCount = 1
    var sectionsCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let layout = DiaryLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.collectionView?.setCollectionViewLayout(layout, animated: false)
        
        do {
            // 新建查询
            let fetchRequest = NSFetchRequest<Diary>(entityName: "Diary")
            // 增加过滤条件
            fetchRequest.predicate = NSPredicate(format: "year = \(year!)")
            // 排序方式
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: true)]
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: "month", cacheName: nil)
            // 尝试查询
            try self.fetchedResultsController.performFetch()
            if fetchedResultsController.fetchedObjects?.count ==  0 {
                print("没有存储结果")
            } else {
                if let sectionsCount = fetchedResultsController.sections?.count {
                    monthCount = sectionsCount
                    diaries = fetchedResultsController.fetchedObjects!
                } else{
                    sectionsCount = 0
                    monthCount = 1
                }
            }
        } catch let error as NSError{
            print("发现错误 \(error.localizedDescription)")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return monthCount
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DiaryCell
    
        //获取当前月份
        let components = Calendar.current.component(Calendar.Component.month, from: Date())
        var month = components
        
        if sectionsCount > 0 {
            // 如果程序内有保存的日记,就使用保存的日记的月份
            let sectionInfo = fetchedResultsController.sections![indexPath.section]
            print("分组信息 \(sectionInfo.name)")
            month = Int(sectionInfo.name)!
        }
        
        // Configure the cell
        cell.textInt = month
        cell.labelText = "\(numberToChinese(cell.textInt)) 月"
    
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
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let identifier = "DiaryMonthCollectionViewController"
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: identifier) as! DiaryMonthCollectionViewController
        
        let components = Calendar.current.component(Calendar.Component.month, from: Date())
        var month = components
        
        if sectionsCount > 0 {
            let sectionInfo = fetchedResultsController.sections![indexPath.section]
            month = Int(sectionInfo.name)!
        }
        
        dvc.month = month
        dvc.year = year
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}
