//
//  WLHomeViewController.swift
//  ZDTest
//
//  Created by Perfector on 2020/10/31.
//

import UIKit

class WLHomeViewController: WLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setTabbarController()
        self.view.backgroundColor = Color_White
        self.navigationItem.title = "首页"
    }
    func setTabbarController() {
        let tabVc = WLHomeTabbarController()
        
        self.addChild(tabVc)
        tabVc.didMove(toParent: self)
        self.view.addSubview(tabVc.view)
    }


}
