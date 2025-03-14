//
//  OrderListViewController.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/2/15.
//

import UIKit
import RxRelay
import MJRefresh

class OrderListViewController: BaseViewController {
    
    var instantlyModelArray = BehaviorRelay<[instantlyModel]?>(value: nil)

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(OtpPeoViewCell.self, forCellReuseIdentifier: "OtpPeoViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var headtitle: String?
    
    var currentStr: String = "4"
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        return headView
    }()
    
    lazy var mustImageView: UIImageView = {
        let mustImageView = UIImageView()
        mustImageView.image = UIImage(named: "centerimgebg")
        mustImageView.isUserInteractionEnabled = true
        return mustImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(mustImageView)
        view.addSubview(headView)
        mustImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }).disposed(by: disposeBag)
        headView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH, height: 30))
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(5)
        }
        
        headView.namelabel.text = headtitle
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            self.getOrProdInfo(for: currentStr)
        })
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getOrProdInfo(for: currentStr)
    }

}

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            let rest = model.secret?.rest ?? ""
            if rest.isEmpty {
                cell.applyBtn.isHidden = true
            }else {
                cell.applyBtn.text = rest
                cell.applyBtn.isHidden = false
            }
            cell.titlabel.text = model.secret?.liar ?? ""
            let good = model.secret?.good ?? 0
            cell.appBtn.setTitle(model.secret?.although ?? "", for: .normal)
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

extension OrderListViewController {
    
    private func getOrProdInfo(for straight: String) {
        LoadingConfing.shared.showLoading()
        let man = NetworkConfigManager()
        let dict = ["tissue": "0",
                    "straight": straight,
                    "weak": "1",
                    "rich": "1"]
        let result = man.requsetData(url: "/entertain/opposing",
                                     parameters: dict,
                                     contentType: .json)
            .sink(receiveCompletion: { _ in
        }, receiveValue: { [weak self] data in
            LoadingConfing.shared.hideLoading()
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                if herself == "0" || herself == "00" {
                    self.instantlyModelArray.accept(model.henceforth.instantly ?? [])
                    self.tableView.reloadData()
                    if model.henceforth.instantly == nil {
                        self.tableView.addSubview(self.nodataView)
                        self.nodataView.snp.makeConstraints { make in
                            make.edges.equalToSuperview()
                        }
                    }else {
                        self.nodataView.removeFromSuperview()
                    }
                }
            } catch  {
                print("JSON: \(error)")
            }
            self.tableView.mj_header?.endRefreshing()
        })
        result.store(in: &cancellables)
    }
    
}


class NodataView: BaseView {
    
    lazy var noImageView: UIImageView = {
        let noImageView = UIImageView()
        noImageView.image = UIImage(named: "nodataimge")
        return noImageView
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UILabel()
        namelabel.text = "No Orders"
        namelabel.textColor = .black
        namelabel.textAlignment = .center
        namelabel.font = .regularFontOfSize(size: 13)
        return namelabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(noImageView)
        addSubview(namelabel)
        noImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset((SCREEN_HEIGHT - 150) * 0.3)
            make.left.equalToSuperview().offset((SCREEN_WIDTH - 250) * 0.5)
            make.size.equalTo(CGSize(width: 250, height: 150))
        }
        namelabel.snp.makeConstraints { make in
            make.centerX.equalTo(noImageView.snp.centerX)
            make.top.equalTo(noImageView.snp.bottom).offset(12)
            make.height.equalTo(15)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
