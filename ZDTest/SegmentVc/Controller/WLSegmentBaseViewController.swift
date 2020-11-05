//
//  WLSegmentBaseViewController.swift
//  ZDTest
//
//  Created by kede Han on 2020/11/4.
//

import UIKit

class WLSegmentBaseViewController: WLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setup()
        
    }

    func setup() {
        let titleContenView = WLSegmentBtnScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44), btnArr: ["待接单","待取件","待送达"])
        self.view.addSubview(titleContenView)
        let newTask = WLQiShiTaskViewController()
        let endTask = WLEndTaskTableViewController()
        let segmentContenView = WLSegmentContentScrollView(frame: CGRect(x: 0, y: 44, width: self.view.frame.width, height: self.view.frame.height - 44 - kTabbar_height - kNaviBar_height), childVcs: [newTask, endTask], parentVc: self)
        self.view .addSubview(segmentContenView)
        segmentContenView.setChildVcWithCurrentSelectedIndex(currentSelectedIndex: 1)
        
    }
}
