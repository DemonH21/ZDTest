//
//  WLSegmentViewConfiguration.swift
//  ZDTest
//
//  Created by kede Han on 2020/11/9.
//

import Foundation
import UIKit

class WLSegmentViewConfiguration: NSObject {
    //btn额外间距
    var additionInterval: CGFloat = 15
    //btnTitleColor.normal
    var titleNormalColor: UIColor = UIColor.white
    //btnTitleColor.selected
    var titleSelectedColor: UIColor = UIColor.red
    //btnTitleFont.normal
    var titleNormalFont: CGFloat = 18.0
    //btnTitleFont.Selected
    var titleSelectedFont: CGFloat = 20.0
    //btn缩放倍率
    var titleZoomRate: CGFloat = 0.0
    //btn是否缩放
    var isTitleZoom: Bool = false
    
    
    
    //是否展示分割线
    var isShowSeparateLine: Bool = true
    var separateLineHeight: CGFloat = 0.5
    var separateLineColor: UIColor = UIColor.gray
    
    
    
}





