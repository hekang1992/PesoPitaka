//
//  UserCenterViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/21.
//

import UIKit
import RxSwift

class UserCenterViewController: BaseViewController {
    
    lazy var centerView: CenterView = {
        let centerView = CenterView()
        return centerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bindOrderActions()
        bindFunctionActions()
        
    }
    


}

extension UserCenterViewController {
    
    private func bindOrderActions() {
        
        let oneBtnTap = centerView.oneBtn.rx.tap.map { self.centerView.oneBtn }
        let twoBtnTap = centerView.twoBtn.rx.tap.map { self.centerView.twoBtn }
        let threeBtnTap = centerView.threeBtn.rx.tap.map { self.centerView.threeBtn }
        let fourBtnTap = centerView.fourBtn.rx.tap.map { self.centerView.fourBtn }
        
        Observable.merge(oneBtnTap, twoBtnTap, threeBtnTap, fourBtnTap)
            .subscribe(onNext: { [weak self] selectedButton in
                guard let self = self else { return }
                switch selectedButton {
                case self.centerView.oneBtn:
                    print("one button tapped")
                case self.centerView.twoBtn:
                    print("two button tapped")
                case self.centerView.threeBtn:
                    print("three button tapped")
                case self.centerView.fourBtn:
                    print("four button tapped")
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    private func bindFunctionActions() {
        
        let aboutBtnTap = centerView.aboutBtn.rx.tap.map { self.centerView.aboutBtn }
        let connectBtnTap = centerView.connectBtn.rx.tap.map { self.centerView.connectBtn }
        let termsBtnTap = centerView.termsBtn.rx.tap.map { self.centerView.termsBtn }
        let settingBtnTap = centerView.settingBtn.rx.tap.map { self.centerView.settingBtn }
        
        Observable.merge(aboutBtnTap, connectBtnTap, termsBtnTap, settingBtnTap)
            .subscribe(onNext: { [weak self] selectedButton in
                guard let self = self else { return }
                switch selectedButton {
                case self.centerView.aboutBtn:
                    print("about button tapped")
                case self.centerView.connectBtn:
                    print("connect button tapped")
                case self.centerView.termsBtn:
                    let termsVc = TermsViewController()
                    self.navigationController?.pushViewController(termsVc, animated: true)
                case self.centerView.settingBtn:
                    let settingVc = SettingViewController()
                    self.navigationController?.pushViewController(settingVc, animated: true)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
    }
    
}
