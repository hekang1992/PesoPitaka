//
//  AlertImageView.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/23.
//

import UIKit

class AlertImageView: BaseView {

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
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
        threeBtn.isHidden = true
        threeBtn.setImage(UIImage(named: "clicknor"), for: .normal)
        threeBtn.setImage(UIImage(named: "clicksel"), for: .selected)
        return threeBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(oneBtn)
        bgImageView.addSubview(twoBtn)
        bgImageView.addSubview(threeBtn)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 351, height: 403))
        }
        oneBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 132, height: 45))
            make.left.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-42)
        }
        twoBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 132, height: 45))
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-42)
        }
        threeBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(23)
            make.bottom.equalToSuperview().offset(-94)
            make.size.equalTo(CGSize(width: 11, height: 11))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
