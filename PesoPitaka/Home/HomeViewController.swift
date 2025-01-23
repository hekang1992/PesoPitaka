//
//  HomeViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/21.
//

import UIKit
import RxRelay

class HomeViewController: BaseViewController {
    
    lazy var oneView: HomeZeroView = {
        let oneView = HomeZeroView()
        return oneView
    }()
    
    var model = BehaviorRelay<BaseModel?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(oneView)
        oneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        oneView.threeImageView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let weak = self.model.value?.henceforth.waking?.own?.first?.aware ?? 0
                self.applyInfo(from: String(weak))
            }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeInfo()
    }
    
    
}

extension HomeViewController {
    
    //get home data
    private func getHomeInfo() {
        LoadingConfing.shared.showLoading()
        let man = NetworkConfigManager()
        let dict = ["society": "1", "modern": "2"]
        let result = man.getRequest(url: "/entertain/hewould", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                if herself == "0" || herself == "00" {
                    self.model.accept(model)
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    private func applyInfo(from week: String) {
        LoadingConfing.shared.showLoading()
        let dict = ["week": week,
                    "services": "1",
                    "pay": "0"]
        let man = NetworkConfigManager()
        let result = man.requsetData(url: "/entertain/father", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                if herself == "0" || herself == "00" {
                    let pageUrl = model.henceforth.residing ?? ""
                    self.accordingUrl(from: pageUrl)
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    private func accordingUrl(from pageUrl: String) {
        if pageUrl.contains(SCHEME_URL) {
            if pageUrl.contains("fennelCapers") {
                if let url = URL(string: pageUrl), let query = url.query {
                    let components = query.components(separatedBy: "=")
                    if components.count > 1 {
                        let valueAfterEquals = components[1]
                        self.productDetailInfo(from: valueAfterEquals)
                    }
                }
            }
        }
    }
    
    private func productDetailInfo(from weak: String) {
        let dict = ["curiosity": "0",
                    "week": weak,
                    "creature": "maga"]
        let man = NetworkConfigManager()
        LoadingConfing.shared.showLoading()
        let result = man.requsetData(url: "/entertain/revolution", parameters: dict, contentType: .multipartFormData).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                if herself == "0" || herself == "00" {
                    if let authModel = model.henceforth.indicating, let help = authModel.help, !help.isEmpty {
                        self.toGuideVc(from: help, week: weak)
                    }else {
                        
                    }
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    private func toGuideVc(from type: String, week: String) {
        let guideVc = GuideViewController()
        let dict = ["type": type, "week": week]
        guideVc.dict.accept(dict)
        self.navigationController?.pushViewController(guideVc, animated: true)
    }
    
}
