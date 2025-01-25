//
//  AlertAuthIDViewCell.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/24.
//

import UIKit

class AlertAuthIDViewCell: BaseViewCell {

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 10
        return bgView
    }()
    
    lazy var mustImageView: UIImageView = {
        let mustImageView = UIImageView()
        mustImageView.image = UIImage(named: "naitonicmieg")
        mustImageView.contentMode = .scaleAspectFit
        return mustImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 15), textColor: UIColor.init(colorHexStr: "#000000")!, textAlignment: .left)
        return nameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(mustImageView)
        contentView.addSubview(nameLabel)
        
        mustImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(27)
            make.size.equalTo(CGSize(width: 28, height: 17))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(mustImageView.snp.centerY)
            make.left.equalTo(mustImageView.snp.right).offset(17)
            make.height.equalTo(15)
            make.bottom.equalToSuperview().offset(-31)
        }
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(13)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
