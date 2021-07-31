//
//  WLDefaultUsers.swift
//  ZDTest
//
//  Created by kede Han on 2020/12/3.
//

import Foundation

let NewHomeModuleAuthType: String = "NewHomeModuleAuthType"
let UserLoginToken: String = "UserLoginToken"
let UserLoginName = "UserLoginName"
let UserName = "UserName"
let UserLoginAuthType = "UserLoginAuthType"
let UserIsLoginStatus = "UserIsLoginStatus"
let userDefault = UserDefaults.standard

class User {
    var authTypeArr: NSArray {
        set {
            userDefault.set(newValue, forKey: NewHomeModuleAuthType)
            userDefault.synchronize()
        }
        get {
            return userDefault.value(forKey: NewHomeModuleAuthType) as! NSArray
        }
        
    }
    var token: String {
        set {
            userDefault.set(newValue, forKey: UserLoginToken)
            userDefault.synchronize()
        }
        get {
            return userDefault.value(forKey: UserLoginToken) as! String
        }
    }
    
    var userName: String {
        set {
            userDefault.set(newValue, forKey: UserName)
            userDefault.synchronize()
        }
        get {
            return userDefault.value(forKey: UserName) as! String
        }
    }
    var loginName: String {
        set {
            userDefault.set(newValue, forKey: UserLoginName)
            userDefault.synchronize()
        }
        get {
            return userDefault.value(forKey: UserLoginName) as! String
        }
    }
    var authType: String{
        set {
            userDefault.set(newValue, forKey: UserLoginAuthType)
            userDefault.synchronize()
        }
        get {
            return userDefault.value(forKey: UserLoginAuthType) as! String
        }
    }
    var isLogin: Bool{
        set {
            userDefault.setValue(newValue, forKey: UserIsLoginStatus)
            userDefault.synchronize()
        }
        get {
            return (userDefault.value(forKey: UserIsLoginStatus) != nil)
        }
    }
    
    func setUserInfo(userInfo: NSDictionary) {
        let loginName: String = userInfo["loginName"] as! String
        let token: String = userInfo["token"] as! String
        let userName: String = userInfo["userName"] as! String
        
        self.loginName = loginName
        self.userName = userName
        self.token = token
        self.isLogin = true
    }
}
