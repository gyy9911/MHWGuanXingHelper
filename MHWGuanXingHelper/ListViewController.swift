//
//  ListViewController.swift
//  MHWGuanXingHelper
//
//  Created by GaoYy on 2018/11/28.
//  Copyright © 2018年 GaoYy. All rights reserved.
//

import UIKit
import os.log

class ListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    var List=[ListLine]()
    @IBAction func AddButton(_ sender: Any)
    {
        //添加新项时清空之前已选条目
        SelectedJewelId1 = 100
        SelectedJewelId2 = 100
        SelectedJewelId3 = 100
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        ProBut1.setTitleColor(UIColor.black, for: UIControl.State.disabled)
        ProBut2.setTitleColor(UIColor.black, for: UIControl.State.disabled)
        ProBut3.setTitleColor(UIColor.black, for: UIControl.State.disabled)
              
 

        tableView.delegate = self//设置表格视图的代理为当前的视图控制器类
        tableView.dataSource = self//设置表格视图的数据源为当前的视图控制器类
        if let savedData=loadData()//加载存档
        {
            print("data loaded")
            List=savedData
            for i in 0...List.count-1
            {
                if List[i].Status == .cur
                {
                    CurLine=i
                    break
                }
            }
            if(CurProcess != nil)
            {
                switch CurProcess!
                {
                case .first1:proButSelected(sender: ProBut1)
                case .second1:proButSelected(sender: ProBut2)
                case .third2:proButSelected(sender: ProBut3)                    
                }
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return List.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "ListJewelCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ListJewelCell
        else
        {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }

        let Line = List[indexPath.row]
        cell.Name1.text = Line.Jewel1.cname
        cell.Image1.image=UIImage(named:"ImgS\(Line.Jewel1.slot)")
        cell.Name2.text = Line.Jewel2.cname
        cell.Image2.image=UIImage(named:"ImgS\(Line.Jewel2.slot)")
        cell.Name3.text = Line.Jewel3.cname
        cell.Image3.image=UIImage(named:"ImgS\(Line.Jewel3.slot)")
        switch Line.Status
        {
        case .done:
            cell.ProgressImage.image=UIImage(named:"ProDone")
        case .skip:
            cell.ProgressImage.image=UIImage(named: "ProSkip")
        case .cur:
            cell.ProgressImage.image=UIImage(named: "ProCur")
        case .not:
            cell.ProgressImage.image=UIImage(named: "ProNot")
        case .next:
            cell.ProgressImage.image=UIImage(named: "ProNext")
        }
        switch Line.isHighlighted
        {
        case true:
            cell.backgroundColor=UIColor.yellow
        case false:
            cell.backgroundColor=UIColor.white
        }
        return cell
    }
    
    @IBAction func unwindToList(sender:UIStoryboardSegue)
    {
        if sender.source is TabViewCotroller
        {
            
            let newJewel1=SelectedJewelId1<0 ? emptyJewel:JewelData[SelectedJewelId1]
            let newJewel2=SelectedJewelId2<0 ? emptyJewel:JewelData[SelectedJewelId2]
            let newJewel3=SelectedJewelId3<0 ? emptyJewel:JewelData[SelectedJewelId3]
            
            if let selectedIndexPath=tableView.indexPathForSelectedRow
            {
            //编辑行
                let editedLine=ListLine(Jewel1: newJewel1, Jewel2: newJewel2, Jewel3: newJewel3)
                editedLine.Status=List[selectedIndexPath.row].Status
                editedLine.isHighlighted=List[selectedIndexPath.row].isHighlighted
                
                List[selectedIndexPath.row]=editedLine
                saveData()
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else
            {
                // 添加新行
                let newLine=ListLine(Jewel1: newJewel1, Jewel2: newJewel2, Jewel3: newJewel3)
                let newIndexPath = IndexPath(row: List.count, section: 0)
                if(newIndexPath.row==0)
                {//如果添加的是第一行，那这一行即为初始当前行
                    newLine.Status = .cur
                    CurLine=0
                }
                List.append(newLine)
                saveData()
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        print(segue.identifier ?? "wrong")
        switch segue.identifier
        {
        case "add":
            os_log("add new",log:OSLog.default,type:.debug)
        case "edit":
            os_log("show edit",log:OSLog.default,type:.debug)
            guard let selectedCell=sender as? ListJewelCell
                else{fatalError("unexpected sender \(String(describing: sender))")}
            guard let indexPath=tableView.indexPath(for: selectedCell)
                else{fatalError("wrong indexPath")}
            let jewelLineData=List[indexPath.row]
            SelectedJewelId1=jewelLineData.Jewel1.id
            SelectedJewelId2=jewelLineData.Jewel2.id
            SelectedJewelId3=jewelLineData.Jewel3.id
            
        default:
            fatalError("unexpected identifier")
        }

    }

    // 设置 cell 是否允许左滑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    // 自定义左滑cell时的按钮和触发方法
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let cellActionA = UITableViewRowAction(style: .default, title: "删除", handler:
        {_,_ in
            if (indexPath.row != CurLine! || (indexPath.row==CurLine! && self.List.count==1) )
            {
                self.List.remove(at: indexPath.row)
                self.saveData()
                tableView.reloadData()
            }
            else{
                let alertController = UIAlertController(title: "", message: "不允许删除当前行", preferredStyle: .actionSheet)
                let okAction = UIAlertAction(title: "确定", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        })
        cellActionA.backgroundColor = UIColor.red
        
        let cellActionB = UITableViewRowAction(style: .default, title: "高亮", handler:
        {_,_ in
            if self.List[indexPath.row].isHighlighted==false
            {
                self.List[indexPath.row].isHighlighted=true
            }
            else
            {
                self.List[indexPath.row].isHighlighted=false
            }
            self.saveData()
            tableView.reloadData()
        })
        cellActionB.backgroundColor = UIColor.green
        return [cellActionB, cellActionA]
    }
    
    @IBAction func AlchemyBut(_ sender: Any)
    {
        if(CurLine! != List.count-1)//当前行不是最后一行时
        {
            List[CurLine!].Status = .done
            CurLine=CurLine!+1
            List[CurLine!].Status = .cur
            tableView.reloadData()
        }
        
    }
    @IBAction func MissionBut(_ sender: Any)
    {
        if(CurProcess != nil)
        {
            if(CurLine==nil)
            {
                alertNoLines()
                return
            }
            switch CurProcess!
            {
            case .first1:
                if(CurLine! < self.List.count-1)//行数足够推进时
                {
                    self.List[CurLine!].Status = .skip
                    CurLine=CurLine!+1
                    self.List[CurLine!].Status = .cur
                    self.tableView.reloadData()
                    proButSelected(sender: ProBut2)//切换到进度状态2
                    CurProcess = .second1
                }
                else
                {alertNoLines()}
            case .second1:
                if(CurLine! < self.List.count-1)
                {
                    self.List[CurLine!].Status = .skip
                    CurLine=CurLine!+1
                    self.List[CurLine!].Status = .cur
                    self.tableView.reloadData()
                    proButSelected(sender: ProBut3)//切换到进度状态3
                    CurProcess = .third2
                }
                else
                {alertNoLines()}
            case .third2:
                if(CurLine! < self.List.count-2)
                {
                    self.List[CurLine!].Status = .skip
                    self.List[CurLine!+1].Status = .skip
                    CurLine=CurLine!+2
                    self.List[CurLine!].Status = .cur
                    self.tableView.reloadData()
                    proButSelected(sender: ProBut1)//切换到进度状态1
                    CurProcess = .first1
                }
                else
                {alertNoLines()}
            }
        }
        else
        {
            alertNoProcess()
        }
        self.saveData()
    }
    
    @IBAction func undoBut(_ sender: UIButton) {
        if(CurLine==0 || CurLine==nil)
        {
            return
        }
        if(self.List[CurLine!-1].Status == .done)//上一步是炼金推进的
        {
            List[CurLine!].Status = .not
            CurLine=CurLine!-1
            List[CurLine!].Status = .cur
            tableView.reloadData()
        }
        else
        {
            if(CurProcess == nil){return}
            switch CurProcess!
            {
            case .first1:
                    self.List[CurLine!].Status = .not
                    self.List[CurLine!-1].Status = .not
                    CurLine=CurLine!-2
                    self.List[CurLine!].Status = .cur
                    self.tableView.reloadData()
                    proButSelected(sender: ProBut3)//切换到进度状态3
                    CurProcess = .third2
            case .second1:
                self.List[CurLine!].Status = .not
                CurLine=CurLine!-1
                self.List[CurLine!].Status = .cur
                self.tableView.reloadData()
                proButSelected(sender: ProBut1)//切换到进度状态1
                CurProcess = .first1
            case .third2:
                self.List[CurLine!].Status = .not
                CurLine=CurLine!-1
                self.List[CurLine!].Status = .cur
                self.tableView.reloadData()
                proButSelected(sender: ProBut2)//切换到进度状态2
                CurProcess = .second1
            }
        }
        self.saveData()
    }
    
    @IBAction func clearBut(_ sender: UIButton) //清空过期条目
    {
        let alertController = UIAlertController(title: "", message: "确定清空所有已跳过或完成的条目？", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "确定", style: .default ,handler:
        {_ in
            while self.List[0].Status == .skip || self.List[0].Status == .done  {
                self.List.remove(at: 0)
            }
            CurLine=0
            self.saveData()
            self.tableView.reloadData()
        })
        
        let noAction = UIAlertAction(title: "取消", style: .default )
        alertController.addAction(okAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    private func saveData()//保存数据
    {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(List, toFile: ListLine.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("data successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save data...", log: OSLog.default, type: .error)
        }
    }
    private func loadData() -> [ListLine]?
    {
        print("loading data")
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: ListLine.ArchiveURL.path) as? [ListLine]
    }
    
    
    func alertNoLines()
    {
        let alertController = UIAlertController(title: "", message: "无法再向前推进了", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "确定", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func alertNoProcess()
    {
        let alertController = UIAlertController(title: "", message: "未确定任务进度！", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "确定", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func ProcessChooseBut(_ sender: UIButton)
    {
        if(ProBut1.isEnabled==true)
        {
            ProBut1.isEnabled=false
            ProBut2.isEnabled=false
            ProBut3.isEnabled=false
        }
        else
        {
            ProBut1.isEnabled=true
            ProBut2.isEnabled=true
            ProBut3.isEnabled=true
        }
    }
    @IBOutlet weak var ProBut1: UIButton!
    @IBOutlet weak var ProBut2: UIButton!
    @IBOutlet weak var ProBut3: UIButton!
    
    var tempProBut:UIButton?=nil
    
    @IBAction func ProcessBut1(_ sender: UIButton)
    {
        proButSelected(sender: sender)
        CurProcess = .first1
    }
    @IBAction func ProcessBut2(_ sender: UIButton)
    {
        proButSelected(sender: sender)
        CurProcess = .second1
    }
    @IBAction func ProcessBut3(_ sender: UIButton)
    {
        proButSelected(sender: sender)
        CurProcess = .third2
    }
    
    func proButSelected(sender:UIButton)
    {
        if(tempProBut==nil)
        {
            sender.isSelected=true
            tempProBut=sender
        }
        else if(tempProBut != nil && tempProBut == sender)
        {
            sender.isSelected=true
        }
        else if(tempProBut != nil && tempProBut != sender)
        {
            tempProBut?.isSelected=false
            sender.isSelected=true
            tempProBut=sender
        }
    }
}

