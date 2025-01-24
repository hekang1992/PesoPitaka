//
//  OneCommonView.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/24.
//

import UIKit

class OneCommonView: BaseView {

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UIUtils.createLabel(font: .regularFontOfSize(size: 14), textColor: .init(colorHexStr: "#717171")!, textAlignment: .left)
        return descLabel
    }()
    
    lazy var nameTx: UITextField = {
        let nameTx = UITextField()
        nameTx.textAlignment = .right
        let attrString = NSMutableAttributedString(string: "Input Your Information", attributes: [
            .foregroundColor: UIColor.init(colorHexStr: "#717171") as Any,
            .font: UIFont.regularFontOfSize(size: 15)
        ])
        nameTx.attributedPlaceholder = attrString
        nameTx.font = .regularFontOfSize(size: 15)
        nameTx.textColor = .black
        return nameTx
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(descLabel)
        bgView.addSubview(nameTx)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        descLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(20)
            make.width.equalTo(88)
        }
        nameTx.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(20)
            make.left.equalTo(descLabel.snp.right).offset(30)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
