//
//  ServerViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/24.
//

import UIKit
import RxRelay
import ContactsUI

class ServerViewController: BaseViewController {
    
    var week = BehaviorRelay<String>(value: "")
    
    var model = BehaviorRelay<BaseModel?>(value: nil)
    
    var selectCell: ServerTableViewCell?
    
    var index: Int = 0
    
    var grandCore: Bool = false
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "loginbgimage")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.namelabel.text = "Emergency Contact Person"
        return headView
    }()
    
    lazy var poImageView: UIImageView = {
        let poImageView = UIImageView()
        poImageView.image = UIImage(named: "cointecimagepng")
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
        tableView.register(ServerTableViewCell.self, forCellReuseIdentifier: "ServerTableViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var contactPicker: CNContactPickerViewController = {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        return contactPicker
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
        
        nextBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let resultArray = self.model.value?.henceforth.piece?.instantly?.compactMap { $0 }.map { model -> [String: Any] in
                    return [
                        "settle": model.settle ?? "",
                        "hadn": model.hadn ?? "",
                        "particular": model.pitiful ?? "",
                        "helped": model.helped ?? "",
                    ]
                }
                self.additionalSafeAreaInsetsinfo(for: resultArray ?? [])
            }).disposed(by: disposeBag)
        
        getSerceinfo()
    }
    
    private func additionalSafeAreaInsetsinfo(for phoneArray: [[String: Any]]) {
        var string: String = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: phoneArray, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                string = jsonString
            }
        } catch {
            print("Failed to convert phoneArray to JSON: \(error)")
        }
        
        let dict = ["week": week.value, "henceforth": string]
        let man = NetworkConfigManager()
        LoadingConfing.shared.showLoading()
        let result = man.requsetData(url: "/entertain/wonderful", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    self.productDetailInfo(from: week.value)
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
}

extension ServerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.value?.henceforth.piece?.instantly?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServerTableViewCell", for: indexPath) as! ServerTableViewCell
        let model = self.model.value?.henceforth.piece?.instantly?[indexPath.row]
        self.index = indexPath.row
        cell.miLabel.text = model?.liz ?? ""
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.obgView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                let modelArray = model?.northwest ?? []
                let oneArray = PrimaryDataProcessor.processPrimaryData(dataSource: modelArray)
                if let model = model {
                    ShowEnumConfig.showAddressPicker(from: model, targetLabel: cell.descLabel, dataSource: oneArray, pickerMode: .province)
                }
            }).disposed(by: cell.disposeBag)
        
        cell.owbgView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.selectCell = cell
                ContactManager.fetchContacts { [weak self] contacts, error in
                    guard let self = self else { return }
                    if let error = error {
                        print("Failed to fetch contacts: \(error.localizedDescription)")
                        return
                    }
                    guard let contacts = contacts else {
                        print("No contacts found")
                        return
                    }
//                    if let model = model {
//                        self.selectModel = model
//                    }
                    var phoneArray: [[String: Any]] = []
                    self.present(contactPicker, animated: true, completion: nil)
                    for contact in contacts {
                        let fullName = "\(contact.givenName) \(contact.familyName)"
                        let phoneNumbers = contact.phoneNumbers.first?.value.stringValue ?? ""
                        let phone = ["officially": phoneNumbers, "hadn": fullName]
                        phoneArray.append(phone as [String : Any])
                    }
                    if self.grandCore == false {
                        updateFocusIfNeededInfo(from: phoneArray)
                    }
                }
            }).disposed(by: cell.disposeBag)
        return cell
    }
    
}


extension ServerViewController {
    
    private func updateFocusIfNeededInfo(from phoneArray: [[String: Any]]) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: phoneArray, options: [])
            let base64String = jsonData.base64EncodedString()
            print("Base64 Encoded String: \(base64String)")
            let pitiful = 2 + 1
            let dict: [String: String] = [
                "pitiful": "\(pitiful)",
                "late": "1",
                "brings": "0",
                "henceforth": base64String
            ]
            self.pasteAndGoInfo(for: dict)
        } catch {
            print("Failed to serialize phoneArray to JSON: \(error)")
        }
    }
    
    private func pasteAndGoInfo(for dict: [String: String]) {
        let man = NetworkConfigManager()
        let result = man.requsetData(url: "/entertain/about", parameters: dict, contentType: .multipartFormData).sink(receiveCompletion: { _ in
            
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    self.grandCore = true
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    private func getSerceinfo() {
        LoadingConfing.shared.showLoading()
        let dict = ["week": week.value,
                    "gid": "0"]
        let man = NetworkConfigManager()
        let result = man.requsetData(url: "/entertain/others", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
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

extension ServerViewController: CNContactPickerDelegate {
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let fullName = "\(contact.givenName) \(contact.familyName)"
        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
            self.selectCell?.nameLabel.text = "\(fullName)-\(phoneNumber)"
            self.selectCell?.nameLabel.textColor = .black
            let model = self.model.value?.henceforth.piece?.instantly?[index]
            model?.hadn = "\(fullName)"
            model?.settle = "\(phoneNumber)"
        } else {
            
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        
    }
    
}
