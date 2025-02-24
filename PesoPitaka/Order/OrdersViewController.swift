//
//  OrdersViewController.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/21.
//

import UIKit
import MJRefresh
import RxRelay

class OrdersViewController: BaseViewController {
    
    lazy var orView: OrderView = {
        let orView = OrderView()
        orView.tableView.delegate = self
        orView.tableView.dataSource = self
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
            guard let self = self else { return }
            currentStr = week
            getOrProdInfo(for: week)
        }
        
        self.orView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            self.getOrProdInfo(for: currentStr)
        })
        
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
                    if model.henceforth.instantly == nil {
                        self.orView.tableView.addSubview(self.nodataView)
                        self.nodataView.snp.makeConstraints { make in
                            make.edges.equalToSuperview()
                        }
                    }else {
                        self.nodataView.removeFromSuperview()
                    }
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
            cell.iconImageView.kf.setImage(with: URL(string: model.blinked ?? ""))
            cell.namelabel.text = model.getting ?? ""
            cell.onelabel.text = model.orderAmount ?? ""
            cell.twolabel.text = model.moneyText ?? ""
            cell.timelabel.text = model.dateValue ?? ""
            cell.defineBlueLabel.text = model.dateText ?? ""
            cell.applyBtn.text = model.secret?.although ?? ""
            cell.titlabel.text = model.secret?.liar ?? ""
            let good = model.secret?.good ?? 0
            cell.appBtn.setTitle(model.statusTextDescButton ?? "", for: .normal)
            if good == 1 {
                cell.appBtn.setBackgroundImage(UIImage(named: "redimgeim"), for: .normal)
            }else if good == 2 || good == 3 {
                cell.appBtn.setBackgroundImage(UIImage(named: "origimagepice"), for: .normal)
            }else if good == 4 {
                cell.appBtn.setBackgroundImage(UIImage(named: "blueimageif"), for: .normal)
            }else {
                cell.appBtn.setBackgroundImage(UIImage(named: "greenccongimage"), for: .normal)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.instantlyModelArray.value?[indexPath.row]
        let pageUrl = model?.grow ?? ""
        if pageUrl.contains(SCHEME_URL) {
            if pageUrl.contains("fennelCapers") {
                //jie
                if let url = URL(string: pageUrl) {
                    if let week = weekUrlStr(url: url) {
                        self.productDetailInfo(from: week)
                    }
                }
            }
        }else {
            self.pushWebVc(from: pageUrl)
        }
    }
    
}
