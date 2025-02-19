//
//  AlertSuccessNameView.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/24.
//

import UIKit

class AlertSuccessNameView: BaseView {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "poseimage")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var oneView: OneCommonView = {
        let oneView = OneCommonView()
        oneView.descLabel.text = "Name"
        return oneView
    }()
    
    lazy var twoView: OneCommonView = {
        let twoView = OneCommonView()
        twoView.descLabel.text = "ID number"
        return twoView
    }()
    
    lazy var threeView: TwoCommonView = {
        let threeView = TwoCommonView()
        threeView.descLabel.text = "Date"
        return threeView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.backgroundColor = UIColor.init(colorHexStr: "#6DDEE2")
        nextBtn.setTitle("Confirm", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = .regularFontOfSize(size: 19)
        nextBtn.layer.cornerRadius = 30
        return nextBtn
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "camcebtimage"), for: .normal)
        return cancelBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 19), textColor: .init(colorHexStr: "#FFFFFF")!, textAlignment: .center)
        nameLabel.text = "Confirm Information"
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cancelBtn)
        addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(oneView)
        bgImageView.addSubview(twoView)
        bgImageView.addSubview(threeView)
        bgImageView.addSubview(nextBtn)
        bgImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375, height: 574))
        }
        cancelBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(bgImageView.snp.top)
        }
        oneView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(80)
            make.height.equalTo(50)
        }
        
        twoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(oneView.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        
        threeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(twoView.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        nextBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.top.equalTo(threeView.snp.bottom).offset(220)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(9)
            make.height.equalTo(23)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
