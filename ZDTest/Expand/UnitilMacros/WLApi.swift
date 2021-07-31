//
//  WLApi.swift
//  ZDTest
//
//  Created by kede Han on 2020/12/2.
//

import Foundation
import Moya
enum WLApi {
    case login(params: [String: Any])
    case finish_list_short(params: [String: Any])
    
}

extension WLApi: TargetType {
    var baseURL: URL {
        return URL(string: "http://apt.zdtms.com/wuliu-app/")! as URL
    }
    
    var path: String {
        switch self {
        case .login:
            return "user/login.action"
        case .finish_list_short:
            return "shortOrder/finishList.action"
        
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var params: [String: Any] = [:]
        
        switch self {
        case .login(let param),
             .finish_list_short(let param):
            params = param
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return ["version": "70", 
                "fromType": "ios", 
                "token": "19593zdws86ce938ec954b984d6bf3960bc313e8d"]
    }
    
    
    
}
