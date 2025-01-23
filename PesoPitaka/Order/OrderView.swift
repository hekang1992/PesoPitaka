//
//  OrderView.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/22.
//

import UIKit
import RxSwift

class OrderView: BaseView {
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.namelabel.text = "Orders"
        headView.backBtn.isHidden = true
        return headView
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "centerimgebg")
        ctImageView.isUserInteractionEnabled = true
        return ctImageView
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ctImageView)
        addSubview(headView)
        addSubview(scrollView)
        scrollView.addSubview(oneBtn)
        scrollView.addSubview(twoBtn)
        scrollView.addSubview(threeBtn)
        scrollView.addSubview(fourBtn)
        
        ctImageView.snp.makeConstraints { make in
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
                    print("All button tapped")
                case self.twoBtn:
                    print("Processing button tapped")
                case self.threeBtn:
                    print("Repayment pending button tapped")
                case self.fourBtn:
                    print("Complete button tapped")
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    
}
