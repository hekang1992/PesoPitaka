//
//  GuideViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/23.
//

import UIKit
import RxRelay

class GuideViewController: BaseViewController {
    
    var dict = BehaviorRelay<[String: String]?>(value: nil)
    
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
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        
        guideView.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            let week = self?.dict.value?["week"] ?? ""
            self?.productDetailInfo(from: week)
        }).disposed(by: disposeBag)
        
    }

}

extension GuideViewController {
    
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
        if type == "familiarf" {
            let oneVc = GuideOneViewController()
            oneVc.week.accept(week)
            self.navigationController?.pushViewController(oneVc, animated: true)
        }
    }
    
}
