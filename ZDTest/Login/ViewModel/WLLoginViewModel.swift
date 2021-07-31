//
//  WLLoginViewModel.swift
//  ZDTest
//
//  Created by kede Han on 2020/11/18.
//

import UIKit
import Moya
import Alamofire
class WLLoginViewModel: NSObject {
    
    func login(phoneNum: String, password: String, type: String, completion: @escaping (_ response: [String: Any]) -> ()) {
        let uuidStr = UUID().uuidString
        let params: [String: Any] = ["loginName": phoneNum, "password": password.md5(), "deviceId": uuidStr]
        let provider = MoyaProvider<WLApi>()
        provider.request(.login(params: params)) { (result) in
            switch result {
            case .success(let response):
                let resultDic = try? response.mapJSON() as? NSDictionary
                let status = resultDic?["status"] as? Int
                let message = resultDic?["message"] as? String
                if status == 1 {
                    let user = User()
                    user.setUserInfo(userInfo: resultDic?["result"]! as! NSDictionary)
                }else{
                    
                }
                
                MBProgressHUD.showInWindow(message: message!)
                completion(resultDic as! [String : Any])
            case .failure(let error):
                print(error)
                
            }
        }
    }
}
