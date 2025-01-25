//
//  TermsViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/23.
//

import UIKit
import RxGesture
import TYAlertController

class SettingViewController: BaseViewController {
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.namelabel.text = "Setting"
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
        onelabel.text = "Check for updates"
        onelabel.textColor = .black
        onelabel.textAlignment = .left
        onelabel.font = .regularFontOfSize(size: 15)
        return onelabel
    }()
    
    lazy var twolabel: UILabel = {
        let twolabel = UILabel()
        twolabel.text = "Log Out"
        twolabel.textColor = .black
        twolabel.textAlignment = .left
        twolabel.font = .regularFontOfSize(size: 15)
        return twolabel
    }()
    
    lazy var deleteBtn: UIButton = {
        let deleteBtn = UIButton(type: .custom)
        deleteBtn.setTitleColor(.init(colorHexStr: "#0D9196"), for: .normal)
        deleteBtn.setTitle("Delete Account", for: .normal)
        deleteBtn.titleLabel?.font = .regularFontOfSize(size: 15)
        return deleteBtn
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
        view.addSubview(deleteBtn)
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
        deleteBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(twoView.snp.bottom).offset(55)
            make.height.equalTo(40)
        }
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        
        oneView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            self?.getCenterInfo()
        }).disposed(by: disposeBag)
        
        twoView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            self?.logoutInfo()
        }).disposed(by: disposeBag)
        
        deleteBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.deleteInfo()
        }).disposed(by: disposeBag)

        
    }
    
    private func getCenterInfo() {
        LoadingConfing.shared.showLoading()
        let man = NetworkConfigManager()
        let dict = ["opportunities": "1", "mother": "0"]
        let result = man.getRequest(url: "/entertain/afterwardsto", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    ToastConfig.showMessage(form: view, message: "It is already the latest version.")
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    private func logoutInfo() {
        let logView = AlertImageView(frame: self.view.bounds)
        logView.bgImageView.image = UIImage(named: "logoutifad")
        let alertVc = TYAlertController(alert: logView, preferredStyle: .alert)!
        self.present(alertVc, animated: true)
        logView.oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
        logView.twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.outInfo()
        }).disposed(by: disposeBag)
    }
    
    private func deleteInfo() {
        let logView = AlertImageView(frame: self.view.bounds)
        logView.threeBtn.isHidden = false
        logView.threeBtn.rx.tap.subscribe(onNext: {
            logView.threeBtn.isSelected.toggle()
        }).disposed(by: disposeBag)
        logView.bgImageView.image = UIImage(named: "deleitemiamge")
        let alertVc = TYAlertController(alert: logView, preferredStyle: .alert)!
        self.present(alertVc, animated: true)
        logView.oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
        logView.twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if logView.threeBtn.isSelected {
                self.delInfo()
            }else {
                ToastConfig.showMessage(form: logView, message: "Please confirm the agreement first, and then decide whether to delete the account.")
            }
            
        }).disposed(by: disposeBag)
    }
    
    private func outInfo() {
        LoadingConfing.shared.showLoading()
        let man = NetworkConfigManager()
        let dict = [String: Any]()
        let result = man.getRequest(url: "/entertain/handkerchief", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    self.dismiss(animated: true) {
                        LoginSuccessConfig.removeLoginInfo()
                        loginSuccessPush.toRootVc()
                    }
                }
                ToastConfig.showMessage(form: view, message: model.washed)
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    private func delInfo() {
        LoadingConfing.shared.showLoading()
        let man = NetworkConfigManager()
        let dict = [String: Any]()
        let result = man.getRequest(url: "/entertain/something", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    self.dismiss(animated: true) {
                        LoginSuccessConfig.removeLoginInfo()
                        loginSuccessPush.toRootVc()
                    }
                }
                ToastConfig.showMessage(form: view, message: model.washed)
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
}

