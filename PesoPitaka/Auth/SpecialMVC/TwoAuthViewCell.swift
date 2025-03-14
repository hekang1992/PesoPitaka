//
//  TwoAuthViewCell.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/24.
//

import UIKit

class TwoAuthViewCell: BaseViewCell {
    
    var cellBloclk: (() -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 5
        return bgView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 14), textColor: .init(colorHexStr: "#717171")!, textAlignment: .left)
        return descLabel
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "righiconafd")
        return rightImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(descLabel)
        contentView.addSubview(rightImageView)
        
        descLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-15)
        }
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalTo(descLabel.snp.centerY)
            make.size.equalTo(CGSize(width: 15, height: 15))
            make.right.equalToSuperview().offset(-25)
        }
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(50)
        }
//        bgView.rx.tapGesture().subscribe(onNext: { [weak self] _ in
//            self?.cellBloclk?()
//        }).disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
