//
//  ZDHomeTabbarController.swift
//  ZDTest
//
//  Created by Perfector on 2020/10/31.
//

import UIKit

class WLHomeTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.setBarItem()
        self.setTabbarViewControllers()
        self.view.backgroundColor = Color_White
    }
    
    func setTabbarViewControllers() {
        let itemArr = self.readItemData()
        let temArr: NSMutableArray? = []
        for dic: NSDictionary in itemArr {
            let nav = WLBaseNavigationController()
            nav.tabBarItem = self.setBarItem(title: dic["item"] as! String, image: dic["image"] as! String, imageSelect: dic["imageSelected"] as! String, tag: dic["tag"] as! String)
            temArr?.add(nav)
        }
        self.viewControllers = temArr?.copy() as? [UIViewController]
    }
    func setBarItem(title: String, image: String, imageSelect: String, tag: String) -> UITabBarItem {
        let barItem = UITabBarItem(title: title, image: UIImage(named: image), tag: (tag as NSString).integerValue)
        barItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        barItem.selectedImage = UIImage(named: imageSelect)?.withRenderingMode(.alwaysOriginal)
        barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Color_Base], for: .selected)
        return barItem
        
        
        
    }
    func readItemData() -> [NSDictionary] {
        let path = Bundle.main.path(forResource: "barItem_list", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let itemArr = jsonData as! NSArray
            print(itemArr)
            return itemArr as! [NSDictionary]
        } catch _ as Error? {
            print("读取本地数据失败")
            return []
        }
        
    }
    
}
