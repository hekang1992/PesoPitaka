//
//  GuideViewController.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/23.
//

import UIKit
import RxRelay

class GuideViewController: BaseViewController {
    
    var dict = BehaviorRelay<[String: String]?>(value: nil)
    
    var model: BaseModel?
    
    lazy var guideView: GuideView = {
        let guideView = GuideView()
        return guideView
    }()
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.namelabel.text = "Verify Your Identity"
        return headView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(guideView)
        view.addSubview(headView)
        guideView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(30)
        }
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.popOutView()
//            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        
        guideView.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            let week = self?.dict.value?["week"] ?? ""
            self?.productDetailInfo(from: week, type: "1")
        }).disposed(by: disposeBag)
        
        guideView.opImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let pageUrl = API_H5_URL + "/mouseLavend"
                self.pushWebVc(from: pageUrl)
        }).disposed(by: disposeBag)
        
        guideView.oneBlock = { [weak self] in
            guard let self = self, let model = self.model else { return }
            let type = model.henceforth.indicating?.help ?? ""
            let week = self.dict.value?["week"] ?? ""
            if type >= "familiarf" {
                let oneVc = GuideOneViewController()
                oneVc.week.accept(week)
                self.navigationController?.pushViewController(oneVc, animated: true)
            }else {
                self.productDetailInfo(from: week, type: "1")
            }
        }
        
        guideView.twoBlock = { [weak self] in
            guard let self = self, let model = self.model else { return }
            let type = model.henceforth.indicating?.help ?? ""
            let week = self.dict.value?["week"] ?? ""
            if type >= "familiarg" {
                let twoVc = MonsterViewController()
                twoVc.week.accept(week)
                twoVc.onePageUrl = "/entertain/necessary"
                twoVc.twoPageUrl = "/entertain/wanted"
                twoVc.titleStr = "Identity Information"
                twoVc.imageStr = "swconeimage"
                self.navigationController?.pushViewController(twoVc, animated: true)
            }else {
                self.productDetailInfo(from: week, type: "1")
            }
        }
        
        guideView.threeBlock = { [weak self] in
            guard let self = self, let model = self.model else { return }
            let type = model.henceforth.indicating?.help ?? ""
            let week = self.dict.value?["week"] ?? ""
            if type >= "familiarh" {
                let workVc = MonsterViewController()
                workVc.week.accept(week)
                workVc.onePageUrl = "/entertain/bucket"
                workVc.twoPageUrl = "/entertain/barton"
                workVc.titleStr = "Work Information"
                workVc.imageStr = "thremigepnf"
                self.navigationController?.pushViewController(workVc, animated: true)
            }else {
                self.productDetailInfo(from: week, type: "1")
            }
        }
        
        guideView.fourBlock = { [weak self] in
            guard let self = self, let model = self.model else { return }
            let type = model.henceforth.indicating?.help ?? ""
            let week = self.dict.value?["week"] ?? ""
            if type >= "familiari" {
                let serviceVc = ServerViewController()
                serviceVc.week.accept(week)
                self.navigationController?.pushViewController(serviceVc, animated: true)
            }else {
                self.productDetailInfo(from: week, type: "1")
            }
        }
        
        guideView.fiveBlock = { [weak self] in
            guard let self = self, let model = self.model else { return }
            let type = model.henceforth.indicating?.help ?? ""
            let week = self.dict.value?["week"] ?? ""
            if type >= "familiarj" {
                let week = self.dict.value?["week"] ?? ""
                let payVc = PayViewController()
                payVc.week.accept(week)
                self.navigationController?.pushViewController(payVc, animated: true)
            }else {
                self.productDetailInfo(from: week, type: "1")
            }
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let week = self.dict.value?["week"] ?? ""
        productDetailInfo(from: week, type: "0")
    }
    
}

extension GuideViewController {
    
    private func productDetailInfo(from weak: String, type: String) {
        let dict = ["curiosity": "0",
                    "week": weak,
                    "creature": "maga"]
        let man = NetworkConfigManager()
        LoadingConfing.shared.showLoading()
        let result = man.requsetData(url: "/entertain/revolution",
                                     parameters: dict,
                                     contentType: .multipartFormData)
            .sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                self.model = model
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    if let authModel = model.henceforth.indicating, let help = authModel.help, !help.isEmpty {
                        if type == "1" {
                            self.toGuideVc(from: help, week: weak)
                        }else {
                            //UI
                            uiInfo(for: model)
                        }
                    }else {
                        
                    }
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    private func uiInfo(for model: BaseModel) {
        let type = model.henceforth.indicating?.help ?? ""
        let defaultImage = UIImage(named: "futhaimage")
        switch type {
        case "familiarf":
            
            break
        case "familiarg":
            guideView.oneView.bgImageView.image = defaultImage
        case "familiarh":
            guideView.oneView.bgImageView.image = defaultImage
            guideView.twoView.bgImageView.image = defaultImage
        case "familiari":
            guideView.oneView.bgImageView.image = defaultImage
            guideView.twoView.bgImageView.image = defaultImage
            guideView.threeView.bgImageView.image = defaultImage
        case "familiarj":
            guideView.oneView.bgImageView.image = defaultImage
            guideView.twoView.bgImageView.image = defaultImage
            guideView.threeView.bgImageView.image = defaultImage
            guideView.fourView.bgImageView.image = defaultImage
        default:
            guideView.oneView.bgImageView.image = defaultImage
            guideView.twoView.bgImageView.image = defaultImage
            guideView.threeView.bgImageView.image = defaultImage
            guideView.fourView.bgImageView.image = defaultImage
            guideView.fiveView.bgImageView.image = defaultImage
        }
    }
    
}
