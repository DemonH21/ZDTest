//
//  WLSegmentContentScrollView.swift
//  ZDTest
//
//  Created by kede Han on 2020/11/4.
//

import UIKit

@objc protocol WLSegmentContentScrollViewDelegate: NSObjectProtocol{
    @objc func segmentContentScrollView(segmentView: WLSegmentContentScrollView, targetIndex: Int, previousIndex: Int , progress: CGFloat)
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
        let currentVc: UIViewController = childVcs[currentSelectedIndex]
        startOffset = self.frame.width * CGFloat(currentSelectedIndex)
        let currentVcPoint = CGPoint(x: startOffset, y: 0)
        if previousVc != nil {
            previousVc?.beginAppearanceTransition(false, animated: false)
        }
        var firstAdd: Bool = false
        if !(parentVc?.children.contains(currentVc))!{
            parentVc?.addChild(currentVc)
            scrollView.addSubview(currentVc.view)
            currentVc.view.frame = CGRect(origin: currentVcPoint, size: self.bounds.size)
            currentVc.didMove(toParent: parentVc)
            firstAdd = true
            
        }
        if !firstAdd {
            currentVc.beginAppearanceTransition(true, animated: false)
        }
        
        
        scrollView.setContentOffset(currentVcPoint, animated: false)
        if previousVc != nil {
            previousVc?.endAppearanceTransition()
        }
        previousVc = currentVc
        if !firstAdd {
            currentVc.endAppearanceTransition()
        }
        
        if (segmentDelegate?.responds(to: #selector(segmentDelegate?.segmentContentScrollView(segmentView:index:))))! {
            segmentDelegate?.segmentContentScrollView(segmentView: self, index: currentSelectedIndex)
        }
    }
}

//MARK: -UIScrollViewDelegate
extension WLSegmentContentScrollView: UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("1")
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("2")
        let offset = self.scrollView.contentOffset.x
        if offset == self.startOffset {
            return
        }
        previousVc?.beginAppearanceTransition(false, animated: false)
        let currentIndex = Int(offset / self.bounds.width)
        let currentVc = self.childVcs[currentIndex]
        startOffset = offset
        if !(parentVc?.children.contains(currentVc))! {
            parentVc?.addChild(currentVc)
            scrollView.addSubview(currentVc.view)
            currentVc.view.frame = CGRect(origin: CGPoint(x: offset, y: 0), size: self.frame.size)
            currentVc.didMove(toParent: parentVc)
        }
        currentVc.beginAppearanceTransition(true, animated: false)
        previousVc?.endAppearanceTransition() 
        currentVc.endAppearanceTransition()
        previousVc = currentVc
        
        if (segmentDelegate?.responds(to: #selector(segmentDelegate?.segmentContentScrollView(segmentView:index:))))! {
            segmentDelegate?.segmentContentScrollView(segmentView: self, index: currentIndex)
        }
 
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var progress: CGFloat = (startOffset - scrollView.contentOffset.x) / self.frame.width
        var targetIndex: Int = 0
        var previousIndex: Int = 0
        //向左
        if progress == 0 {
            return
        }
        if progress > 0{
            targetIndex = Int(startOffset / self.frame.width) - 1
            previousIndex = targetIndex + 1
        }else{
            targetIndex = Int(startOffset / self.frame.width) + 1
            progress = -progress
            previousIndex = targetIndex - 1
        }
        if (segmentDelegate?.responds(to: #selector(segmentDelegate?.segmentContentScrollView(segmentView:targetIndex:previousIndex:progress:))))! {
            segmentDelegate?.segmentContentScrollView(segmentView: self, targetIndex: targetIndex,previousIndex: previousIndex,progress: progress)
        }
//        print("progress\(progress)")
    }
}
