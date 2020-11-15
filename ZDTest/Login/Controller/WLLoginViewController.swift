//
//  WLLoginViewController.swift
//  ZDTest
//
//  Created by kede Han on 2020/11/12.
//

import UIKit
import SnapKit
//import Alamofire

class WLLoginViewController: WLBaseViewController {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Color_MinBlack
        return scrollView
    }()
    var phoneTextField: UITextField? = nil
    var codeTextField: UITextField? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        let tapG = UITapGestureRecognizer(target: self, action: #selector(wl_dismissKeyBoard(gues:)))
        scrollView.addGestureRecognizer(tapG)
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
        midView.backgroundColor = Color_White
        let midBackImageView = UIImageView(image: #imageLiteral(resourceName: "wl_login_whiteBack"))
        let phoneTextField = UITextField()
        phoneTextField.placeholder = "请输入手机号"
        
        let phoneLeftView = setTextFieldView(imageName: "wl_login_userPhone_log")
        phoneTextField.leftView = phoneLeftView
        phoneTextField.leftViewMode = .always
        
        let phoneRightView = setTextFieldView(imageName: "wl_login_userPhone_delete")
        phoneRightView.tag = 100
        phoneTextField.rightView = phoneRightView
        phoneTextField.rightViewMode = .whileEditing
        self.phoneTextField = phoneTextField
        
        
        let codeTextField = UITextField()
        codeTextField.placeholder = "请输入大于等于6位的密码"
        codeTextField.isSecureTextEntry = true
        self.codeTextField = codeTextField
        
        let codeTextLeftView = setTextFieldView(imageName: "wl_login_passwd_log")
        codeTextField.leftView = codeTextLeftView
        codeTextField.leftViewMode = .always
        
        let codeTextRightView = setTextFieldView(imageName: "wl_login_passwd_visible")
        codeTextField.rightView = codeTextRightView
        codeTextField.rightViewMode = .always
        codeTextRightView.tag = 200
        let tapG = UITapGestureRecognizer(target: self, action: #selector(textFieldTapGusture(gues:)))
        phoneRightView.addGestureRecognizer(tapG)
        codeTextRightView.addGestureRecognizer(tapG)
        
        
        let separateLine1 = UIView()
        separateLine1.backgroundColor = Color_separateLine
        let separateLine2 = UIView()
        separateLine2.backgroundColor = Color_separateLine
        let loginBtn = UIButton(type: UIButton.ButtonType.custom)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setImage(#imageLiteral(resourceName: "wl_login_square"), for: .normal)
        loginBtn.addTarget(self, action: #selector(loginBtnAction(button:)), for: .touchUpInside)
        
        scrollView.addSubview(midView)
        midView.addSubview(midBackImageView)
        midView.addSubview(phoneTextField)
        midView.addSubview(separateLine1)
        midView.addSubview(codeTextField)
        midView.addSubview(separateLine2)
        midView.addSubview(loginBtn)
        
        midView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(scrollView)
            make.centerY.equalTo(backImageView.snp.bottom).offset(50)
        }
        midBackImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(midView).offset(15)
            make.trailing.equalTo(midView).offset(-15)
            make.top.bottom.equalTo(midView)
        }
        phoneTextField.snp.makeConstraints { (make) in
            make.leading.equalTo(midBackImageView).offset(15)
            make.trailing.equalTo(midBackImageView).offset(-15)
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
    }
    
    func setTextFieldView(imageName: String) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 60))
        let imageView = UIImageView(image: UIImage(named: imageName))
        view.addSubview(imageView)
        imageView.frame = view.bounds
        imageView.contentMode = .center
        return view
    }
    @objc func loginBtnAction(button: UIButton) {
        
    }

    @objc func wl_dismissKeyBoard(gues: UITapGestureRecognizer) {
        self.scrollView.endEditing(true)
    }
    @objc func textFieldTapGusture(gues: UITapGestureRecognizer){
        let view = gues.view
        if view?.tag == 100 {
            phoneTextField?.text = ""
        }else if view?.tag == 200 {
            let rightView = setTextFieldView(imageName: "wl_login_passwd_invisible@")
            rightView.tag = 300
            codeTextField?.rightView = rightView
            codeTextField?.rightViewMode = .always
            
        }else if view?.tag == 300 {
            let rightView = setTextFieldView(imageName: "wl_login_passwd_visible@")
            rightView.tag = 200
            codeTextField?.rightView = rightView
            codeTextField?.rightViewMode = .always
        }
    }
}
