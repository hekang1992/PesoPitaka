//
//  HeadView.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/22.
//

import UIKit

class HeadView: BaseView {

    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "backiconimage"), for: .normal)
        return backBtn
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UIUtils.createLabel(font: .regularFontOfSize(size: 18), textColor: .black, textAlignment: .center)
        return namelabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backBtn)
        addSubview(namelabel)
        
        backBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        namelabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backBtn.snp.centerY)
            make.height.equalTo(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
