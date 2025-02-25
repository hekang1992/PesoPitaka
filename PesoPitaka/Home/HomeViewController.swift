//
//  HomeViewController.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/21.
//

import UIKit
import RxRelay
import MJRefresh
import RxSwift
import CoreLocation

let TNT_ONE_INFO = "TNT_ONE_INFO"

class HomeViewController: BaseViewController {
    
    lazy var oneView: HomeZeroView = {
        let oneView = HomeZeroView()
        oneView.alpha = 0
        return oneView
    }()
    
    lazy var mustView: HiveMustView = {
        let mustView = HiveMustView()
        mustView.alpha = 0
        return mustView
    }()
    
    var model = BehaviorRelay<BaseModel?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(oneView)
        view.addSubview(mustView)
        oneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mustView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mustView.block = { [weak self] model in
            self?.appInfoweek(from: String(model.aware ?? 0))
        }
        
        mustView.block1 = { [weak self] model in
            guard let self = self else { return  }
            let residing = model.residing ?? ""
            if residing.isEmpty {
                return
            }else {
                self.pushWebVc(from: residing)
            }
        }
        
        mustView.block2 = { [weak self] model in
            guard let self = self else { return  }
            let residing = model.residing ?? ""
            if residing.isEmpty {
                return
            }else {
                self.pushWebVc(from: residing)
            }
        }
        
        oneView.priBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let pageUrl = API_H5_URL + "/mouseLavend"
            self.pushWebVc(from: pageUrl)
        }).disposed(by: disposeBag)
        
        oneView.threeImageView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self, let model = self.model.value else { return }
                self.applyInfo(from: model)
            }).disposed(by: disposeBag)
        
        getAddressInfo()
        
        self.model.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            let pitiful = model.henceforth.waking?.pitiful ?? ""
            if pitiful == "familiarc" {
                mustView.alpha = 1
                oneView.alpha = 0
                mustView.model.accept(model)
                self.mustView.tableView.reloadData()
                self.mustView.cycleMustSignView.reloadData()
                self.mustView.cycleMinSignView.reloadData()
            }else if pitiful == "familiarb" {
                oneView.alpha = 1
                mustView.alpha = 0
            }
        }).disposed(by: disposeBag)
        
        self.mustView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            getHomeInfo()
        })
        
        self.oneView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            getHomeInfo()
        })
        
        let location = LocationManager()
        location.getLocationInfo { geoModel in
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeInfo()
    }
    
}

extension HomeViewController {
    
