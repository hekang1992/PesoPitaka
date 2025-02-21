//
//  HiveMustViewCellCollectionViewCell.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/26.
//

import UIKit
import RxSwift

class HiveMustViewCellCollectionViewCell: UICollectionViewCell {
    
    let disposeBag = DisposeBag()
    
    lazy var mustImgaView: UIImageView = {
        let mustImgaView = UIImageView()
        return mustImgaView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mustImgaView)
        mustImgaView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class HiveMiniViewCellCollectionViewCell: UICollectionViewCell {
    
    let disposeBag = DisposeBag()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .init(colorHexStr: "#F7FFFC")
        bgView.layer.cornerRadius = 12
        bgView.layer.shadowColor = UIColor.gray.cgColor
        bgView.layer.shadowOpacity = 0.5
        bgView.layer.shadowOffset = CGSize(width: 1, height: 1)
        bgView.layer.shadowRadius = 4
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "notiimgecheacki")
        return logoImageView
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.textColor = .black
        mlabel.textAlignment = .left
        mlabel.numberOfLines = 2
        mlabel.font = .regularFontOfSize(size: 14)
        return mlabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(mlabel)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.height.equalTo(56)
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(7)
            make.size.equalTo(CGSize(width: 54, height: 46))
        }
        mlabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(56)
            make.left.equalTo(logoImageView.snp.right).offset(12)
            make.right.equalToSuperview().offset(-40)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
