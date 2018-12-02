//
//  ChooseJewelCell.swift
//  MHWGuanXingHelper
//
//  Created by GaoYy on 2018/11/30.
//  Copyright © 2018年 GaoYy. All rights reserved.
//

import UIKit

class ChooseJewelCell: UITableViewCell {

    @IBOutlet weak var ChoiceLableR5: UILabel!
    @IBOutlet weak var ChoiceLableR6: UILabel!
    @IBOutlet weak var ChoiceLableR7: UILabel!
    @IBOutlet weak var ChoiceLableR8: UILabel!
    
    var Jewelid=(-1)//保存该cell对应的珠子的id
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
