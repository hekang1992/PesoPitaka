//
//  LoginView.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/21.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay
import RxCocoa

class LoginView: BaseView {
    
    var isClickPri: String = ""

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "loginbgimage")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var liImageView: UIImageView = {
        let liImageView = UIImageView()
        liImageView.image = UIImage(named: "littleiconimage")
        return liImageView
    }()
    
    
    lazy var loginImageView: UIImageView = {
        let loginImageView = UIImageView()
        loginImageView.image = UIImage(named: "loginbg")
        loginImageView.isUserInteractionEnabled = true
        return loginImageView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 13), textColor: UIColor.init(colorHexStr: "#C6C6C6")!, textAlignment: .left)
        phoneLabel.text = "Telephone Number"
        return phoneLabel
    }()
    
    lazy var onelineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .init(colorHexStr: "#B9BBD9")
        return lineView
    }()
    
    lazy var twolineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .init(colorHexStr: "#B9BBD9")
        return lineView
    }()
    
    lazy var numLabel: UILabel = {
        let numLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 16), textColor: UIColor.init(colorHexStr: "#000000")!, textAlignment: .center)
        numLabel.text = "+63"
        return numLabel
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Enter your valid phone number", attributes: [
            .foregroundColor: UIColor.init(colorHexStr: "#717171") as Any,
            .font: UIFont.regularFontOfSize(size: 14)
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = .regularFontOfSize(size: 15)
        phoneTx.textColor = UIColor.init(colorHexStr: "#000000")
        return phoneTx
    }()
    
    lazy var codeLabel: UILabel = {
        let phoneLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 13), textColor: UIColor.init(colorHexStr: "#C6C6C6")!, textAlignment: .left)
        phoneLabel.text = "Verification Code"
        return phoneLabel
    }()
    
    lazy var codeTx: UITextField = {
        let codeTx = UITextField()
        codeTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Enter your code", attributes: [
            .foregroundColor: UIColor.init(colorHexStr: "#717171") as Any,
            .font: UIFont.regularFontOfSize(size: 14)
        ])
        codeTx.attributedPlaceholder = attrString
        codeTx.font = .regularFontOfSize(size: 15)
        codeTx.textColor = UIColor.init(colorHexStr: "#000000")
        return codeTx
    }()
    
    lazy var sendBtn: UIButton = {
        let sendBtn = UIButton(type: .custom)
        sendBtn.backgroundColor = UIColor.init(colorHexStr: "#272727")
        sendBtn.setTitle("Send Code", for: .normal)
        sendBtn.titleLabel?.font = .regularFontOfSize(size: 13)
        sendBtn.layer.cornerRadius = 18
        sendBtn.backgroundColor = .init(colorHexStr: "#6DDEE2")
        sendBtn.setTitleColor(.black, for: .normal)
        return sendBtn
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.backgroundColor = UIColor.init(colorHexStr: "#272727")
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.titleLabel?.font = .regularFontOfSize(size: 20)
        loginBtn.layer.cornerRadius = 18
        loginBtn.backgroundColor = .init(colorHexStr: "#6DDEE2")
        loginBtn.setTitleColor(.black, for: .normal)
        return loginBtn
    }()
    
    lazy var xBtn: UIButton = {
        let xBtn = UIButton(type: .custom)
        xBtn.setImage(UIImage(named: "Loggeimagepri."), for: .normal)
        return xBtn
    }()
    
    lazy var cyBtn: UIButton = {
        let cyBtn = UIButton(type: .custom)
        cyBtn.setImage(UIImage(named: "clicknor"), for: .selected)
        cyBtn.setImage(UIImage(named: "clicksel"), for: .normal)
        return cyBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(liImageView)
        bgImageView.addSubview(loginImageView)
        loginImageView.addSubview(phoneLabel)
        loginImageView.addSubview(numLabel)
        
        loginImageView.addSubview(phoneTx)
        
        loginImageView.addSubview(onelineView)
        
        loginImageView.addSubview(codeLabel)
        loginImageView.addSubview(codeTx)
        
        loginImageView.addSubview(twolineView)
        
        loginImageView.addSubview(sendBtn)
        
        bgImageView.addSubview(loginBtn)
        bgImageView.addSubview(xBtn)
        bgImageView.addSubview(cyBtn)
        
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        liImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(37)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(CGSize(width: 263, height: 88))
        }
        loginImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(liImageView.snp.bottom).offset(90)
            make.size.equalTo(CGSize(width: 351, height: 373))
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(38)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(15.6)
        }
        
        codeLabel.snp.makeConstraints { make in
            make.top.equalTo(onelineView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(15.6)
        }
        
        numLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(19)
            make.left.equalTo(phoneLabel.snp.left)
            make.height.equalTo(20)
        }
        phoneTx.snp.makeConstraints { make in
            make.centerY.equalTo(numLabel.snp.centerY)
            make.height.equalTo(18)
            make.left.equalTo(numLabel.snp.right).offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        codeTx.snp.makeConstraints { make in
            make.top.equalTo(codeLabel.snp.bottom).offset(20)
            make.height.equalTo(18)
            make.left.equalTo(codeLabel.snp.left)
            make.right.equalToSuperview().offset(-140)
        }
        
        
        sendBtn.snp.makeConstraints { make in
            make.centerY.equalTo(codeTx.snp.centerY)
            make.right.equalToSuperview().offset(-30)
            make.size.equalTo(CGSize(width: 97, height: 37))
        }
        
        onelineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(numLabel.snp.bottom).offset(12)
            make.height.equalTo(0.5)
        }
        
        twolineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(sendBtn.snp.bottom).offset(12)
            make.height.equalTo(0.5)
        }
        
        
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(48)
            make.top.equalTo(loginImageView.snp.bottom).offset(50)
        }
        
        xBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 305, height: 38))
        }
        cyBtn.snp.makeConstraints { make in
            make.top.equalTo(xBtn.snp.top)
            make.right.equalTo(xBtn.snp.left).offset(-5)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        clickInfo()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension LoginView {
    
    private func clickInfo() {
        
        cyBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            cyBtn.isSelected.toggle()
            isClickPri = cyBtn.isSelected ? "0" : "1"
        }).disposed(by: disposing)
        
        
    }
    
}
