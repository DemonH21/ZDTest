//
//  String+.swift
//  ZDTest
//
//  Created by Perfector on 2020/10/31.
//

import Foundation

extension String {
        
    func isMatch(_ rules: String) -> Bool {
        let rules = NSPredicate(format: "SELF MATCHES '\(rules)'")
        let isMatch: Bool = rules.evaluate(with: self)
        return isMatch
    }
    //判断电话号码
    func isMobile() -> Bool {
        return isMatch("^1[0-9]{10}$")
    }
    //判断身份证是否为18位
    func isUserIdcard() -> Bool {
        return isMatch("^[0-9]{17}([0-9]|x)$")
    }
    //判断是否都是数字
    func isNumber() -> Bool {
        return isMatch("^[0-9]*$")
    }
    //判断用户邮箱
    func isEmail() -> Bool {
        return isMatch("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
    }
    //判断密码6-18位
    func isPassword() -> Bool {
        // (?![0-9]+$)(?![a-zA-Z]+$)
        return isMatch("^[a-zA-Z0-9]{6,18}")
        
    }
}
import CommonCrypto
extension String {
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: digestLen)
        return String(format: hash as String)
        
    }
    
}
