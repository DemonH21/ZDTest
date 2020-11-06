//
//  WLSegmentContentScrollView.swift
//  ZDTest
//
//  Created by kede Han on 2020/11/4.
//

import UIKit

@objc protocol WLSegmentContentScrollViewDelegate: NSObjectProtocol{
    @objc func segmentContentScrollView(segmentView: WLSegmentContentScrollView, index: Int)
}

class WLSegmentContentScrollView: UIView{

    
    var childVcs: [UIViewController] = []
    var parentVc: UIViewController?
    var previousVc: UIViewController?
    var previousVcIndex:Int = -1
    var startOffset: CGFloat = 0.0
    weak var segmentDelegate: WLSegmentContentScrollViewDelegate?
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.frame = self.bounds
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        let contentWidth = CGFloat(self.childVcs.count)*self.frame.width
        scrollView.contentSize = CGSize(width: contentWidth, height: 0)
        return scrollView
    }()
    
    init(frame: CGRect, childVcs: [UIViewController],parentVc: UIViewController, segmentDelegate: WLSegmentContentScrollViewDelegate){
        super.init(frame: frame)
        self.parentVc = parentVc
        self.childVcs = childVcs
        self.setup()
        self.segmentDelegate = segmentDelegate
    }
    func setup() {
        let temView = UIView()
        self.addSubview(temView)
        self.addSubview(self.scrollView)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}

//MARK: -
extension WLSegmentContentScrollView{
    func setChildVcWithCurrentSelectedIndex(currentSelectedIndex: Int)  {
        let currentVc: UIViewController = self.childVcs[currentSelectedIndex]
        self.startOffset = self.frame.width * CGFloat(currentSelectedIndex)
        let currentVcPoint = CGPoint(x: self.startOffset, y: 0)
        if self.previousVc != nil {
            self.previousVc?.beginAppearanceTransition(false, animated: false)
        }
        if !(self.parentVc?.children.contains(currentVc))!{
            self.parentVc?.addChild(currentVc)
            self.scrollView.addSubview(currentVc.view)
            currentVc.view.frame = CGRect(origin: currentVcPoint, size: self.bounds.size)
            currentVc.didMove(toParent: self.parentVc)
            self.previousVc = currentVc
        }
        currentVc.beginAppearanceTransition(true, animated: false)
        
        self.scrollView.setContentOffset(currentVcPoint, animated: false)
        if self.previousVc != nil {
            self.previousVc?.endAppearanceTransition()
        }
        currentVc.endAppearanceTransition()
    }
}

//MARK: -UIScrollViewDelegate
extension WLSegmentContentScrollView: UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let offset = self.scrollView.contentOffset.x
        if offset == self.startOffset {
            return
        }
        self.previousVc?.beginAppearanceTransition(false, animated: false)
        
        let currentIndex = Int(offset / self.bounds.width)
        let currentVc = self.childVcs[currentIndex]
        self.startOffset = offset
        if !(parentVc?.children.contains(currentVc))! {
            self.parentVc?.addChild(currentVc)
            self.scrollView.addSubview(currentVc.view)
            currentVc.view.frame = CGRect(origin: CGPoint(x: offset, y: 0), size: self.frame.size)
            currentVc.didMove(toParent: self.parentVc)
        }
        currentVc.beginAppearanceTransition(true, animated: false)
        self.previousVc?.endAppearanceTransition() 
        currentVc.endAppearanceTransition()
        self.previousVc = currentVc
        
        if (segmentDelegate?.responds(to: #selector(segmentDelegate?.segmentContentScrollView(segmentView:index:))))! {
            segmentDelegate?.segmentContentScrollView(segmentView: self, index: currentIndex)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
    }
}
