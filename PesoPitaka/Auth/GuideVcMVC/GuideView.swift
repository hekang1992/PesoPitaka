//
//  GuideView.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/23.
//

import UIKit

class GuideView: BaseView {

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "loginbgimage")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var guideImageView: UIImageView = {
        let guideImageView = UIImageView()
        guideImageView.image = UIImage(named: "auhtguideimge")
        return guideImageView
    }()
    
    lazy var oneView: GuideListView = {
        let oneView = GuideListView()
        oneView.nameLabel.text = "Identity\nVerification"
        return oneView
    }()
    
    lazy var twoView: GuideListView = {
        let twoView = GuideListView()
        twoView.nameLabel.text = "Identity\nInformation"
        return twoView
    }()
    
    lazy var threeView: GuideListView = {
        let threeView = GuideListView()
        threeView.nameLabel.text = "Work\nInformation"
        return threeView
    }()
    
    lazy var fourView: GuideListView = {
        let fourView = GuideListView()
        fourView.nameLabel.text = "Emergency\nInformation"
        return fourView
    }()
    
    lazy var fiveView: GuideListView = {
        let fiveView = GuideListView()
        fiveView.nameLabel.text = "Bank\nInformation"
        return fiveView
    }()
    
    lazy var opImageView: UIImageView = {
        let opImageView = UIImageView()
        opImageView.image = UIImage(named: "priimagdemo.")
        return opImageView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.backgroundColor = UIColor.init(colorHexStr: "#6DDEE2")
        nextBtn.setTitle("Next", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = .regularFontOfSize(size: 19)
        nextBtn.layer.cornerRadius = 30
        return nextBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(scrollView)
        scrollView.addSubview(guideImageView)
        guideImageView.addSubview(oneView)
        guideImageView.addSubview(twoView)
        guideImageView.addSubview(threeView)
        guideImageView.addSubview(fourView)
        guideImageView.addSubview(fiveView)
        scrollView.addSubview(opImageView)
        scrollView.addSubview(nextBtn)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        guideImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(DeviceMetrics.navigationBarHeight)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375, height: 579))
        }
        oneView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(26)
            make.height.equalTo(36.5)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(230)
        }
        twoView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(26)
            make.height.equalTo(36.5)
            make.centerX.equalToSuperview()
            make.top.equalTo(oneView.snp.bottom).offset(34)
        }
        threeView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(26)
            make.height.equalTo(36.5)
            make.centerX.equalToSuperview()
            make.top.equalTo(twoView.snp.bottom).offset(34)
        }
        fourView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(26)
            make.height.equalTo(36.5)
            make.centerX.equalToSuperview()
            make.top.equalTo(threeView.snp.bottom).offset(34)
        }
        fiveView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(26)
            make.height.equalTo(36.5)
            make.centerX.equalToSuperview()
            make.top.equalTo(fourView.snp.bottom).offset(34)
        }
        opImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(guideImageView.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 337, height: 30.5))
        }
        nextBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.top.equalTo(opImageView.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
