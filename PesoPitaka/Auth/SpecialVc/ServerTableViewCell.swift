//
//  ServerTableViewCell.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/25.
//

import UIKit

class ServerTableViewCell: BaseViewCell {
    
    var oneBlock: (() -> Void)?
    var twoBlock: (() -> Void)?
    
    lazy var miLabel: UILabel = {
        let miLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 14), textColor: .init(colorHexStr: "#C9C9C9")!, textAlignment: .left)
         return miLabel
    }()

    lazy var obgView: UIView = {
        let obgView = UIView()
        obgView.backgroundColor = .white
        obgView.layer.cornerRadius = 5
        return obgView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 14), textColor: .init(colorHexStr: "#717171")!, textAlignment: .left)
        descLabel.text = "Choose Your Relationship"
        return descLabel
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "righiconafd")
        return rightImageView
    }()
    
    lazy var owbgView: UIView = {
        let owbgView = UIView()
        owbgView.backgroundColor = .white
        owbgView.layer.cornerRadius = 5
        return owbgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 14), textColor: .init(colorHexStr: "#717171")!, textAlignment: .left)
        nameLabel.text = "Contact Information"
        return nameLabel
    }()
    
    lazy var righteImageView: UIImageView = {
        let righteImageView = UIImageView()
        righteImageView.image = UIImage(named: "contactsimagepnf")
        return righteImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(miLabel)
        contentView.addSubview(obgView)
        obgView.addSubview(descLabel)
        obgView.addSubview(rightImageView)
       
        contentView.addSubview(owbgView)
        owbgView.addSubview(nameLabel)
        owbgView.addSubview(righteImageView)
        
        miLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(18)
        }
        obgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(miLabel.snp.bottom).offset(15)
        }
        descLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        owbgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(obgView.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
        righteImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        obgView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.oneBlock?()
        }).disposed(by: disposeBag)
        
        owbgView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.twoBlock?()
        }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
