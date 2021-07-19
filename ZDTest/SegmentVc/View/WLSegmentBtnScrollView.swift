//
//  WLSegmentBtnScrollView.swift
//  ZDTest
//
//  Created by kede Han on 2020/11/5.
//

import UIKit


@objc protocol WLSegmentBtnScrollViewDelegate: NSObjectProtocol {
    @objc func btnScrollViewSelectedIndex(segmentBtnView: WLSegmentBtnScrollView, selectedIndex: Int)
}

class WLSegmentBtnScrollView: UIView {
    var titleArr: Array<String>
    var btnArr: Array<UIButton> = []
    weak var delegate: WLSegmentBtnScrollViewDelegate?
    var config: WLSegmentViewConfiguration!
    lazy var separateLineView: UIView = {
        let separateLineView: UIView = UIView()
        separateLineView.frame = CGRect(x: 0, y: self.frame.height - config.separateLineHeight, width: self.frame.width, height: config.separateLineHeight)
        separateLineView.backgroundColor = config.separateLineColor
        return separateLineView
    }()
    
    
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    init(frame: CGRect, btnArr: [String], delegate: WLSegmentBtnScrollViewDelegate, config: WLSegmentViewConfiguration) {
        titleArr = btnArr
        super.init(frame: frame)
        self.config = config
        setup()
        self.delegate = delegate
        
        
    }
    //MARK: -
    //FIXME:--
    //TODO:----
    //WARNNING:
    func setup(){
        self.addSubview(self.scrollView)
        
        self.addBtn()
        if config.isShowSeparateLine {
            self.addSubview(separateLineView)
        }
    }
    func addBtn(){
        let font = UIFont.systemFont(ofSize: self.config.titleNormalFont)
        var totalTitleWidth: CGFloat = 0
        titleArr.forEach { (title) in
            totalTitleWidth += self.calculateStringWidth(str: title, font: font)
        }
        let allWidth = totalTitleWidth + CGFloat(titleArr.count + 1) * config.additionInterval
        var sumWidthArr: [CGFloat] = [0]
        scrollView.contentSize = CGSize(width: allWidth, height: 0)
        if allWidth < self.frame.width {
            for _ in 0..<titleArr.count {
                let width: CGFloat = self.frame.width / CGFloat(titleArr.count)
                sumWidthArr.append(width)
            }
            
        }else{
            for index in 0..<titleArr.count {
                let width: CGFloat = config.additionInterval + calculateStringWidth(str: titleArr[index], font: font)
                sumWidthArr.append(width)
            }
        }
        initialBtn(sumWidthArr: sumWidthArr)
        
    }
    func initialBtn(sumWidthArr: [CGFloat]){
        let btnY: CGFloat = 0
        let btnH: CGFloat = self.frame.height
        var allWidth: CGFloat = 0
        for index in 0..<titleArr.count {
            allWidth  += sumWidthArr[index]
            let title = self.titleArr[index]
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: allWidth, y: btnY, width: sumWidthArr[index + 1], height: btnH)
            btn.setTitle(title, for: .normal)
            btn.tag = index
            btn.titleLabel?.textAlignment = .center
            btn.backgroundColor = Color_White
            let attrDicN = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: config.titleNormalFont, weight: .light),NSAttributedString.Key.foregroundColor: config.titleNormalColor]
            let attrStrN = NSAttributedString(string: titleArr[index], attributes: attrDicN)
            let attrDicS = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: config.titleSelectedFont, weight: .bold),NSAttributedString.Key.foregroundColor:config.titleSelectedColor]
            let attrStrS = NSAttributedString(string: titleArr[index], attributes: attrDicS)
            btn.setAttributedTitle(attrStrN, for: .normal)
            btn.setAttributedTitle(attrStrS, for: .selected)
            btn.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
            btnArr.append(btn)
            scrollView.addSubview(btn)
            
        }
    }
    
    @objc func buttonAction(button: UIButton){
        if !button.isSelected {
            button.isSelected = true
            if (delegate?.responds(to: #selector(delegate?.btnScrollViewSelectedIndex(segmentBtnView:selectedIndex:))))! {
                delegate?.btnScrollViewSelectedIndex(segmentBtnView: self, selectedIndex: button.tag)
            }
        }
        btnArr.forEach { (btn) in
            if btn.tag != button.tag{
                btn.isSelected = false
            }
        }
    }
    func setBtnStatus(index: Int) {
        btnArr.forEach { (button) in
            button.transform = CGAffineTransform(scaleX: 1, y: 1)
            if button.tag == index {
                button.isSelected = true
            }else{
                button.isSelected = false
            }
        }
    }
    func setTitleViewStatus(progress: CGFloat, targetIndex: Int, previousIndex: Int)  {
        let targetBtn = btnArr[targetIndex]
        let previousBtn = btnArr[previousIndex]
        var realProgress: CGFloat = 0
        if targetIndex == previousIndex {
            return
        }
        if config.isTitleZoom {
            if config.titleZoomRate != 0 {
                realProgress = progress * config.titleZoomRate
            }else{
                realProgress = progress * (config.titleSelectedFont - config.titleNormalFont) / config.titleSelectedFont
            }
        }
        print("----\(realProgress)")
        targetBtn.transform = CGAffineTransform(scaleX: realProgress + 1, y: realProgress + 1)
        previousBtn.transform = CGAffineTransform(scaleX: (1.0 / (1 + realProgress)), y: (1.0 / (1 + realProgress)))
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
}

extension WLSegmentBtnScrollView: UIScrollViewDelegate{
    
}


extension WLSegmentBtnScrollView{
    func calculateStringWidth(str: String, font: UIFont) -> CGFloat {
        let attrDict = [NSAttributedString.Key.font: font]
        let attrStr = NSAttributedString(string: str, attributes: attrDict)
        let size = attrStr.boundingRect(with: CGSize(width: 0, height: 0), options: .usesLineFragmentOrigin, context: nil).size
        return size.width
        
    }
}
