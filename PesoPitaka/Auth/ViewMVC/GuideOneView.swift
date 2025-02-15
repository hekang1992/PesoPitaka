//
//  GuideOneView.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/24.
//

import UIKit

class GuideOneView: BaseView {

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 10
        return bgView
    }()
    
    lazy var mustImageView: UIImageView = {
        let mustImageView = UIImageView()
        return mustImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 15), textColor: UIColor.init(colorHexStr: "#000000")!, textAlignment: .left)
        nameLabel.text = "Select authentication method"
        return nameLabel
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "righiconafd")
        return oneImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(mustImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(oneImageView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mustImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(18)
            make.size.equalTo(CGSize(width: 51, height: 31))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(mustImageView.snp.right).offset(17)
            make.height.equalTo(15)
        }
        oneImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
