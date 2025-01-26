//
//  HivePeoViewCell.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/26.
//

import UIKit
import RxRelay

class HivePeoViewCell: BaseViewCell {
    
    var model = BehaviorRelay<ownModel?>(value: nil)
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "proceimgebg")
        return bgImageView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.layer.cornerRadius = 13.5
        iconImageView.layer.masksToBounds = true
        return iconImageView
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UIUtils.createLabel(font: .regularFontOfSize(size: 13), textColor: .init(colorHexStr: "#717171")!, textAlignment: .left)
        return namelabel
    }()
    
    lazy var moneylabel: UILabel = {
        let moneylabel = UIUtils.createLabel(font: .regularFontOfSize(size: 24), textColor: .init(colorHexStr: "#000000")!, textAlignment: .left)
        return moneylabel
    }()
    
    lazy var desclabel: UILabel = {
        let desclabel = UIUtils.createLabel(font: .regularFontOfSize(size: 12), textColor: .init(colorHexStr: "#AEDBDB")!, textAlignment: .left)
        return desclabel
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.backgroundColor = .init(colorHexStr: "#6DDEE2")
        applyBtn.setTitle("Apply", for: .normal)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.titleLabel?.font = .regularFontOfSize(size: 15)
        applyBtn.layer.cornerRadius = 10
        applyBtn.layer.shadowColor = UIColor.init(colorHexStr: "#82F3F7")?.cgColor
        applyBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        applyBtn.layer.shadowRadius = 7.5
        applyBtn.layer.shadowOpacity = 0.5
        return applyBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(iconImageView)
        bgImageView.addSubview(namelabel)
        bgImageView.addSubview(moneylabel)
        bgImageView.addSubview(desclabel)
        bgImageView.addSubview(applyBtn)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 331, height: 125))
            make.bottom.equalToSuperview().offset(-15)
        }
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.size.equalTo(CGSize(width: 27, height: 27))
        }
        namelabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.height.equalTo(17)
        }
        moneylabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(45)
            make.height.equalTo(31)
            make.top.equalToSuperview().offset(58)
        }
        desclabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(45)
            make.height.equalTo(14.5)
            make.top.equalTo(moneylabel.snp.bottom).offset(1)
        }
        applyBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 92, height: 38))
        }
        
        model.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            iconImageView.kf.setImage(with: URL(string: model.blinked ?? ""))
            namelabel.text = model.getting ?? ""
            moneylabel.text = "₱\(model.amountMax ?? "")"
            applyBtn.setTitle(model.sound ?? "", for: .normal)
            desclabel.text = model.loanTermText ?? ""
        }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
