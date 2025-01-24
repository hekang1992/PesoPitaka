//
//  LoginViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/21.
//

import UIKit
import Combine

class LoginViewController: BaseViewController {
    
    lazy var loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()
    
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
            self?.getLoginInfo()
        }).disposed(by: disposeBag)
        
        
    }
    
}

extension LoginViewController {
    
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
                    
                }
                ToastConfig.showMessage(form: self.view, message: model.washed)
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    private func getLoginInfo() {
        LoadingConfing.shared.showLoading()
        let man = NetworkConfigManager()
        let phone = self.loginView.phoneTx.text ?? ""
        let code = self.loginView.codeTx.text ?? ""
        let dict = ["differently": phone,
                    "them": code,
                    "address": "php"]
       let result = man.requsetData(url: "/entertain/himselfhe", parameters: dict, contentType: .multipartFormData).sink(receiveCompletion: { _ in
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
                    LoginSuccessConfig.saveLoginInfo(phone: phone, token: token)
                    loginSuccessPush.toRootVc()
                }
                ToastConfig.showMessage(form: self.view, message: model.washed)
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    
}
