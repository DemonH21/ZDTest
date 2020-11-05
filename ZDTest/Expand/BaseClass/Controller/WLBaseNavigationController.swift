//
//  WLBaseNavigationController.swift
//  ZDTest
//
//  Created by Perfector on 2020/10/31.
//

import UIKit

class WLBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.setNaviTintColor()
    }
    
    func setNaviTintColor() {
        self.navigationBar.tintColor = Color_Base
    }

}
