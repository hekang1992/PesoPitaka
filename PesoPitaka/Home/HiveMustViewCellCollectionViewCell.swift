//
//  HiveMustViewCellCollectionViewCell.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/26.
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
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.textColor = .black
        mlabel.textAlignment = .left
        mlabel.numberOfLines = 2
        mlabel.font = .regularFontOfSize(size: 12)
        return mlabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mlabel)
        mlabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(56)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-104)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
