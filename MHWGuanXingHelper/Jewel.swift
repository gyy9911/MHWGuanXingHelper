//
//  Jewel.swift
//  MHWGuanXingHelper
//
//  Created by GaoYy on 2018/11/29.
//  Copyright © 2018年 GaoYy. All rights reserved.
//

import UIKit
import os.log
class Jewel{

    var ename:String
    var cname:String
    var slot:Int
    var rare:Int
    var id:Int
    var image:UIImage?
    
    //init
    init(id:Int, ename:String,cname:String,slot:Int, rare:Int, image:UIImage?) {
        self.id=id
        self.ename=ename
        self.cname=cname
        self.slot=slot
        self.rare=rare
        self.image=image
        
    }
}
class ListLine:NSObject, NSCoding{
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(Jewel1.id, forKey: PropertyKey.Jewel1)
        aCoder.encode(Jewel2.id, forKey: PropertyKey.Jewel2)
        aCoder.encode(Jewel3.id, forKey: PropertyKey.Jewel3)
        //aCoder.encode(Status, forKey: PropertyKey.Status)
        aCoder.encode(isHighlighted, forKey: PropertyKey.isHighlighted)
    }
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        guard let Jewel1id = aDecoder.decodeObject(forKey: PropertyKey.Jewel1) as? Int else {
            os_log("Unable to decode the jewel1.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let Jewel2id = aDecoder.decodeObject(forKey: PropertyKey.Jewel2) as? Int else {
            os_log("Unable to decode the jewel2.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let Jewel3id = aDecoder.decodeObject(forKey: PropertyKey.Jewel3) as? Int else {
            os_log("Unable to decode the jewel3.", log: OSLog.default, type: .debug)
            return nil
        }
        /*
        guard let Status = aDecoder.decodeObject(forKey: PropertyKey.Status) as? StatusType else {
            os_log("Unable to decode the status.", log: OSLog.default, type: .debug)
            return nil
        }*/
        guard let isHighlighted = aDecoder.decodeObject(forKey: PropertyKey.isHighlighted) as? Bool else {
            os_log("Unable to decode the isHighlighted status.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
    self.init(Jewel1:JewelData[Jewel1id],Jewel2:JewelData[Jewel2id],Jewel3:JewelData[Jewel3id],Status:StatusType.not,isHighlighted:isHighlighted)
    }
    //ListLine保存某组炼金结果，一组三个
    enum StatusType{case done,skip,not,cur,next} //该组当前状态：已炼金、已跳过、没到、当前结果
    var Status:StatusType
    var Jewel1:Jewel
    var Jewel2:Jewel
    var Jewel3:Jewel
    var isHighlighted:Bool //是否高亮
    
    struct PropertyKey {
        static let Jewel1 = "Jewel1"
        static let Jewel2 = "Jewel2"
        static let Jewel3 = "Jewel3"
        static let Status = "Status"
        static let isHighlighted = "isHighlighted"
    }
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Jewels")
    
    init(Jewel1:Jewel,Jewel2:Jewel,Jewel3:Jewel)
    {
        self.Jewel1=Jewel1
        self.Jewel2=Jewel2
        self.Jewel3=Jewel3
        Status=StatusType.not
        isHighlighted=false
    }
    init(Jewel1:Jewel,Jewel2:Jewel,Jewel3:Jewel,Status:StatusType,isHighlighted:Bool)
    {
        self.Jewel1=Jewel1
        self.Jewel2=Jewel2
        self.Jewel3=Jewel3
        self.Status=Status
        self.isHighlighted=isHighlighted
    }
}
