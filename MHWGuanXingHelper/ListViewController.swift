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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadSampleData()
        
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
        cell.Name2.text = Line.Jewel2.cname
        cell.Name3.text = Line.Jewel3.cname
        
        return cell
    }
}

