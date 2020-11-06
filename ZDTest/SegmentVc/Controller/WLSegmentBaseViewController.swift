//
//  WLSegmentBaseViewController.swift
//  ZDTest
//
//  Created by kede Han on 2020/11/4.
//

import UIKit

class WLSegmentBaseViewController: WLBaseViewController{
    
    var scrollContentView: WLSegmentContentScrollView? = nil
    var btnScrollView: WLSegmentBtnScrollView? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setup()
        
    }

    func setup() {
        btnScrollView = WLSegmentBtnScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44), btnArr: ["待接单","待取件","待送达"], delegate: self)
        self.view.addSubview(btnScrollView!)
        let newTask = WLQiShiTaskViewController()
        let endTask = WLEndTaskTableViewController()
        self.scrollContentView = WLSegmentContentScrollView(frame: CGRect(x: 0, y: 44, width: self.view.frame.width, height: self.view.frame.height - 44 - kTabbar_height - kNaviBar_height), childVcs: [newTask, endTask], parentVc: self, segmentDelegate: self)
        self.view.addSubview(scrollContentView!)
        scrollContentView!.setChildVcWithCurrentSelectedIndex(currentSelectedIndex: 1)
        
    }
}
extension WLSegmentBaseViewController: WLSegmentBtnScrollViewDelegate,WLSegmentContentScrollViewDelegate{
    func segmentContentScrollView(segmentView: WLSegmentContentScrollView, index: Int) {
        btnScrollView?.setBtnStatus(index: index)
    }
    
    func btnScrollViewSelectedIndex(segmentBtnView: WLSegmentBtnScrollView, selectedIndex: Int) {
        scrollContentView?.setChildVcWithCurrentSelectedIndex(currentSelectedIndex: selectedIndex)
    }
}

