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
        self.setNaviTintColor()
    }
    func setNaviTintColor() {
        self.navigationController?.navigationBar.barTintColor = Color_Base
        self.navigationController?.navigationBar.backgroundColor = Color_White
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.alpha = 1.0
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color_White,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        
    }
}
