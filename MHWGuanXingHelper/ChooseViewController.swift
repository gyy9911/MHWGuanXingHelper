//
//  ChooseViewController.swift
//  MHWGuanXingHelper
//
//  Created by GaoYy on 2018/11/29.
//  Copyright © 2018年 GaoYy. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewR5: UITableView!
    @IBOutlet weak var tableViewR6: UITableView!
    @IBOutlet weak var tableViewR7: UITableView!
    @IBOutlet weak var tableViewR8: UITableView!
    
    var JewelsR5=[Jewel]()
    var JewelsR6=[Jewel]()
    var JewelsR7=[Jewel]()
    var JewelsR8=[Jewel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleData()
        
        tableViewR5.delegate = self
        tableViewR5.dataSource = self
        tableViewR6.delegate = self
        tableViewR6.dataSource = self
        tableViewR7.delegate = self
        tableViewR7.dataSource = self
        tableViewR8.delegate = self
        tableViewR8.dataSource = self
        
        
    }
    private func loadSampleData(){
        JewelsR5.append(JewelData[0])
        JewelsR5.append(JewelData[1])
        JewelsR5.append(JewelData[2])
        JewelsR5.append(JewelData[3])
        
        JewelsR6.append(JewelData[0])
        JewelsR6.append(JewelData[1])
        JewelsR6.append(JewelData[2])
        JewelsR6.append(JewelData[3])
        
        JewelsR7.append(JewelData[2])
        JewelsR7.append(JewelData[3])
        
        JewelsR8.append(JewelData[4])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tableViewR5:
            return JewelsR5.count
        case tableViewR6:
            return JewelsR6.count
        case tableViewR7:
            return JewelsR7.count
        case tableViewR8:
            return JewelsR8.count
        default:
            return -1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellIdentifier:String
        if(tableView==tableViewR5){
            cellIdentifier = "ChooseJewelCellR5"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChooseJewelCell  else {
                fatalError("The dequeued cell is not an instance of ChooseJewelCell.")
            }
            let SingleJewel = JewelsR5[indexPath.row]
            cell.ChoiceR5.titleLabel?.text=SingleJewel.cname
            return cell
        }
        else if(tableView==tableViewR6){
            cellIdentifier = "ChooseJewelCellR6"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChooseJewelCell  else {
                fatalError("The dequeued cell is not an instance of ChooseJewelCell.")
            }
            let SingleJewel = JewelsR6[indexPath.row]
            cell.ChoiceR6.titleLabel?.text=SingleJewel.cname
            return cell
        }
        else if(tableView==tableViewR7){
            cellIdentifier = "ChooseJewelCellR7"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChooseJewelCell  else {
                fatalError("The dequeued cell is not an instance of ChooseJewelCell.")
            }
            let SingleJewel = JewelsR7[indexPath.row]
            cell.ChoiceR7.titleLabel?.text=SingleJewel.cname
            return cell
        }
        else {
            cellIdentifier = "ChooseJewelCellR8"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChooseJewelCell  else {
                fatalError("The dequeued cell is not an instance of ChooseJewelCell.")
            }
            let SingleJewel = JewelsR8[indexPath.row]
            cell.ChoiceR8.titleLabel?.text=SingleJewel.cname
            return cell
        }
    }
}
