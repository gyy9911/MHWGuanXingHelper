//
//  TabViewCotrollerViewController.swift
//  MHWGuanXingHelper
//
//  Created by GaoYy on 2018/12/3.
//  Copyright © 2018年 GaoYy. All rights reserved.
//

import UIKit
import os.log

class TabViewCotroller: UITabBarController {

    @IBOutlet weak var SaveButton: UIBarButtonItem!
    
    var Jewel1:Int?
    var Jewel2:Int?
    var Jewel3:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === SaveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
    }


}
