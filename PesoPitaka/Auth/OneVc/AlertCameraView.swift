//
//  AlertCameraView.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/24.
//

import UIKit

class AlertCameraView: BaseView {
    
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
        iconImageView.backgroundColor = .systemBlue
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
        addSubview(bgImageView)
        bgImageView.addSubview(iconImageView)
        bgImageView.addSubview(descLabel)
        bgImageView.addSubview(leftBtn)
        bgImageView.addSubview(rightBtn)
        bgImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375, height: 574))
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
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
