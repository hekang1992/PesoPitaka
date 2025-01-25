//
//  GuidePhotoView.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/24.
//

import UIKit

class GuidePhotoView: BaseView {

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
        let nameLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 15), textColor: UIColor.init(colorHexStr: "#000000")!, textAlignment: .center)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    lazy var placeImageView: UIImageView = {
        let placeImageView = UIImageView()
        placeImageView.isHidden = true
        return placeImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(mustImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(placeImageView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mustImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(22)
            make.size.equalTo(CGSize(width: 27, height: 27))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mustImageView.snp.bottom).offset(20)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        placeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
