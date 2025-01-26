//
//  OtpPeoViewCell.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/26.
//

import UIKit
import RxRelay

class OtpPeoViewCell: BaseViewCell {
    
    var model = BehaviorRelay<instantlyModel?>(value: nil)

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .init(colorHexStr: "#FFFFFF")
        bgView.layer.cornerRadius = 10
        return bgView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.layer.cornerRadius = 5
        iconImageView.layer.masksToBounds = true
        return iconImageView
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UIUtils.createLabel(font: .regularFontOfSize(size: 13), textColor: .init(colorHexStr: "#717171")!, textAlignment: .left)
        return namelabel
    }()
    
    lazy var onelabel: UILabel = {
        let onelabel = UIUtils.createLabel(font: .regularFontOfSize(size: 15), textColor: .init(colorHexStr: "#000000")!, textAlignment: .left)
        return onelabel
    }()
    
    lazy var twolabel: UILabel = {
        let twolabel = UIUtils.createLabel(font: .regularFontOfSize(size: 12), textColor: .init(colorHexStr: "#C6C6C6")!, textAlignment: .left)
        return twolabel
    }()
    
    lazy var timelabel: UILabel = {
        let timelabel = UIUtils.createLabel(font: .regularFontOfSize(size: 15), textColor: .init(colorHexStr: "#000000")!, textAlignment: .left)
        return timelabel
    }()
    
    lazy var ttlabel: UILabel = {
        let ttlabel = UIUtils.createLabel(font: .regularFontOfSize(size: 12), textColor: .init(colorHexStr: "#C6C6C6")!, textAlignment: .left)
        return ttlabel
    }()
    
    lazy var blueView: UIView = {
        let blueView = UIView()
        blueView.backgroundColor = .init(colorHexStr: "#6DDEE2")?.withAlphaComponent(0.1)
        blueView.layer.cornerRadius = 5
        return blueView
    }()
    
    lazy var applyBtn: UILabel = {
        let applyBtn = UIUtils.createLabel(font: .regularFontOfSize(size: 14), textColor: .init(colorHexStr: "#FFFFFF")!, textAlignment: .center)
        applyBtn.backgroundColor = .init(colorHexStr: "#6DDEE2")
        applyBtn.layer.cornerRadius = 5
        applyBtn.layer.masksToBounds = true
        return applyBtn
    }()
    
    lazy var titlabel: UILabel = {
        let titlabel = UIUtils.createLabel(font: .regularFontOfSize(size: 11), textColor: .init(colorHexStr: "#717171")!, textAlignment: .left)
        titlabel.numberOfLines = 0
        return titlabel
    }()
    
    lazy var appBtn: UIButton = {
        let appBtn = UIButton(type: .custom)
        appBtn.setBackgroundImage(UIImage(named: "greenccongimage"), for: .normal)
        appBtn.setTitleColor(.init(colorHexStr: "#6D4400"), for: .normal)
        appBtn.titleLabel?.font = .regularFontOfSize(size: 12)
        return appBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(iconImageView)
        contentView.addSubview(namelabel)
        contentView.addSubview(onelabel)
        contentView.addSubview(twolabel)
        contentView.addSubview(timelabel)
        contentView.addSubview(ttlabel)
        contentView.addSubview(blueView)
        contentView.addSubview(applyBtn)
        contentView.addSubview(appBtn)
        blueView.addSubview(titlabel)
        
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(221)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        namelabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.height.equalTo(17.5)
            
        }
        
        onelabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(iconImageView.snp.bottom).offset(26)
            make.height.equalTo(16)
        }
        
        twolabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(onelabel.snp.bottom).offset(10)
            make.height.equalTo(15.5)
        }
        
        timelabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(147)
            make.top.equalTo(iconImageView.snp.bottom).offset(26)
            make.height.equalTo(16)
        }
        
        ttlabel.snp.makeConstraints { make in
            make.left.equalTo(timelabel.snp.left)
            make.top.equalTo(onelabel.snp.bottom).offset(10)
            make.height.equalTo(15.5)
        }
        blueView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 331, height: 60))
            make.top.equalTo(ttlabel.snp.bottom).offset(23)
        }
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(blueView.snp.bottom).offset(-16)
            make.size.equalTo(CGSize(width: 148, height: 33))
        }
        titlabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.left.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }
        appBtn.snp.makeConstraints { make in
            make.centerY.equalTo(namelabel.snp.centerY)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(22)
        }
        model.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            iconImageView.kf.setImage(with: URL(string: model.blinked ?? ""))
            namelabel.text = model.getting ?? ""
            onelabel.text = model.orderAmount ?? ""
            twolabel.text = model.moneyText ?? ""
            timelabel.text = model.dateValue ?? ""
            ttlabel.text = model.dateText ?? ""
            applyBtn.text = model.secret?.although ?? ""
            titlabel.text = model.secret?.liar ?? ""
            let good = model.secret?.good ?? 0
            appBtn.setTitle(model.secret?.rest, for: .normal)
            if good == 1 {
                appBtn.setBackgroundImage(UIImage(named: "redimgeim"), for: .normal)
            }else if good == 2 || good == 3 {
                appBtn.setBackgroundImage(UIImage(named: "origimagepice"), for: .normal)
            }else if good == 4 {
                appBtn.setBackgroundImage(UIImage(named: "blueimageif"), for: .normal)
            }else {
                appBtn.setBackgroundImage(UIImage(named: "greenccongimage"), for: .normal)
            }
        }).disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
