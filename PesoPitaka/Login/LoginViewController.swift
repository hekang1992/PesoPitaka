//
//  LoginViewController.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/21.
//

import UIKit
import Combine

let ONETIME = "ONETIME"
let TWOTIME = "TWOTIME"

class LoginViewController: BaseViewController {
    
    lazy var loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()
    
    var timer: Timer!
    
    var second: Int = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginView.sendBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.getCodeInfo()
        }).disposed(by: disposeBag)
        
        loginView.loginBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if self.loginView.isClickPri == "1" {
                ToastConfig.showMessage(form: view, message: "Please review and accept the user agreement first.")
            }else {
                self.getLoginInfo()
            }
        }).disposed(by: disposeBag)
        
        let onetime = DateUtils.getCurrentTimestampInMilliseconds()
        UserDefaults.standard.set(onetime, forKey: ONETIME)
        UserDefaults.standard.synchronize()
        
        
        self.loginView.codeTx
            .rx
            .text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                self?.handleTextChange(text)
            })
            .disposed(by: disposeBag)
        
        self.loginView.xBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let pageUrl = API_H5_URL + "/mouseLavend"
            self.pushWebVc(from: pageUrl)
        }).disposed(by: disposeBag)
        
    }
    
}

extension LoginViewController {
    
    private func handleTextChange(_ text: String) {
        if text.count > 6 {
            self.loginView.codeTx.text = String(text.prefix(6))
        }
        if text.count == 6 {
            if self.loginView.isClickPri == "1" {
                ToastConfig.showMessage(form: view, message: "Please review and accept the user agreement first.")
            }else {
                self.loginView.codeTx.resignFirstResponder()
                self.getLoginInfo()
            }
        }
    }
    
    private func getCodeInfo() {
        LoadingConfing.shared.showLoading()
        let man = NetworkConfigManager()
        let phone = self.loginView.phoneTx.text ?? ""
        let dict = ["officially": phone,
                    "meeting": "1",
                    "love": "0"]
        let result = man.requsetData(url: "/entertain/although", parameters: dict, contentType: .multipartFormData).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    self.loginView.sendBtn.isEnabled = false
                    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(masktimesz), userInfo: nil, repeats: true)
                }
                ToastConfig.showMessage(form: self.view, message: model.washed)
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    private func getLoginInfo() {
        let man = NetworkConfigManager()
        let phone = self.loginView.phoneTx.text ?? ""
        let code = self.loginView.codeTx.text ?? ""
        guard !phone.isEmpty else {
            ToastConfig.showMessage(form: view, message: "Please input your mobile number")
            return
        }
        guard !code.isEmpty else {
            ToastConfig.showMessage(form: view, message: "Please input the verification code")
            return
        }
        LoadingConfing.shared.showLoading()
        let dict = ["differently": phone,
                    "them": code,
                    "location": "php_manina"]
        let result = man.requsetData(url: "/entertain/himselfhe",
                                     parameters: dict,
                                     contentType: .multipartFormData)
            .sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    let phone = model.henceforth.phone ?? ""
                    let token = model.henceforth.token ?? ""
                    let twotime = DateUtils.getCurrentTimestampInMilliseconds()
                    UserDefaults.standard.set(twotime, forKey: TWOTIME)
                    UserDefaults.standard.synchronize()
                    LoginManager.shared.saveLoginInfo(phone: phone, token: token)
                    loginSuccessPush.toRootVc()
                }
                ToastConfig.showMessage(form: self.view, message: model.washed)
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    @objc func masktimesz() {
        if second > 0 {
            second -= 1
            self.loginView.sendBtn.setTitle("\(self.second)s", for: .normal)
        } else {
            blockTimer()
        }
    }
    
    private func blockTimer() {
        timer.invalidate()
        second = 60
        self.loginView.sendBtn.isEnabled = true
        self.loginView.sendBtn.setTitle("Send Code", for: .normal)
    }
    
}
