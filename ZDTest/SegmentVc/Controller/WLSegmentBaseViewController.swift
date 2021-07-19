//
//  WLSegmentBaseViewController.swift
//  ZDTest
//
//  Created by kede Han on 2020/11/4.
//

import UIKit
import Alamofire
import Foundation
class WLSegmentBaseViewController: WLBaseViewController{
    
    var scrollContentView: WLSegmentContentScrollView? = nil
    var btnScrollView: WLSegmentBtnScrollView? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        
    }

    func setup() {
        let configure: WLSegmentViewConfiguration = WLSegmentViewConfiguration()
        configure.titleNormalColor = Color_Black
        configure.titleSelectedColor = Color_Base
        configure.separateLineColor = Color_separateLine
        configure.isTitleZoom = true
        configure.additionInterval = 30
        btnScrollView = WLSegmentBtnScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44), btnArr: ["待接单","待取件","待送达"], delegate: self, config: configure)
        self.view.addSubview(btnScrollView!)
        let newTask = WLQiShiTaskViewController()
        let endTask = WLEndTaskTableViewController()
        let newTask1 = WLQiShiTaskViewController()
        self.scrollContentView = WLSegmentContentScrollView(frame: CGRect(x: 0, y: 44, width: self.view.frame.width, height: self.view.frame.height - 44 - kTabbar_height - kNaviBar_height), childVcs: [newTask, endTask,newTask1], parentVc: self, segmentDelegate: self)
        self.view.addSubview(scrollContentView!)
        scrollContentView!.setChildVcWithCurrentSelectedIndex(currentSelectedIndex: 0)
        
        
    }
}
extension WLSegmentBaseViewController: WLSegmentBtnScrollViewDelegate,WLSegmentContentScrollViewDelegate{
    func segmentContentScrollView(segmentView: WLSegmentContentScrollView, targetIndex: Int, previousIndex: Int, progress: CGFloat) {
//        btnScrollView?.setBtnStatus(index: index)
        btnScrollView?.setTitleViewStatus(progress: progress, targetIndex: targetIndex, previousIndex: previousIndex)
    }
    func segmentContentScrollView(segmentView: WLSegmentContentScrollView, index: Int) {
//        btnScrollView?.setBtnStatus(index: index)
        btnScrollView?.setBtnStatus(index: index)
        testNetwork()
    }
    
    func btnScrollViewSelectedIndex(segmentBtnView: WLSegmentBtnScrollView, selectedIndex: Int) {
        scrollContentView?.setChildVcWithCurrentSelectedIndex(currentSelectedIndex: selectedIndex)
    }
}
extension WLSegmentBaseViewController {
    func testNetwork(){
        
        let params: [String: String] = ["currentPage":"1"]
        let dic = ["version": "70", 
                   "fromType": "ios", 
                   "token": "19593zdws7b186cf1afb9239f547a1f99bbdee605"]
        let headers: HTTPHeaders = HTTPHeaders(dic)
        let url = "http://apt.zdtms.com/wuliu-app/shortOrder/finishList.action"
        
        AF.request(url, method: HTTPMethod.get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: headers, interceptor: nil, requestModifier: nil).response { (response) in
        }
        
        
        
    }

    
}


