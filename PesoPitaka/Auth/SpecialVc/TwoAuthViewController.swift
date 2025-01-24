//
//  TwoAuthViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/24.
//

import UIKit
import RxRelay

class TwoAuthViewController: BaseViewController {
    
    var week = BehaviorRelay<String>(value: "")
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "loginbgimage")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.namelabel.text = "Identity Information"
        return headView
    }()
    
    lazy var poImageView: UIImageView = {
        let poImageView = UIImageView()
        poImageView.image = UIImage(named: "swconeimage")
        return poImageView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.backgroundColor = UIColor.init(colorHexStr: "#6DDEE2")
        nextBtn.setTitle("Next", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = .regularFontOfSize(size: 19)
        nextBtn.layer.cornerRadius = 30
        return nextBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(bgImageView)
        view.addSubview(headView)
        view.addSubview(poImageView)
        view.addSubview(nextBtn)
        view.addSubview(tableView)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(30)
        }
        poImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(42)
            make.size.equalTo(CGSize(width: 350, height: 40))
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(poImageView.snp.bottom).offset(5)
            make.bottom.equalTo(nextBtn.snp.top).offset(-5)
        }
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }).disposed(by: disposeBag)
        
        nextBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        getgidInfo()
        
    }

}

extension TwoAuthViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "fdaf"
        return cell
    }
    
}

extension TwoAuthViewController {
    
    func getgidInfo() {
        LoadingConfing.shared.showLoading()
        let dict = ["week": week.value,
                    "gid": "0"]
        let man = NetworkConfigManager()
        let result = man.requsetData(url: "/entertain/wanted", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
}

