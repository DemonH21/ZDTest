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
    var additionInterval: CGFloat = 15
    var btnTitleColorNomal = UIColor.black
    var btnTitleColorSelected = UIColor.blue
    let btnFont: CGFloat = 18
    let btnFontSelected: CGFloat = 15
    var btnArr: Array<UIButton> = []
    weak var delegate: WLSegmentBtnScrollViewDelegate?
    
    
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    init(frame: CGRect, btnArr: [String], delegate: WLSegmentBtnScrollViewDelegate) {
        titleArr = btnArr
        super.init(frame: frame)
        self.setup()
        self.delegate = delegate
        
    }
    func setup(){
        self.addSubview(self.scrollView)
        self.addBtn()
    }
    func addBtn(){
        let font = UIFont.systemFont(ofSize: btnFont)
        var totalTitleWidth: CGFloat = 0
        self.titleArr.forEach { (title) in
            totalTitleWidth += self.calculateStringWidth(str: title, font: font)
        }
        let allWidth = totalTitleWidth + CGFloat(self.titleArr.count + 1) * additionInterval
        if allWidth < self.frame.width {
            let btnY: CGFloat = 0
            let btnW: CGFloat = self.frame.width / CGFloat(self.titleArr.count)
            let btnH: CGFloat = self.frame.height
            for index in 0..<self.titleArr.count {
                let title = self.titleArr[index]
                let btn = UIButton(type: .custom)
                btn.frame = CGRect(x: btnW * CGFloat(index), y: btnY, width: btnW, height: btnH)
                btn.setTitle(title, for: .normal)
                btn.tag = index
                btn.backgroundColor = Color_White

                let attrDicN = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .light),NSAttributedString.Key.foregroundColor: btnTitleColorNomal]
                let attrStrN = NSAttributedString(string: titleArr[index], attributes: attrDicN)
                let attrDicS = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold),NSAttributedString.Key.foregroundColor:btnTitleColorSelected]
                let attrStrS = NSAttributedString(string: titleArr[index], attributes: attrDicS)
                btn.setAttributedTitle(attrStrN, for: .normal)
                btn.setAttributedTitle(attrStrS, for: .selected)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: btnFont)
                btn.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
                btnArr.append(btn)
                self.addSubview(btn)
                
            }
            
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
            if button.tag == index {
                button.isSelected = true
            }else{
                button.isSelected = false
            }
        }
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
