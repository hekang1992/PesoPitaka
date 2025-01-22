//
//  HomeViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/21.
//

import UIKit

class HomeViewController: BaseViewController {
    
    lazy var oneView: HomeZeroView = {
        let oneView = HomeZeroView()
        return oneView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(oneView)
        oneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
                    
                }
                
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
        
    }
    
}
