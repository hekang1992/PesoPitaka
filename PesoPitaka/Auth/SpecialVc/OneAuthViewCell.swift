//
//  OneAuthViewCell.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/24.
//

import UIKit

class OneAuthViewCell: BaseViewCell {

    lazy var oneView: OneCommonView = {
        let oneView = OneCommonView()
        return oneView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(oneView)
        oneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
