//
//  UIView+.swift
//  TestZD
//
//  Created by kede Han on 2020/10/30.
//

import Foundation
import UIKit

extension UIView {
    func x(object: UIView) -> CGFloat{
        return object.frame.origin.x
    }
    func y(object: UIView) -> CGFloat{
        return object.frame.origin.y
    }
    func width(object: UIView) -> CGFloat{
        return object.frame.size.width
    }
    func height(object: UIView) -> CGFloat{
        return object.frame.size.height
    }
}
