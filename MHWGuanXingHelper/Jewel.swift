//
//  Jewel.swift
//  MHWGuanXingHelper
//
//  Created by GaoYy on 2018/11/29.
//  Copyright © 2018年 GaoYy. All rights reserved.
//

import UIKit
class Jewel{
    //properties
    
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
class ListLine{     //某组炼金结果，一组三个
    enum StatusType{case done,skip,not,cur,next} //该组当前状态：已炼金、已跳过、没到、当前结果
    var Status:StatusType
    var Jewel1:Jewel
    var Jewel2:Jewel
    var Jewel3:Jewel
    var isHighlighted:Bool //是否高亮
    
    init(Jewel1:Jewel,Jewel2:Jewel,Jewel3:Jewel) {
        self.Jewel1=Jewel1
        self.Jewel2=Jewel2
        self.Jewel3=Jewel3
        Status=StatusType.not
        isHighlighted=false
    }
}
