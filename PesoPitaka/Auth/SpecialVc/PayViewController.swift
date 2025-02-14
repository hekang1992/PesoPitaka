//
//  PayViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/25.
//

import UIKit
import RxRelay
import TYAlertController

class PayViewController: BaseViewController {
    
    var week = BehaviorRelay<String>(value: "")
    
    var model = BehaviorRelay<BaseModel?>(value: nil)
    
    var modelArray = BehaviorRelay<[bangModel]?>(value: nil)
    
    var authModel = BehaviorRelay<glaredModel?>(value: nil)
    
    var payonetime: String = ""
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "loginbgimage")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.namelabel.text = "Bank Information"
        return headView
    }()
    
    lazy var poImageView: UIImageView = {
        let poImageView = UIImageView()
        poImageView.image = UIImage(named: "lastimagepin")
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
    
    lazy var leftBtn: UIButton = {
        let leftBtn = UIButton(type: .custom)
        leftBtn.isSelected = true
        leftBtn.setImage(UIImage(named: "ewalletimge_nor"), for: .normal)
        leftBtn.setImage(UIImage(named: "ewalletimge_sel"), for: .selected)
        return leftBtn
    }()
    
    lazy var rightBtn: UIButton = {
        let rightBtn = UIButton(type: .custom)
        rightBtn.setImage(UIImage(named: "banknoriamge"), for: .normal)
        rightBtn.setImage(UIImage(named: "bankselimge"), for: .selected)
        return rightBtn
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
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = UIImage(named: "deimgepnc")
        return descImageView
    }()
    
    var since = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        payonetime = DateUtils.getCurrentTimestampInMilliseconds()
        // Do any additional setup after loading the view.
        view.addSubview(bgImageView)
        view.addSubview(headView)
        view.addSubview(poImageView)
        view.addSubview(nextBtn)
        view.addSubview(leftBtn)
        view.addSubview(rightBtn)
        view.addSubview(tableView)
        view.addSubview(descImageView)
        
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
        leftBtn.snp.makeConstraints { make in
            make.top.equalTo(poImageView.snp.bottom).offset(36)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 143, height: 18))
        }
        rightBtn.snp.makeConstraints { make in
            make.top.equalTo(poImageView.snp.bottom).offset(36)
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 143, height: 18))
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(rightBtn.snp.bottom).offset(5)
            make.bottom.equalTo(descImageView.snp.top).offset(-15)
        }
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }).disposed(by: disposeBag)
        
        descImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextBtn.snp.top).offset(-25)
            make.size.equalTo(CGSize(width: 326.5, height: 33))
        }
        
        nextBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        leftBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.since = "1"
            leftBtn.isSelected.toggle()
            rightBtn.isSelected = !leftBtn.isSelected
            self.modelArray.accept(self.model.value?.henceforth.bang?.first?.bang ?? [])
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        rightBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.since = "2"
            rightBtn.isSelected.toggle()
            leftBtn.isSelected = !rightBtn.isSelected
            self.modelArray.accept(self.model.value?.henceforth.bang?.last?.bang ?? [])
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        nextBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let processedData = self.modelArray.value?
                    .compactMap { model -> (String, String)? in
                        guard let key = model.herself else { return nil }
                        let value = (model.went == "familiark") ? model.pitiful ?? "" : model.remember ?? ""
                        return (key, value)
                    }
                    .reduce(into: ["week": week.value]) { dict, tuple in
                        dict[tuple.0] = tuple.1
                    }
                    .reduce(into: ["since": since]) { dict, tuple in
                        dict[tuple.0] = tuple.1
                    }
                blackPink(from: processedData ?? [:])
            })
            .disposed(by: disposeBag)
        
        
        getPayInfo()
    }
    
    private func blackPink(from dict: [String: String]) {
        let man = NetworkConfigManager()
        
        LoadingConfing.shared.showLoading()
        let result = man.requsetData(url: "/entertain/loved", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    eightInfo()
                    self.productDetailInfo(from: week.value)
                }
                ToastConfig.showMessage(form: view, message: model.washed)
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
}

extension PayViewController {
    
    private func getPayInfo() {
        let man = NetworkConfigManager()
        LoadingConfing.shared.showLoading()
        let dict = ["trees": "0", "lemon": "1", "apple": "2"]
        let result = man.getRequest(url: "/entertain/which", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    self.model.accept(model)
                    self.modelArray.accept(model.henceforth.bang?.first?.bang ?? [])
                    self.tableView.reloadData()
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
}

extension PayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.modelArray.value?[indexPath.row]
        let type = model?.went ?? ""
        if type == "familiarl" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OneAuthViewCell", for: indexPath) as! OneAuthViewCell
            let attrString = NSMutableAttributedString(string: model?.knot ?? "", attributes: [
                .foregroundColor: UIColor.init(colorHexStr: "#717171") as Any,
                .font: UIFont.regularFontOfSize(size: 15)
            ])
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
            let pitiful = model?.pitiful ?? ""
            if pitiful.isEmpty {
                cell.nameTx.text = ""
                cell.nameTx.attributedPlaceholder = attrString
            }else {
                cell.nameTx.text = pitiful
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwoAuthViewCell", for: indexPath) as! TwoAuthViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            let remember = model?.remember ?? ""
            let knot = model?.knot ?? ""
            if remember.isEmpty {
                cell.descLabel.text = knot
            }else {
                cell.descLabel.text = remember
            }
            if type == "familiark" {
                if knot.contains("E-") {
                    cell.bgView
                        .rx
                        .tapGesture()
                        .when(.recognized)
                        .subscribe(onNext: { [weak self] _ in
                            self?.authID(for: cell)
                        }).disposed(by: cell.disposeBag)
                }else {
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
                }
            }
            return cell
        }
    }
    
    private func authID(for cell: TwoAuthViewCell) {
        let authView = PayPopView(frame: self.view.bounds)
        guard let model1 = self.model.value?.henceforth.bang?.first?.bang else { return }
        authView.model.accept(model1.first?.glared)
        authView.tableView.reloadData()
        let alertVc = TYAlertController(alert: authView, preferredStyle: .actionSheet)!
        self.present(alertVc, animated: true)
        authView.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
        authView.block = { model in
            cell.descLabel.text = model.hadn ?? ""
            model1.first?.pitiful = model.pitiful
        }
    }
    
}


extension PayViewController {
    
    private func eightInfo() {
        let location = LocationManager()
        var time = DateUtils.getCurrentTimestampInMilliseconds()
        location.getLocationInfo { [weak self] model in
            guard let self = self else { return }
            let dict = ["mom": week.value,
                        "mood": String(model.mood),
                        "reagar": String(model.reagar),
                        "spread": "8",
                        "saving": AwkwardManager.getIDFV(),
                        "why": AwkwardManager.getIDFA(),
                        "teeth": payonetime,
                        "gritted": time]
            let man = NetworkConfigManager()
            let result = man.requsetData(url: "/entertain/answered", parameters: dict, contentType: .multipartFormData).sink(receiveCompletion: { _ in
            }, receiveValue: {  data in
                
            })
            result.store(in: &cancellables)
        }
    }
    
}
