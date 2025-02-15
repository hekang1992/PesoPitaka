//
//  TwoCommonView.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/24.
//

import UIKit

class TwoCommonView: BaseView {

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 14), textColor: .init(colorHexStr: "#717171")!, textAlignment: .left)
        return descLabel
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 14), textColor: .init(colorHexStr: "#717171")!, textAlignment: .right)
        return nameLabel
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "righiconafd")
        return rightImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(descLabel)
        bgView.addSubview(nameLabel)
        bgView.addSubview(rightImageView)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        descLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(20)
            make.width.equalTo(88)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(20)
            make.left.equalTo(descLabel.snp.right).offset(30)
        }
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 15, height: 15))
            make.right.equalToSuperview().offset(-5)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