    private func getAddressInfo() {
        let dict = ["address": "1", "php": "1"]
        let man = NetworkConfigManager()
        let result = man.getRequest(url: "/entertain/thought",
                                    parameters: dict,
                                    contentType: .json)
            .sink(receiveCompletion: { _ in
            
        }, receiveValue: { data in
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    let addressModelArray = model.henceforth.instantly ?? []
                    ServerDataManager.shared.saveData(addressModelArray)
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    //get home data
    private func getHomeInfo() {
        LoadingConfing.shared.showLoading()
        let man = NetworkConfigManager()
        let dict = ["society": "1",
                    "modern": "2",
                    "Apple": "1"]
        let result = man.getRequest(url: "/entertain/hewould",
                                    parameters: dict,
                                    contentType: .json)
            .sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    self.model.accept(model)
                }
            } catch  {
                print("JSON: \(error)")
            }
            self.oneView.scrollView.mj_header?.endRefreshing()
            self.mustView.tableView.mj_header?.endRefreshing()
        })
        result.store(in: &cancellables)
    }
    
    private func applyInfo(from model: BaseModel) {
        let choose = model.henceforth.choose ?? 0
        if choose == 0 {
            appInfo(from: model)
        }else {
            let status: CLAuthorizationStatus
            if #available(iOS 14.0, *) {
                status = CLLocationManager().authorizationStatus
            } else {
                status = CLLocationManager.authorizationStatus()
            }
            switch status {
            case .restricted, .denied:
                showAlert()
            case .authorizedWhenInUse, .authorizedAlways:
                appInfo(from: model)
            default:
                break
            }
        }
    }
    
    private func appInfo(from model: BaseModel) {
        self.upLoadInfo()
        let weak = String(model.henceforth.waking?.own?.first?.aware ?? 0)
        LoadingConfing.shared.showLoading()
        let dict = ["week": weak,
                    "services": "1",
                    "pay": "0",
                    "login": "google"]
        let man = NetworkConfigManager()
        let result = man.requsetData(url: "/entertain/father", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
        }, receiveValue: { [weak self] data in
            LoadingConfing.shared.hideLoading()
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    let pageUrl = model.henceforth.residing ?? ""
                    self.accordingUrl(from: pageUrl)
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    private func appInfoweek(from week: String) {
        LoadingConfing.shared.showLoading()
        let dict = ["week": week,
                    "services": "1",
                    "pay": "0",
                    "auto": "1"]
        let man = NetworkConfigManager()
        let result = man.requsetData(url: "/entertain/father", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
        }, receiveValue: { [weak self] data in
            LoadingConfing.shared.hideLoading()
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    let pageUrl = model.henceforth.residing ?? ""
                    self.accordingUrl(from: pageUrl)
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Location Permission", message: "Location Permission Location Permission Location Permission", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Go", style: .default) { (action) in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(settingsURL) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }
        }
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func accordingUrl(from pageUrl: String) {
        if pageUrl.contains(SCHEME_URL) {
            if pageUrl.contains("fennelCapers") {
                if let url = URL(string: pageUrl), let query = url.query {
                    let components = query.components(separatedBy: "=")
                    if components.count > 1 {
                        let valueAfterEquals = components[1]
                        self.productDetailInfoo(from: valueAfterEquals)
                    }
                }
            }
        }else {
            self.pushWebVc(from: pageUrl)
        }
    }
    
    private func productDetailInfoo(from weak: String) {
        let dict = ["curiosity": "0",
                    "week": weak,
                    "creature": "image",
                    "stage": "project"]
        let man = NetworkConfigManager()
        LoadingConfing.shared.showLoading()
        let result = man.requsetData(url: "/entertain/revolution", parameters: dict, contentType: .multipartFormData).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    if let authModel = model.henceforth.indicating, let help = authModel.help, !help.isEmpty {
                        self.toOneGuideVc(from: help, week: weak)
                    }else {
                        let orderID = model.henceforth.summoned?.orderID ?? ""
                        self.orderIDToVc(for: orderID, week: weak)
                    }
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    private func toOneGuideVc(from type: String, week: String) {
        let guideVc = GuideViewController()
        let dict = ["type": type, "week": week]
        guideVc.dict.accept(dict)
        self.navigationController?.pushViewController(guideVc, animated: true)
    }
    
}


extension HomeViewController {
    
    private func upLoadInfo() {
        let grand = UserDefaults.standard.object(forKey: TNT_ONE_INFO) as? String ?? ""
        if grand != "1" {
            self.oneInfo()
        }
        self.locaionInfo()
        self.deveinof()
    }
    
    //4
    private func deveinof() {
        let dict = MustLpNineSte.getAllDinfo()
        let databyte = try? JSONSerialization.data(withJSONObject: dict)
        let baseStr = databyte?.base64EncodedString() ?? ""
        let man = NetworkConfigManager()
        let adict = ["henceforth": baseStr]
        let result = man.requsetData(url: "/entertain/eloquence",
                                     parameters: adict,
                                     contentType: .multipartFormData)
            .sink(receiveCompletion: { _ in
        }, receiveValue: {  data in
            
        })
        result.store(in: &cancellables)
    }
    
    private func locaionInfo() {
        let location = LocationManager()
        location.getLocationInfo { [weak self] model in
            guard let self = self else { return }
            let dict = ["watched": model.watched,
                        "blame": model.blame,
                        "improve": model.improve,
                        "seemed": model.seemed,
                        "mood": String(model.mood),
                        "reagar": String(model.reagar),
                        "expression": model.expression,
                        "flustered": model.flustered,
                        "seeing": model.seeing]
            let man = NetworkConfigManager()
            let result = man.requsetData(url: "/entertain/dramatic",
                                         parameters: dict,
                                         contentType: .multipartFormData)
                .sink(receiveCompletion: { _ in
            }, receiveValue: {  data in
                
            })
            result.store(in: &cancellables)
        }
    }
    
    private func oneInfo() {
        let weak = String(self.model.value?.henceforth.waking?.own?.first?.aware ?? 0)
        let onetime = UserDefaults.standard.object(forKey: ONETIME) as? String ?? ""
        let twotime = UserDefaults.standard.object(forKey: TWOTIME) as? String ?? ""
        let location = LocationManager()
        location.getLocationInfo { [weak self] model in
            guard let self = self else { return }
            let dict = ["mom": weak,
                        "mood": String(model.mood),
                        "reagar": String(model.reagar),
                        "spread": "1",
                        "tid": "999",
                        "token": "aes_res_php_ios",
                        "saving": AwkwardManager.getIDFV(),
                        "why": AwkwardManager.getIDFA(),
                        "teeth": onetime,
                        "gritted": twotime]
            let man = NetworkConfigManager()
            let result = man.requsetData(url: "/entertain/answered",
                                         parameters: dict,
                                         contentType: .multipartFormData)
                .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] data in
                guard let self = self else { return }
                do {
                    let model = try JSONDecoder().decode(BaseModel.self, from: data)
                    let herself = model.herself
                    let invalidValues: Set<String> = ["0", "00"]
                    if invalidValues.contains(herself) {
                        UserDefaults.standard.set("1", forKey: TNT_ONE_INFO)
                        UserDefaults.standard.synchronize()
                    }
                } catch  {
                    print("JSON: \(error)")
                }
            })
            result.store(in: &cancellables)
        }
    }
    
}
