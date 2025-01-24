//
//  TwoAuthViewCell.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/24.
//

import UIKit

class TwoAuthViewCell: BaseViewCell {

    lazy var twoView: TwoCommonView = {
        let twoView = TwoCommonView()
        return twoView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(twoView)
        twoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
