//
//  WLSegmentBtnScrollView.swift
//  ZDTest
//
//  Created by kede Han on 2020/11/5.
//

import UIKit

class WLSegmentBtnScrollView: UIView {
    var btnArr: Array<String>
    var additionInterval: CGFloat = 15
    var btnTitleColorNomal = UIColor.black
    var btnTitleColorSelected = UIColor.blue
    let btnFont: CGFloat = 18
    let btnFontSelected: CGFloat = 15
    
    
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    init(frame: CGRect, btnArr: [String]) {
        self.btnArr = btnArr
        super.init(frame: frame)
        self.setup()
        
    }
    func setup(){
        self.addSubview(self.scrollView)
        self.addBtn()
    }
    func addBtn(){
        let font = UIFont.systemFont(ofSize: btnFont)
        var totalTitleWidth: CGFloat = 0
        self.btnArr.forEach { (title) in
            totalTitleWidth += self.calculateStringWidth(str: title, font: font)
        }
        let allWidth = totalTitleWidth + CGFloat(self.btnArr.count + 1) * self.additionInterval
        if allWidth < self.frame.width {
            let btnY: CGFloat = 0
            let btnW: CGFloat = self.frame.width / CGFloat(self.btnArr.count)
            let btnH: CGFloat = self.frame.height
            for index in 0..<self.btnArr.count {
                let title = self.btnArr[index]
                let btn = UIButton(type: .custom)
                btn.frame = CGRect(x: btnW * CGFloat(index), y: btnY, width: btnW, height: btnH)
                btn.setTitle(title, for: .normal)
                btn.backgroundColor = Color_White
                btn.setTitleColor(self.btnTitleColorNomal, for: .normal)
                btn.setTitleColor(self.btnTitleColorSelected, for: .selected)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: btnFont)
                btn.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
                
                self.addSubview(btn)
                
            }
            
        }
        
    }
    
    @objc func buttonAction(button: UIButton){
        
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
