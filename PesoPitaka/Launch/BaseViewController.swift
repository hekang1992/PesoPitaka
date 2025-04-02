//
//  BaseViewController.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/11.
//

import UIKit
import RxSwift
import Combine
import TYAlertController

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var cancellables = Set<AnyCancellable>()
    
    var priid: String = ""
    
    var ninetime: String = ""
    
    lazy var nodataView: NodataView = {
        let nodataView = NodataView()
        return nodataView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    
}

extension BaseViewController {
    
    func productDetailInfo(from weak: String, type: String? = "") {
        let dict = ["curiosity": "0",
                    "week": weak,
                    "creature": "maga"]
        let man = NetworkConfigManager()
        LoadingConfing.shared.showLoading()
        ninetime = DateUtils.getCurrentTimestampInMilliseconds()
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
                        self.toGuideVc(from: help, week: weak)
                    }else {
                        let orderID = model.henceforth.summoned?.orderID ?? ""
                        self.orderIDToVc(for: orderID, week: weak, type: type)
                    }
                }else {
                    ToastConfig.showMessage(form: view, message: model.washed)
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    func toGuideVc(from type: String, week: String) {
        if type == "familiarf" {
            let oneVc = GuideOneViewController()
            oneVc.week.accept(week)
            self.navigationController?.pushViewController(oneVc, animated: true)
        }else if type == "familiarg" {
            let twoVc = MonsterViewController()
            twoVc.week.accept(week)
            twoVc.onePageUrl = "/entertain/necessary"
            twoVc.twoPageUrl = "/entertain/wanted"
            twoVc.titleStr = "Identity Information"
            twoVc.imageStr = "swconeimage"
            self.navigationController?.pushViewController(twoVc, animated: true)
        }else if type == "familiarh" {
            let workVc = MonsterViewController()
            workVc.week.accept(week)
            workVc.onePageUrl = "/entertain/bucket"
            workVc.twoPageUrl = "/entertain/barton"
            workVc.titleStr = "Work Information"
            workVc.imageStr = "thremigepnf"
            self.navigationController?.pushViewController(workVc, animated: true)
        }else if type == "familiari" {
            let serviceVc = ServerViewController()
            serviceVc.week.accept(week)
            self.navigationController?.pushViewController(serviceVc, animated: true)
        }else if type == "familiarj" {
            let payVc = PayViewController()
            payVc.week.accept(week)
            self.navigationController?.pushViewController(payVc, animated: true)
        }
    }
    
    func orderIDToVc(for orderID: String, week: String, type: String? = "") {
        LoadingConfing.shared.showLoading()
        let dict = ["seriously": "1",
                    "maybe": "2",
                    "purgatory": orderID,
                    "curious": "0"]
        let man = NetworkConfigManager()
        let result = man.requsetData(url: "/entertain/purpose", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
        }, receiveValue: { [weak self] data in
            LoadingConfing.shared.hideLoading()
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    let pageUrl = model.henceforth.residing ?? ""
                    nineInfo(from: week)
                    self.pushWebVc(from: pageUrl, type: type)
                }else {
                    ToastConfig.showMessage(form: view, message: model.washed)
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    func pushWebVc(from url: String, type: String? = "") {
        let commonModel = CommonModel.getCommonPera()
        let dictionary = commonModel.toDictionary()
        let hiveVc = PaMaskViewController()
        let pageUrl = URLQueryAppender.appendQueryParameters(to: url, parameters: dictionary)!.replacingOccurrences(of: " ", with: "%20")
        hiveVc.pageUrl = pageUrl
        hiveVc.type.accept(type ?? "")
        self.navigationController?.pushViewController(hiveVc, animated: true)
    }
    
}


extension BaseViewController {
    
    func weekUrlStr(url: URL) -> String? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        let queryItems = components.queryItems ?? []
        let lastQueryItem = queryItems.reduce(nil) { (result, item) -> URLQueryItem? in
            return item
        }
        
        return lastQueryItem?.value
    }
    
    private func nineInfo(from week: String) {
        let location = LocationManager()
        let time = DateUtils.getCurrentTimestampInMilliseconds()
        location.getLocationInfo { [weak self] model in
            guard let self = self else { return }
            let dict = ["mom": week,
                        "mood": String(model.mood),
                        "reagar": String(model.reagar),
                        "spread": "9",
                        "saving": AwkwardManager.getIDFV(),
                        "why": AwkwardManager.getIDFA(),
                        "teeth": ninetime,
                        "gritted": time]
            let man = NetworkConfigManager()
            let result = man.requsetData(url: "/entertain/answered", parameters: dict, contentType: .multipartFormData).sink(receiveCompletion: { _ in
            }, receiveValue: {  data in
                
            })
            result.store(in: &cancellables)
        }
    }
    
}

extension BaseViewController {
    
    func popOutView() {
        let imageView = AlertImageView(frame: self.view.bounds)
        imageView.cancelBtn.isHidden = false
        imageView.bgImageView.image = UIImage(named: "dontpusolo")
        let alertVc = TYAlertController(alert: imageView, preferredStyle: .alert)!
        self.present(alertVc, animated: true)
        imageView.cancelBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
        imageView.oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: {
                self.popToTargetViewController()
            })
        }).disposed(by: disposeBag)
        imageView.twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: {
                self.popToTargetViewController()
            })
        }).disposed(by: disposeBag)
    }
    
    func popToTargetViewController() {
        if let targetViewController = self.navigationController?.viewControllers.first(where: { $0 is GuideViewController }) {
            if self == targetViewController {
                self.navigationController?.popViewController(animated: true)
            }else {
                self.navigationController?.popToViewController(targetViewController, animated: true)
            }
        }else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
