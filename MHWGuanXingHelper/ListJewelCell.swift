//
//  ListJewelCell.swift
//  MHWGuanXingHelper
//
//  Created by GaoYy on 2018/11/30.
//  Copyright © 2018年 GaoYy. All rights reserved.
//

import UIKit

class ListJewelCell: UITableViewCell {

    @IBOutlet weak var ProgressImage: UIImageView!
    @IBOutlet weak var Image1: UIImageView!
    @IBOutlet weak var Name1: UILabel!
    @IBOutlet weak var Image2: UIImageView!
    @IBOutlet weak var Name2: UILabel!
    @IBOutlet weak var Image3: UIImageView!
    @IBOutlet weak var Name3: UILabel!
    
    var Jewel1:Jewel?
    var Jewel2:Jewel?
    var Jewel3:Jewel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
