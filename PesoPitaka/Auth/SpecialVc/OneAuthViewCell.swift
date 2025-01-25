//
//  OneAuthViewCell.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/24.
//

import UIKit

class OneAuthViewCell: BaseViewCell {

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 5
        return bgView
    }()
    
    lazy var nameTx: UITextField = {
        let nameTx = UITextField()
        nameTx.font = .regularFontOfSize(size: 15)
        nameTx.textColor = .black
        return nameTx
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(nameTx)
        
        nameTx.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
