//
//  AppDelegate.swift
//  ZDTest
//
//  Created by Perfector on 2020/10/31.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow? = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13.0, *) {
            
        }else{	
            self.window = UIWindow.init(frame: UIScreen.main.bounds)
            let homeVc = WLHomeViewController()
            self.window?.rootViewController = homeVc
            self.window?.makeKeyAndVisible()
            
            
        }
        return true
    }

    // MARK: UISceneSession Lifecycle


    //  这是测试测试测试
<<<<<<< HEAD

=======
    // 呵呵呵这也是测试
    //这是1
    //这是2
    //这是3
    // lklkl
    // dsfd
    func test() {
        
    }
    //dfsfd
    func test1() {
        
    }
>>>>>>> TestBranch
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

