//
//  TermsViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/23.
//

import UIKit

class TermsViewController: BaseViewController {
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.namelabel.text = "Terms"
        return headView
    }()
    
    lazy var mustImageView: UIImageView = {
        let mustImageView = UIImageView()
        mustImageView.image = UIImage(named: "centerimgebg")
        mustImageView.isUserInteractionEnabled = true
        return mustImageView
    }()
    
    lazy var oneView: UIView = {
        let oneView = UIView()
        oneView.backgroundColor = .white
        oneView.layer.cornerRadius = 6
        return oneView
    }()
    
    lazy var twoView: UIView = {
        let twoView = UIView()
        twoView.backgroundColor = .white
        twoView.layer.cornerRadius = 6
        return twoView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "righiconafd")
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "righiconafd")
        return twoImageView
    }()
    
    lazy var onelabel: UILabel = {
        let onelabel = UILabel()
        onelabel.text = "Loan Agreement"
        onelabel.textColor = .black
        onelabel.textAlignment = .left
        onelabel.font = .regularFontOfSize(size: 15)
        return onelabel
    }()
    
    lazy var twolabel: UILabel = {
        let twolabel = UILabel()
        twolabel.text = "Privacy Policy"
        twolabel.textColor = .black
        twolabel.textAlignment = .left
        twolabel.font = .regularFontOfSize(size: 15)
        return twolabel
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(headView)
        view.addSubview(mustImageView)
        mustImageView.addSubview(oneView)
        mustImageView.addSubview(twoView)
        oneView.addSubview(oneImageView)
        oneView.addSubview(onelabel)
        twoView.addSubview(twoImageView)
        twoView.addSubview(twolabel)
        headView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(DeviceMetrics.navigationBarHeight)
        }
        mustImageView.snp.makeConstraints { make in
            make.width.equalTo(SCREEN_WIDTH)
            make.left.bottom.equalToSuperview()
            make.top.equalTo(headView.snp.bottom)
        }
        oneView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(15)
        }
        twoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(50)
            make.top.equalTo(oneView.snp.bottom).offset(15)
        }
        oneImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        twoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        onelabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(18)
        }
        twolabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(18)
        }
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        
    }
    
}
