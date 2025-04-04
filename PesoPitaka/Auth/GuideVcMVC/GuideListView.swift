//
//  GuideListView.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/23.
//

import UIKit

class GuideListView: BaseView {

    lazy var nameLabel: UILabel = {
        let nameLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 14), textColor: UIColor.init(colorHexStr: "#000000")!, textAlignment: .left)
        nameLabel.numberOfLines = 0
        nameLabel.isUserInteractionEnabled = true
        return nameLabel
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "processigme")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(bgImageView)
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(112)
        }
        bgImageView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 190, height: 17))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
