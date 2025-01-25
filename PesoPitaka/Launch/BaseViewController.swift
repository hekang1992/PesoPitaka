//
//  BaseViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/11.
//

import UIKit
import RxSwift
import Combine

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    
}

extension BaseViewController {
    
    func productDetailInfo(from weak: String) {
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
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    if let authModel = model.henceforth.indicating, let help = authModel.help, !help.isEmpty {
                        self.toGuideVc(from: help, week: weak)
                    }else {
                        let orderID = model.henceforth.summoned?.orderID ?? ""
                        self.orderIDToVc(for: orderID)
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
    
    func orderIDToVc(for orderID: String) {
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
                    self.pushWebVc(from: pageUrl)
                }else {
                    ToastConfig.showMessage(form: view, message: model.washed)
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    func pushWebVc(from url: String) {
        let commonModel = CommonModel.getCommonPera()
        let dictionary = commonModel.toDictionary()
        let hiveVc = HiveViewController()
        let pageUrl = URLQueryAppender.appendQueryParameters(to: url, parameters: dictionary)!.replacingOccurrences(of: " ", with: "%20")
        hiveVc.pageUrl = pageUrl
        self.navigationController?.pushViewController(hiveVc, animated: true)
    }
    
}
