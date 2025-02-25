//
//  CenterView.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/22.
//

import UIKit
import RxSwift

class CenterView: BaseView {
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.namelabel.text = "My"
        headView.backBtn.isHidden = true
        return headView
    }()

    lazy var mustImageView: UIImageView = {
        let mustImageView = UIImageView()
        mustImageView.image = UIImage(named: "centerimgebg")
        mustImageView.isUserInteractionEnabled = true
        return mustImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "centericon")
        return iconImageView
    }()
    
    lazy var phonelabel: UILabel = {
        let phonelabel = UILabel()
        phonelabel.textColor = UIColor.init(colorHexStr: "#000000")
        phonelabel.textAlignment = .left
        phonelabel.font = .regularFontOfSize(size: 20)
        let phone = UserDefaultsManager.getValue(forKey: .loginPhone) as? String ?? ""
        let phoneStr = hideMiddleDigits(of: phone)
        phonelabel.text = "Hi~ \(phoneStr)"
        return phonelabel
    }()
    
    lazy var desclabel: UILabel = {
        let desclabel = UIUtils.createLabel(font: .regularFontOfSize(size: 12), textColor: UIColor.init(colorHexStr: "#717171")!, textAlignment: .left)
        desclabel.text = "Welcome to Peso Pitaka"
        return desclabel
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "centeiamgeon")
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "ceimgetwoiamg")
        twoImageView.isUserInteractionEnabled = true
        return twoImageView
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "thfceniamge")
        threeImageView.isUserInteractionEnabled = true
        return threeImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        return threeBtn
    }()
    
    
    lazy var fourBtn: UIButton = {
        let fourBtn = UIButton(type: .custom)
        return fourBtn
    }()
    
    lazy var aboutBtn: UIButton = {
        let aboutBtn = UIButton(type: .custom)
        return aboutBtn
    }()
    
    lazy var connectBtn: UIButton = {
        let connectBtn = UIButton(type: .custom)
        return connectBtn
    }()
    
    lazy var termsBtn: UIButton = {
        let termsBtn = UIButton(type: .custom)
        return termsBtn
    }()
    
    lazy var settingBtn: UIButton = {
        let settingBtn = UIButton(type: .custom)
        return settingBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mustImageView)
        mustImageView.addSubview(headView)
        mustImageView.addSubview(scrollView)
        scrollView.addSubview(iconImageView)
        scrollView.addSubview(phonelabel)
        scrollView.addSubview(desclabel)
        scrollView.addSubview(oneImageView)
        scrollView.addSubview(twoImageView)
        scrollView.addSubview(threeImageView)
        
        twoImageView.addSubview(oneBtn)
        twoImageView.addSubview(twoBtn)
        twoImageView.addSubview(threeBtn)
        twoImageView.addSubview(fourBtn)
        
        threeImageView.addSubview(aboutBtn)
        threeImageView.addSubview(connectBtn)
        threeImageView.addSubview(termsBtn)
        threeImageView.addSubview(settingBtn)
        
        mustImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH, height: 30))
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 52, height: 52))
            make.left.equalToSuperview().offset(30)
        }
        phonelabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.top).offset(4)
            make.left.equalTo(iconImageView.snp.right).offset(11)
            make.height.equalTo(20)
        }
        desclabel.snp.makeConstraints { make in
            make.left.equalTo(phonelabel.snp.left)
            make.top.equalTo(phonelabel.snp.bottom).offset(8)
            make.height.equalTo(15)
        }
        oneImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 375, height: 38.5))
            make.top.equalTo(desclabel.snp.bottom).offset(81)
        }
        twoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 351, height: 135))
            make.top.equalTo(oneImageView.snp.bottom).offset(10)
        }
        threeImageView.snp.makeConstraints { make in
            make.centerX.equalTo(twoImageView.snp.centerX)
            make.size.equalTo(CGSize(width: 351, height: 148))
            make.top.equalTo(twoImageView.snp.bottom).offset(28)
            make.bottom.equalToSuperview().offset(-DeviceMetrics.tabBarHeight)
        }
        
        oneBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(88)
        }
        twoBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(oneBtn.snp.right)
            make.top.equalToSuperview()
            make.width.equalTo(88)
        }
        threeBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(twoBtn.snp.right)
            make.top.equalToSuperview()
            make.width.equalTo(88)
        }
        fourBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(threeBtn.snp.right)
            make.top.equalToSuperview()
            make.width.equalTo(88)
        }
        
        
        aboutBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(88)
        }
        connectBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(aboutBtn.snp.right)
            make.top.equalToSuperview()
            make.width.equalTo(88)
        }
        termsBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(connectBtn.snp.right)
            make.top.equalToSuperview()
            make.width.equalTo(88)
        }
        settingBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(termsBtn.snp.right)
            make.top.equalToSuperview()
            make.width.equalTo(88)
        }
        
        
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

extension CenterView {
    
    func hideMiddleDigits(of phoneNumber: String) -> String {
        guard phoneNumber.count >= 8 else {
            return phoneNumber
        }
        var phoneNumberArray = Array(phoneNumber)
        for i in (phoneNumberArray.count / 2 - 2)..<(phoneNumberArray.count / 2 + 2) {
            phoneNumberArray[i] = "*"
        }
        return String(phoneNumberArray)
    }
    
}
