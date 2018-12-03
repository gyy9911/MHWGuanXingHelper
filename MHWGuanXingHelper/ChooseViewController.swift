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
    
    //对应四个table的数据
    var JewelsR5=[Jewel]()
    var JewelsR6=[Jewel]()
    var JewelsR7=[Jewel]()
    var JewelsR8=[Jewel]()
    
    //3个被选择的珠子
    var Jewel1:Jewel?
    var Jewel2:Jewel?
    var Jewel3:Jewel?
    
    var JewelImages:[UIImage]=[UIImage(named: "S1Img")!,
                        UIImage(named: "S2Img")!,
                        UIImage(named: "S3Img")!
                        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置tabbaritem字体
        for baritem in (tabBarController?.tabBar.items)!{
            baritem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], for: UIControl.State.normal)
        }
        
        
      //  print("view load")
        
        if(!isDataLoaded){
            InitJewelData()
        }
        tableViewR5.delegate = self
        tableViewR5.dataSource = self
        tableViewR6.delegate = self
        tableViewR6.dataSource = self
        tableViewR7.delegate = self
        tableViewR7.dataSource = self
        tableViewR8.delegate = self
        tableViewR8.dataSource = self
        
        setSlot1Jewels()//默认加载1级孔数据
        reloadAllTable()
        
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
        let cellIdentifier = "ChooseJewelCell"
        if(tableView==tableViewR5){
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChooseJewelCell  else {
                fatalError("The dequeued cell is not an instance of ChooseJewelCell.")
            }
            let SingleJewel = JewelsR5[indexPath.row]
            cell.ChoiceLableR5.text=SingleJewel.cname
            cell.Jewelid=SingleJewel.id
            return cell
        }
        else if(tableView==tableViewR6){

            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChooseJewelCell  else {
                fatalError("The dequeued cell is not an instance of ChooseJewelCell.")
            }
            let SingleJewel = JewelsR6[indexPath.row]
            cell.ChoiceLableR6.text=SingleJewel.cname
            cell.Jewelid=SingleJewel.id
            return cell
        }
        else if(tableView==tableViewR7){

            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChooseJewelCell  else {
                fatalError("The dequeued cell is not an instance of ChooseJewelCell.")
            }
            let SingleJewel = JewelsR7[indexPath.row]
            cell.ChoiceLableR7.text=SingleJewel.cname
            cell.Jewelid=SingleJewel.id
            return cell
        }
        else {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChooseJewelCell  else {
                fatalError("The dequeued cell is not an instance of ChooseJewelCell.")
            }
            let SingleJewel = JewelsR8[indexPath.row]
            cell.ChoiceLableR8.text=SingleJewel.cname
            cell.Jewelid=SingleJewel.id
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell=tableView.cellForRow(at: indexPath) as? ChooseJewelCell else{
            fatalError("can't get cell")
        }
        
       // print("选中了第\(indexPath.row)个cell id=\(cell.Jewelid)")
        
        switch tabBarItem.tag {
        case 1:
            Jewel1=JewelData[cell.Jewelid]
            tabBarItem.title=Jewel1?.cname
            tabBarItem.image=JewelImages[(Jewel1?.slot)!-1]
            tabBarItem.selectedImage=JewelImages[(Jewel1?.slot)!-1]
            SelectedJewelId1=(Jewel1?.id)!
            
    
        case 2:
            Jewel2=JewelData[cell.Jewelid]
            tabBarItem.title=Jewel2?.cname
            tabBarItem.image=JewelImages[(Jewel2?.slot)!-1]
            tabBarItem.selectedImage=JewelImages[(Jewel2?.slot)!-1]
            SelectedJewelId2=(Jewel2?.id)!
        case 3:
            Jewel3=JewelData[cell.Jewelid]
            tabBarItem.title=Jewel3?.cname
            tabBarItem.image=JewelImages[(Jewel3?.slot)!-1]
            tabBarItem.selectedImage=JewelImages[(Jewel3?.slot)!-1]
            SelectedJewelId3=(Jewel3?.id)!
        default:
            fatalError("wrong tag number")
        }
        //tabBarItem.image=JewelImages[2]

        cell.isSelected=false
    }

    
    private func InitJewelData(){
        for eachJewel in JewelData{
            if(eachJewel.slot==1){
                switch(eachJewel.rare){
                case 5:JewelsS1R5.append(eachJewel)
                case 6:JewelsS1R6.append(eachJewel)
                case 7:JewelsS1R7.append(eachJewel)
                case 8:JewelsS1R8.append(eachJewel)
                case 0:break
                default:
                    fatalError("wrong rare number")
                }
            }
            else if(eachJewel.slot==2){
                switch(eachJewel.rare){
                case 5:JewelsS2R5.append(eachJewel)
                case 6:JewelsS2R6.append(eachJewel)
                case 7:JewelsS2R7.append(eachJewel)
                case 8:JewelsS2R8.append(eachJewel)
                case 0:break
                default:
                    fatalError("wrong rare number")
                }
            }
            else if(eachJewel.slot==3){
                switch(eachJewel.rare){
                case 5:JewelsS3R5.append(eachJewel)
                case 6:JewelsS3R6.append(eachJewel)
                case 7:JewelsS3R7.append(eachJewel)
                case 8:JewelsS3R8.append(eachJewel)
                case 0:break
                default:
                    fatalError("wrong rare number")
                }
            }
            else {
                    fatalError("wrong slot number")
            }
        }
        isDataLoaded=true
    }
    
    private func reloadAllTable(){
        self.tableViewR5.reloadData()
        self.tableViewR6.reloadData()
        self.tableViewR7.reloadData()
        self.tableViewR8.reloadData()
    }
    private func setSlot1Jewels(){
        JewelsR5=JewelsS1R5
        JewelsR6=JewelsS1R6
        JewelsR7=JewelsS1R7
        JewelsR8=JewelsS1R8
    }
    private func setSlot2Jewels(){
        JewelsR5=JewelsS2R5
        JewelsR6=JewelsS2R6
        JewelsR7=JewelsS2R7
        JewelsR8=JewelsS2R8
    }
    private func setSlot3Jewels(){
        JewelsR5=JewelsS3R5
        JewelsR6=JewelsS3R6
        JewelsR7=JewelsS3R7
        JewelsR8=JewelsS3R8
    }
    
    //以下9个按钮对应三个界面上的三个镶嵌槽选择按钮
    @IBAction func J1S1Button(_ sender: UIButton) {
        setSlot1Jewels()
        reloadAllTable()
    }
    @IBAction func J1S2Button(_ sender: UIButton) {
        setSlot2Jewels()
        reloadAllTable()
    }
    @IBAction func J1S3Button(_ sender: UIButton) {
        setSlot3Jewels()
        reloadAllTable()
    }
    @IBAction func J2S1Button(_ sender: UIButton) {
        setSlot1Jewels()
        reloadAllTable()
    }
    @IBAction func J2S2Button(_ sender: UIButton) {
        setSlot2Jewels()
        reloadAllTable()
    }
    @IBAction func J2S3Button(_ sender: UIButton) {
        setSlot3Jewels()
        reloadAllTable()
    }
    @IBAction func J3S1Button(_ sender: UIButton) {
        setSlot1Jewels()
        reloadAllTable()
    }
    @IBAction func J3S2Button(_ sender: UIButton) {
        setSlot2Jewels()
        reloadAllTable()
    }
    @IBAction func J3S3Button(_ sender: UIButton) {
        setSlot3Jewels()
        reloadAllTable()
    }
    
    
}
