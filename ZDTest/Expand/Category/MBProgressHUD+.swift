//
//  MBProgressHUD+.swift
//  ZDTest
//
//  Created by kede Han on 2020/11/17.
//

import Foundation
let MB_ATimer: CGFloat = 2
private var key: Void?
extension MBProgressHUD{
    class func creatMBProgressHUD(message: String, frontView: UIView?) -> MBProgressHUD {
        let view: UIView!
        if frontView != nil {
            view = frontView
        }else{
            view = UIApplication.shared.keyWindow
        }
        var hud = forView(view)
        if hud != nil {
            hud?.show(animated: true)
        }else{
            hud = showAdded(to: view, animated: true)
        }
        hud?.minSize = CGSize(width: 60, height: 60)
        var showMsg: String
        if message.isEmpty {
            showMsg = "加载中..."
        }else{
            showMsg = message
        }
        hud?.label.text = showMsg
        hud?.label.font = UIFont.systemFont(ofSize: 15)
        hud?.label.textColor = UIColor.white
        hud?.label.numberOfLines = 0
        hud?.bezelView.style = .solidColor
        hud?.bezelView.color = UIColor(white: 0, alpha: 0.8)
        hud?.removeFromSuperViewOnHide = true
        hud?.contentColor = UIColor.white
        return hud!
    }
    
    class func showInWindow(message: String){
        if message.isEmpty {
            return
        }
        showTimer(message: message, frontView: nil, aTimer: MB_ATimer)
    }
    class func showInWindow(message: String, afterTime: CGFloat){
        if message.isEmpty {
            return
        }
        showTimer(message: message, frontView: nil, aTimer: afterTime)
    }
    class func showInView(message: String, frontView: UIView){
        if message.isEmpty {
            return
        }
        showTimer(message: message, frontView: nil, aTimer: MB_ATimer)
    }
    class func showInView(message: String, frontView: UIView, afterTime: CGFloat){
        if message.isEmpty {
            return
        }
        showTimer(message: message, frontView: nil, aTimer: afterTime)
    }
    class func showLoadingInWindow(message: String) {
        showLoading(message: message, frontView: nil, afterTimer: 0)
    }
    class func showLoadingInView(message: String, frontView: UIView) {
        showLoading(message: message, frontView: frontView, afterTimer: 0)
    }
    class func showSuccess(message: String){
        showIcon(message: message, iconName: "MBHUD_Success")
    }
    class func showError(message: String){
        showIcon(message: message, iconName: "MBHUD_Error")
    }
    class func showInfo(message: String){
        showIcon(message: message, iconName: "MBHUD_Info")
    }
    class func showWarning(message: String){
        showIcon(message: message, iconName: "MBHUD_Warn")
    }
    class func showIcon(message: String, iconName: String){
        showCostom(iconName: iconName, message: message, frontView: nil)
    }
    class func showCostom(iconName: String, message: String, frontView: UIView?){
        let hud = creatMBProgressHUD(message: message, frontView: frontView)
        hud.mode = .customView
        hud.customView = UIImageView(image: UIImage(named: iconName))
        hud.hide(animated: true, afterDelay: TimeInterval(MB_ATimer))
        
    }
    class func showTimer(message: String, frontView: UIView?, aTimer: CGFloat){
        let hud = creatMBProgressHUD(message: message, frontView: frontView)
        hud.mode = .text
        hud.hide(animated: true, afterDelay: TimeInterval(aTimer))
        
    }
    class func showLoading(message: String, frontView: UIView?, afterTimer: CGFloat) {
        let hud = creatMBProgressHUD(message: message, frontView: frontView)
        hud.mode = .indeterminate
        if afterTimer > 0 {
            hud.hide(animated: true, afterDelay: TimeInterval(afterTimer))
        }
    }
    class func hidHUD(frontView: UIView){
        DispatchQueue.main.async {
            hide(for: frontView, animated: true)
        }
    }
    class func hideHUD(){
        DispatchQueue.main.async {
            let window = UIApplication.shared.keyWindow!
            hide(for: window, animated: true)
        }
    }
    
    
    
    class func getCurrentVc() -> UIViewController{
        var resultVc: UIViewController
        
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            let windowsArr = UIApplication.shared.windows
            for tepWind in windowsArr {
                if tepWind.windowLevel == UIWindow.Level.normal {
                    window = tepWind
                    break
                }
            }
            
        }
        let frontView = window?.subviews[0]
        let nextResponder = frontView?.next
        if nextResponder is UIViewController {
            resultVc = nextResponder as! UIViewController
        }else{
            resultVc = (window?.rootViewController)!
        }
        return resultVc
    }
}
