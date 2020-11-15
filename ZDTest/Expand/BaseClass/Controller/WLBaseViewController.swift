//
//  WLBaseViewController.swift
//  ZDTest
//
//  Created by Perfector on 2020/10/31.
//

import UIKit

class WLBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setBackBarItem()
        setNaviTintColor()
        
    }
    func setNaviTintColor() {
        self.navigationController?.navigationBar.barTintColor = Color_Base
        self.navigationController?.navigationBar.backgroundColor = Color_White
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.alpha = 1.0
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color_White,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    func setBackBarItem(){
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        if self.navigationController != nil && self.navigationController!.viewControllers.count > 1 {
            let image = UIImage(named: "wl_nav_backItem")?.withRenderingMode(.alwaysOriginal)
            let barBtnItem = UIBarButtonItem(image: image, style: UIBarButtonItem.Style.plain, target: self, action: #selector(wl_popViewController))
            self.navigationItem.leftBarButtonItem = barBtnItem
            
        }
    }
    @objc func wl_popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}
