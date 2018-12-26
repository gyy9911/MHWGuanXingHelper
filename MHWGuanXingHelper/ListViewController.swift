//
//  ListViewController.swift
//  MHWGuanXingHelper
//
//  Created by GaoYy on 2018/11/28.
//  Copyright © 2018年 GaoYy. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var List=[ListLine]()
    @IBAction func AddButton(_ sender: Any) {
        SelectedJewelId1 = -1
        SelectedJewelId2 = -1
        SelectedJewelId3 = -1
    }
    var JewelImages:[UIImage]=[UIImage(named: "S1Img")!,
                               UIImage(named: "S2Img")!,
                               UIImage(named: "S3Img")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //loadSampleData()
        
        tableView.delegate = self//设置表格视图的代理为当前的视图控制器类
        tableView.dataSource = self//设置表格视图的数据源为当前的视图控制器类
    }
    
    @IBAction func showList(_ sender: UIButton) {
        
            print(List[0].Jewel1.cname)
    }
    private func loadSampleData(){
        let Jewelid1 = 0;
        let Jewelid2 = 0;
        let Jewelid3 = 2;
        let Jewel1=JewelData[Jewelid1]
        let Jewel2=JewelData[Jewelid2]
        let Jewel3=JewelData[Jewelid3]
        List.append(ListLine(Jewel1: Jewel1, Jewel2: Jewel2, Jewel3: Jewel3))
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return List.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ListJewelCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ListJewelCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }

        let Line = List[indexPath.row]
        cell.Name1.text = Line.Jewel1.cname
        if(Line.Jewel1.id>=0){cell.Image1.image=JewelImages[Line.Jewel1.slot-1]}
        cell.Name2.text = Line.Jewel2.cname
        if(Line.Jewel2.id>=0){cell.Image2.image=JewelImages[Line.Jewel2.slot-1]}
        cell.Name3.text = Line.Jewel3.cname
        if(Line.Jewel3.id>=0){cell.Image3.image=JewelImages[Line.Jewel3.slot-1]}
        
        return cell
    }
    @IBAction func unwindToList(sender:UIStoryboardSegue){
        if sender.source is TabViewCotroller{
            print("unwind succed")
            // Add a new meal.
            let newIndexPath = IndexPath(row: List.count, section: 0)
            var newJewel1:Jewel
            var newJewel2:Jewel
            var newJewel3:Jewel
            
            if(SelectedJewelId1<0){newJewel1=emptyJewel1}else{
                newJewel1=JewelData[SelectedJewelId1]
            }
            if(SelectedJewelId2<0){newJewel2=emptyJewel1}else{
                newJewel2=JewelData[SelectedJewelId2]
            }
            if(SelectedJewelId3<0){newJewel3=emptyJewel1}else{
                newJewel3=JewelData[SelectedJewelId3]
            }
            let newLine=ListLine(Jewel1: newJewel1, Jewel2: newJewel2, Jewel3: newJewel3)
            List.append(newLine)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
        
    }
    // 设置 cell 是否允许左滑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // 设置默认的左滑按钮的title
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "按钮钮钮"
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let cellActionA = UITableViewRowAction(style: .default, title: "按钮-1", handler: {_,_ in
            print("点击了 按钮-1")
        })
        cellActionA.backgroundColor = UIColor.green
        
        let cellActionB = UITableViewRowAction(style: .default, title: "按钮-2", handler: {_,_ in
            print("点击了 按钮-2")
        })
        return [cellActionA, cellActionB]
    }

    // 点击左滑出现的按钮时触发
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("点击左滑出现的按钮时触发")
        return
    }
    // 左滑结束时调用(只对默认的左滑按钮有效，自定义按钮时这个方法无效)
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
    }

}

