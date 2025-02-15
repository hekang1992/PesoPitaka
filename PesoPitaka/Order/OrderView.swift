//
//  OrderView.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/22.
//

import UIKit
import RxSwift

class OrderView: BaseView {
    
    var block: ((String) -> Void)?
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.namelabel.text = "Orders"
        headView.backBtn.isHidden = true
        return headView
    }()
    
    lazy var mustImageView: UIImageView = {
        let mustImageView = UIImageView()
        mustImageView.image = UIImage(named: "centerimgebg")
        mustImageView.isUserInteractionEnabled = true
        return mustImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.setTitle("All", for: .normal)
        oneBtn.backgroundColor = .white
        oneBtn.layer.cornerRadius = 5
        oneBtn.setTitleColor(.black, for: .normal)
        oneBtn.titleLabel?.font = .regularFontOfSize(size: 14)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setTitle("Processing", for: .normal)
        twoBtn.backgroundColor = .white
        twoBtn.layer.cornerRadius = 5
        twoBtn.setTitleColor(.init(colorHexStr: "#717171"), for: .normal)
        twoBtn.titleLabel?.font = .regularFontOfSize(size: 14)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.setTitle("Repayment pendin", for: .normal)
        threeBtn.backgroundColor = .white
        threeBtn.layer.cornerRadius = 5
        threeBtn.setTitleColor(.init(colorHexStr: "#717171"), for: .normal)
        threeBtn.titleLabel?.font = .regularFontOfSize(size: 14)
        return threeBtn
    }()
    
    lazy var fourBtn: UIButton = {
        let fourBtn = UIButton(type: .custom)
        fourBtn.setTitle("Complete", for: .normal)
        fourBtn.backgroundColor = .white
        fourBtn.layer.cornerRadius = 5
        fourBtn.setTitleColor(.init(colorHexStr: "#717171"), for: .normal)
        fourBtn.titleLabel?.font = .regularFontOfSize(size: 14)
        return fourBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(OtpPeoViewCell.self, forCellReuseIdentifier: "OtpPeoViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mustImageView)
        addSubview(headView)
        addSubview(scrollView)
        scrollView.addSubview(oneBtn)
        scrollView.addSubview(twoBtn)
        scrollView.addSubview(threeBtn)
        scrollView.addSubview(fourBtn)
        
        addSubview(tableView)
        
        mustImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH, height: 30))
        }
        scrollView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(SCREEN_WIDTH)
            make.top.equalTo(headView.snp.bottom).offset(20)
        }
        oneBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 61, height: 40))
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        twoBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 98, height: 40))
            make.left.equalTo(oneBtn.snp.right).offset(15)
            make.centerY.equalToSuperview()
        }
        threeBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 155, height: 40))
            make.left.equalTo(twoBtn.snp.right).offset(15)
            make.centerY.equalToSuperview()
        }
        fourBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 98, height: 40))
            make.left.equalTo(threeBtn.snp.right).offset(15)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scrollView.snp.bottom).offset(5)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        bindButtonActions()
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OrderView {
    
    private func bindButtonActions() {
        let oneBtnTap = oneBtn.rx.tap.map { self.oneBtn }
        let twoBtnTap = twoBtn.rx.tap.map { self.twoBtn }
        let threeBtnTap = threeBtn.rx.tap.map { self.threeBtn }
        let fourBtnTap = fourBtn.rx.tap.map { self.fourBtn }
        
        Observable.merge(oneBtnTap, twoBtnTap, threeBtnTap, fourBtnTap)
            .subscribe(onNext: { [weak self] selectedButton in
                guard let self = self else { return }
                [self.oneBtn, self.twoBtn, self.threeBtn, self.fourBtn].forEach { button in
                    button.setTitleColor(UIColor(colorHexStr: "#717171"), for: .normal)
                }
                selectedButton.setTitleColor(.black, for: .normal)
                switch selectedButton {
                case self.oneBtn:
                    self.block?("4")
                case self.twoBtn:
                    self.block?("7")
                case self.threeBtn:
                    self.block?("6")
                case self.fourBtn:
                    self.block?("5")
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    
}
