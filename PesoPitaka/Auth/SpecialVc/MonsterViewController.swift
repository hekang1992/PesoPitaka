//
//  MonsterViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/24.
//

import UIKit
import RxRelay

class MonsterViewController: BaseViewController {
    
    var week = BehaviorRelay<String>(value: "")
    
    var model = BehaviorRelay<BaseModel?>(value: nil)
    
    var onePageUrl = ""
    
    var twoPageUrl = ""
    
    var titleStr: String = ""
    
    var imageStr = ""
    
    var monetime = ""
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "loginbgimage")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.namelabel.text = titleStr
        return headView
    }()
    
    lazy var poImageView: UIImageView = {
        let poImageView = UIImageView()
        poImageView.image = UIImage(named: imageStr)
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
        tableView.register(OneAuthViewCell.self, forCellReuseIdentifier: "OneAuthViewCell")
        tableView.register(TwoAuthViewCell.self, forCellReuseIdentifier: "TwoAuthViewCell")
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
        monetime = DateUtils.getCurrentTimestampInMilliseconds()
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
        
        nextBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let processedData = self.model.value?.henceforth.bang?
                    .compactMap { model -> (String, String)? in
                        guard let key = model.herself else { return nil }
                        let value = (model.went == "familiark") ? model.pitiful ?? "" : model.remember ?? ""
                        return (key, value)
                    }
                    .reduce(into: ["week": week.value]) { dict, tuple in
                        dict[tuple.0] = tuple.1
                    }
                blackPink(from: processedData ?? [:])
            })
            .disposed(by: disposeBag)
    }
    
    private func blackPink(from dict: [String: String]) {
        let man = NetworkConfigManager()
        LoadingConfing.shared.showLoading()
        let result = man.requsetData(url: onePageUrl, parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    if imageStr == "swconeimage" {
                        fiveInfo()
                    }else {
                        sixInfo()
                    }
                    productDetailInfo(from: week.value)
                }else {
                    ToastConfig.showMessage(form: view, message: model.washed)
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
}

extension MonsterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.model.value?.henceforth.bang?.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.model.value?.henceforth.bang?[indexPath.row]
        let type = model?.went ?? ""
        if type == "familiarl" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OneAuthViewCell", for: indexPath) as! OneAuthViewCell
            let attrString = NSMutableAttributedString(string: model?.knot ?? "", attributes: [
                .foregroundColor: UIColor.init(colorHexStr: "#717171") as Any,
                .font: UIFont.regularFontOfSize(size: 15)
            ])
            cell.nameTx.attributedPlaceholder = attrString
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.nameTx
                .rx
                .controlEvent(.editingChanged)
                .withLatestFrom(cell.nameTx.rx.text.orEmpty)
                .subscribe(onNext: { text in
                    cell.nameTx.text = String(text)
                    model?.remember = text
            }).disposed(by: cell.disposeBag)
            if model?.fiercely == 1 {
                cell.nameTx.keyboardType = .numberPad
            }else {
                cell.nameTx.keyboardType = .default
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwoAuthViewCell", for: indexPath) as! TwoAuthViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            let remember = model?.remember ?? ""
            if remember.isEmpty {
                cell.descLabel.text = model?.knot ?? ""
            }else {
                cell.descLabel.text = remember
            }
            if type == "familiark" {
                cell.bgView
                    .rx
                    .tapGesture()
                    .when(.recognized)
                    .subscribe(onNext: { _ in
                        let modelArray = model?.glared ?? []
                        let oneArray = PrimaryDataProcessor.processPrimaryData(dataSource: modelArray)
                        if let model = model {
                            ShowEnumConfig.showAddressPicker(from: model, targetLabel: cell.descLabel, dataSource: oneArray, pickerMode: .province)
                        }
                    }).disposed(by: cell.disposeBag)
            }else {
                cell.bgView
                    .rx
                    .tapGesture()
                    .when(.recognized)
                    .subscribe(onNext: {  _ in
                        let modelArray = ServerDataManager.shared.getData()
                        let oneArray = TertiaryDataProcessor.processTertiaryData(dataSource: modelArray)
                        if let model = model {
                            ShowEnumConfig.showAddressPicker(from: model, targetLabel: cell.descLabel, dataSource: oneArray, pickerMode: .area)
                        }
                    }).disposed(by: cell.disposeBag)
            }
            return cell
        }
    }
    
}

extension MonsterViewController {
    
    func getgidInfo() {
        LoadingConfing.shared.showLoading()
        let dict = ["week": week.value,
                    "gid": "0"]
        let man = NetworkConfigManager()
        let result = man.requsetData(url: twoPageUrl, parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    self.model.accept(model)
                    self.tableView.reloadData()
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
}


extension MonsterViewController {
    
    private func fiveInfo() {
        var time = DateUtils.getCurrentTimestampInMilliseconds()
        let location = LocationManager()
        location.getLocationInfo { [weak self] model in
            guard let self = self else { return }
            let dict = ["mom": week.value,
                        "mood": model.mood,
                        "reagar": model.reagar,
                        "spread": "5",
                        "saving": AwkwardManager.getIDFV(),
                        "why": AwkwardManager.getIDFA(),
                        "teeth": monetime,
                        "gritted": time]
            let man = NetworkConfigManager()
            let result = man.postRequest(url: "/entertain/answered", parameters: dict as [String : Any], contentType: .json).sink(receiveCompletion: { _ in
            }, receiveValue: {  data in
                
            })
            result.store(in: &cancellables)
        }
    }
    
    private func sixInfo() {
        var time = DateUtils.getCurrentTimestampInMilliseconds()
        let location = LocationManager()
        location.getLocationInfo { [weak self] model in
            guard let self = self else { return }
            let dict = ["mom": week.value,
                        "mood": model.mood,
                        "reagar": model.reagar,
                        "spread": "6",
                        "saving": AwkwardManager.getIDFV(),
                        "why": AwkwardManager.getIDFA(),
                        "teeth": monetime,
                        "gritted": time]
            let man = NetworkConfigManager()
            let result = man.postRequest(url: "/entertain/answered", parameters: dict as [String : Any], contentType: .json).sink(receiveCompletion: { _ in
            }, receiveValue: {  data in
                
            })
            result.store(in: &cancellables)
        }
    }
    
}
