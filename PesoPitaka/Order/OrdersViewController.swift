//
//  OrdersViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/21.
//

import UIKit
import MJRefresh
import RxRelay

class OrdersViewController: BaseViewController {
    
    lazy var orView: OrderView = {
        let orView = OrderView()
        return orView
    }()
    
    var instantlyModelArray = BehaviorRelay<[instantlyModel]?>(value: nil)
    
    var currentStr: String = "4"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(orView)
        orView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        orView.block = { [weak self] week in
            self?.currentStr = week
            self?.getOrProdInfo(for: week)
        }
        
        self.orView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            self.getOrProdInfo(for: currentStr)
        })
        
        self.orView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        self.orView.tableView.rx.setDataSource(self).disposed(by: disposeBag)
        
        
        
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getOrProdInfo(for: currentStr)
    }
    
}

extension OrdersViewController {
    
    private func getOrProdInfo(for straight: String) {
        LoadingConfing.shared.showLoading()
        let man = NetworkConfigManager()
        let dict = ["tissue": "0",
                    "straight": straight,
                    "weak": "1",
                    "rich": "1"]
        let result = man.requsetData(url: "/entertain/opposing", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
        }, receiveValue: { [weak self] data in
            LoadingConfing.shared.hideLoading()
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                if herself == "0" || herself == "00" {
                    self.instantlyModelArray.accept(model.henceforth.instantly ?? [])
                    self.orView.tableView.reloadData()
                }
            } catch  {
                print("JSON: \(error)")
            }
            self.orView.tableView.mj_header?.endRefreshing()
        })
        result.store(in: &cancellables)
    }
    
}

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = self.instantlyModelArray.value ?? []
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtpPeoViewCell", for: indexPath) as! OtpPeoViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        if let model = self.instantlyModelArray.value?[indexPath.row] {
            cell.model.accept(model)
        }
        return cell
    }
    
}
