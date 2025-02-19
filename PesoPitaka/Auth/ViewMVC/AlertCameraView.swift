//
//  AlertCameraView.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/24.
//

import UIKit

class AlertCameraView: BaseView {
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "camcebtimage"), for: .normal)
        return cancelBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 19), textColor: .init(colorHexStr: "#FFFFFF")!, textAlignment: .center)
        nameLabel.text = "Upload ID Photo"
        return nameLabel
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "poseimage")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var leftBtn: UIButton = {
        let leftBtn = UIButton(type: .custom)
        leftBtn.backgroundColor = UIColor.init(colorHexStr: "#6DDEE2")
        leftBtn.setTitle("Album", for: .normal)
        leftBtn.setTitleColor(.white, for: .normal)
        leftBtn.titleLabel?.font = .regularFontOfSize(size: 19)
        leftBtn.layer.cornerRadius = 30
        return leftBtn
    }()
    
    lazy var rightBtn: UIButton = {
        let rightBtn = UIButton(type: .custom)
        rightBtn.backgroundColor = UIColor.init(colorHexStr: "#6DDEE2")
        rightBtn.setTitle("Camera", for: .normal)
        rightBtn.setTitleColor(.white, for: .normal)
        rightBtn.titleLabel?.font = .regularFontOfSize(size: 19)
        rightBtn.layer.cornerRadius = 30
        return rightBtn
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        return iconImageView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 14), textColor: .init(colorHexStr: "#000000")!, textAlignment: .center)
        descLabel.numberOfLines = 0
        descLabel.text = "Please upload a clear ID photo for loan review. Let's speed things up!"
        descLabel.layer.cornerRadius = 10
        descLabel.backgroundColor = .white
        return descLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cancelBtn)
        addSubview(bgImageView)
        bgImageView.addSubview(iconImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(descLabel)
        bgImageView.addSubview(leftBtn)
        bgImageView.addSubview(rightBtn)
        bgImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH, height: 574))
        }
        cancelBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(bgImageView.snp.top)
        }
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 256, height: 157))
            make.top.equalToSuperview().offset(80)
            
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(83)
            make.top.equalTo(iconImageView.snp.bottom).offset(43)
        }
        leftBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(162)
            make.height.equalTo(60)
            make.top.equalTo(descLabel.snp.bottom).offset(69)
        }
        rightBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(162)
            make.height.equalTo(60)
            make.top.equalTo(descLabel.snp.bottom).offset(69)
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

class FaceAlertInfo: BaseView {
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "camcebtimage"), for: .normal)
        return cancelBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 19), textColor: .init(colorHexStr: "#FFFFFF")!, textAlignment: .center)
        nameLabel.text = "Face Recognition"
        return nameLabel
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "poseimage")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var goBtn: UIButton = {
        let goBtn = UIButton(type: .custom)
        goBtn.backgroundColor = UIColor.init(colorHexStr: "#6DDEE2")
        goBtn.setTitle("Go", for: .normal)
        goBtn.setTitleColor(.white, for: .normal)
        goBtn.titleLabel?.font = .regularFontOfSize(size: 20)
        goBtn.layer.cornerRadius = 30
        return goBtn
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "faceiamgetoto")
        return iconImageView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 14), textColor: .init(colorHexStr: "#000000")!, textAlignment: .center)
        descLabel.numberOfLines = 0
        descLabel.text = "Please look straight at the camera for facial recognition. Keep still and ensure good lighting to complete verification swiftly."
        descLabel.layer.cornerRadius = 10
        descLabel.backgroundColor = .white
        return descLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cancelBtn)
        addSubview(bgImageView)
        bgImageView.addSubview(iconImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(descLabel)
        bgImageView.addSubview(goBtn)
        bgImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH, height: 574))
        }
        cancelBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(bgImageView.snp.top)
        }
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 256, height: 157))
            make.top.equalToSuperview().offset(80)
            
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(83)
            make.top.equalTo(iconImageView.snp.bottom).offset(43)
        }
        goBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(60)
            make.top.equalTo(descLabel.snp.bottom).offset(69)
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
