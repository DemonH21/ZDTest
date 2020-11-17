//
//  WLLoginViewController.swift
//  ZDTest
//
//  Created by kede Han on 2020/11/12.
//

import UIKit
import SnapKit
//import Alamofire
//import MBProgressHUD
class WLLoginViewController: WLBaseViewController {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Color_default_background
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    var phoneTextField: UITextField? = nil
    var codeTextField: UITextField? = nil
    var codeRightImageView: UIImageView? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        let tapG = UITapGestureRecognizer(target: self, action: #selector(wl_dismissKeyBoard(gues:)))
        scrollView.addGestureRecognizer(tapG)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = self.view.bounds
        
    }

    func setup() {
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalTo(self.view)
        }
        
        let backImageView = UIImageView(image: #imageLiteral(resourceName: "wl_login_header"))
        
        scrollView.addSubview(backImageView)
        
        backImageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(scrollView)
            make.width.equalTo(KScreen_width)
            make.height.equalTo(backImageView.snp.width).multipliedBy(351.0/375)
        }
        
        let midView = UIView()
        midView.backgroundColor = UIColor.clear
        let midBackImageView = UIImageView(image: #imageLiteral(resourceName: "wl_login_whiteBack"))
        let phoneTextField = UITextField()
        
        phoneTextField.placeholder = "请输入手机号"
        phoneTextField.keyboardType = .decimalPad
        phoneTextField.font = UIFont.systemFont(ofSize: 14)
        let phoneLeftView = setTextFieldView(imageName: "wl_login_userPhone_log", codeRightView: false)
        phoneTextField.leftView = phoneLeftView
        phoneTextField.leftViewMode = .always
        
        let phoneRightView = setTextFieldView(imageName: "wl_login_userPhone_delete", codeRightView: false)
        phoneRightView.tag = 100
        phoneTextField.rightView = phoneRightView
        phoneTextField.rightViewMode = .whileEditing
        self.phoneTextField = phoneTextField
        
        
        let codeTextField = UITextField()
        codeTextField.placeholder = "请输入大于等于6位的密码"
        
        codeTextField.keyboardType = .asciiCapable
        codeTextField.font = UIFont.systemFont(ofSize: 14)
        codeTextField.isSecureTextEntry = true
        self.codeTextField = codeTextField
        
        let codeTextLeftView = setTextFieldView(imageName: "wl_login_passwd_log", codeRightView: false)
        codeTextField.leftView = codeTextLeftView
        codeTextField.leftViewMode = .always
        
        let codeTextRightView = setTextFieldView(imageName: "wl_login_passwd_invisible", codeRightView: true)
        codeTextField.rightView = codeTextRightView
        codeTextField.rightViewMode = .always
        codeTextRightView.tag = 200
        let tapG1 = UITapGestureRecognizer(target: self, action: #selector(textFieldTapGusture(gues:)))
        let tapG2 = UITapGestureRecognizer(target: self, action: #selector(textFieldTapGusture(gues:)))
        phoneRightView.addGestureRecognizer(tapG1)
        codeTextRightView.addGestureRecognizer(tapG2)
        
        
        let separateLine1 = UIView()
        separateLine1.backgroundColor = Color_separateLine
        let separateLine2 = UIView()
        separateLine2.backgroundColor = Color_separateLine
        let loginBtn = UIButton(type: UIButton.ButtonType.custom)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setBackgroundImage(#imageLiteral(resourceName: "wl_login_square"), for: .normal)
        loginBtn.addTarget(self, action: #selector(loginBtnAction(button:)), for: .touchUpInside)
        
        let bottomView = UIView()
        bottomView.backgroundColor = Color_default_background
        
        let findCodeBtn = setBottomBtn(title: "找回密码", tag: 1000)
        let registerBtn = setBottomBtn(title: "注册账号", tag: 2000)
        let separateLine3 = UIView()
        separateLine3.backgroundColor = Color_Base
        
        let separateLine4 = UIView()
        separateLine4.backgroundColor = Color_separateLine
        let otherLoginLabel = UILabel()
        otherLoginLabel.text = "第三方登录"
        otherLoginLabel.textColor = Color_Black
        otherLoginLabel.font = UIFont.systemFont(ofSize: 14)
        otherLoginLabel.sizeToFit()
        otherLoginLabel.backgroundColor = Color_default_background
        
        let otherImageView = UIImageView(image: #imageLiteral(resourceName: "wl_login_wx_chat"))
        otherImageView.contentMode = .center
        
        
        scrollView.addSubview(midView)
        midView.addSubview(midBackImageView)
        midView.addSubview(phoneTextField)
        midView.addSubview(separateLine1)
        midView.addSubview(codeTextField)
        midView.addSubview(separateLine2)
        midView.addSubview(loginBtn)
        
        scrollView.addSubview(bottomView)
        bottomView.addSubview(findCodeBtn)
        bottomView.addSubview(registerBtn)
        bottomView.addSubview(separateLine3)
        bottomView.addSubview(separateLine4)
        bottomView.addSubview(otherLoginLabel)
        bottomView.addSubview(otherImageView)
        
        midView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(scrollView)
            make.centerY.equalTo(backImageView.snp.bottom).offset(-10)
        }
        midBackImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(midView).offset(15)
            make.trailing.equalTo(midView).offset(-15)
            make.top.bottom.equalTo(midView)
        }
        phoneTextField.snp.makeConstraints { (make) in
            make.leading.equalTo(midBackImageView).offset(25)
            make.trailing.equalTo(midBackImageView).offset(-25)
            make.top.equalTo(midView)
            make.height.equalTo(60)
        }
        separateLine1.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(phoneTextField)
            make.height.equalTo(0.5)
            make.top.equalTo(phoneTextField.snp.bottom)
        }
        codeTextField.snp.makeConstraints { (make) in
            make.leading.equalTo(phoneTextField)
            make.trailing.equalTo(phoneTextField)
            make.top.equalTo(separateLine1.snp.bottom)
            make.height.equalTo(phoneTextField)
        }
        separateLine2.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(phoneTextField)
            make.height.equalTo(0.5)
            make.top.equalTo(codeTextField.snp.bottom)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(phoneTextField)
            make.top.equalTo(separateLine2.snp.bottom).offset(30)
            make.height.equalTo(40)
            make.bottom.equalTo(midView).offset(-30)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(scrollView)
            make.top.equalTo(midView.snp.bottom)
            make.bottom.equalTo(scrollView)
        }
        separateLine3.snp.makeConstraints { (make) in
            make.centerX.equalTo(bottomView)
            make.width.equalTo(0.5)
            make.top.equalTo(bottomView).offset(15)
            make.height.equalTo(12)
        }
        findCodeBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(separateLine3)
            make.trailing.equalTo(separateLine3.snp.leading).offset(-40)
        }
        registerBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(separateLine3)
            make.leading.equalTo(separateLine3.snp.trailing).offset(40)
        }
        separateLine4.snp.makeConstraints { (make) in
            make.leading.equalTo(bottomView).offset(30)
            make.trailing.equalTo(bottomView).offset(-30)
            make.top.equalTo(findCodeBtn.snp.bottom).offset(50)
            make.height.equalTo(0.5)
        }
        otherLoginLabel.snp.makeConstraints { (make) in
            make.center.equalTo(separateLine4)
        }
        otherImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(separateLine4)
            make.top.equalTo(separateLine4.snp.bottom).offset(30)
            make.bottom.equalTo(bottomView).offset(-50)
        } 
        
        scrollView.contentSize = CGSize(width: 0, height: bottomView.frame.maxY)
        
    }
    
    func setTextFieldView(imageName: String, codeRightView: Bool) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 60))
        let imageView = UIImageView(image: UIImage(named: imageName))
        if codeRightView {
            codeRightImageView = imageView
        }
        view.addSubview(imageView)
        imageView.frame = view.bounds
        imageView.contentMode = .center
        return view
    }
    
    func setBottomBtn(title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(Color_Base, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tag = tag
        return button
    }
    @objc func loginBtnAction(button: UIButton) {
        if phoneTextField?.text?.count == 0 {
            MBProgressHUD.showInWindow(message: "请输入手机号码")
            return
        }
        
        if !phoneTextField!.text!.isMobile() {
            MBProgressHUD.showInWindow(message: "请输入正确的手机号码")
            return
        }
        if codeTextField?.text?.count == 0 {
            MBProgressHUD.showInWindow(message: "请输入密码")
            return
        }
        if !codeTextField!.text!.isPassword() {
            MBProgressHUD.showInWindow(message: "请输入大于等于6位小于18位的密码")
            return
        }
        
    }

    @objc func wl_dismissKeyBoard(gues: UITapGestureRecognizer) {
        self.scrollView.endEditing(true)
    }
    @objc func textFieldTapGusture(gues: UITapGestureRecognizer){
        let view = gues.view
        if view?.tag == 100 {
            phoneTextField?.text = ""
        }else if view?.tag == 200 {
            codeRightImageView?.image = #imageLiteral(resourceName: "wl_login_passwd_visible")
            codeTextField?.isSecureTextEntry = false
            view?.tag = 300 
        }else if view?.tag == 300 {
            codeRightImageView?.image = #imageLiteral(resourceName: "wl_login_passwd_invisible")
            view?.tag = 200
            codeTextField?.isSecureTextEntry = true
        }
    }
}


