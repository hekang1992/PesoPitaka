//
//  AlertAuthIDView.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/24.
//

import UIKit
import RxRelay
import Kingfisher

class AlertAuthIDView: BaseView {
    
    private var selectedIndexPath: IndexPath?
    
    var model = BehaviorRelay<BaseModel?>(value: nil)
    
    var block: ((instantlyModel) -> Void)?
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "camcebtimage"), for: .normal)
        return cancelBtn
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "poseimage")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.backgroundColor = UIColor.init(colorHexStr: "#6DDEE2")
        nextBtn.setTitle("OK", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = .regularFontOfSize(size: 19)
        nextBtn.layer.cornerRadius = 30
        return nextBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(AlertAuthIDViewCell.self, forCellReuseIdentifier: "AlertAuthIDViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UIUtils.createLabel(font: UIFont.regularFontOfSize(size: 19), textColor: .init(colorHexStr: "#FFFFFF")!, textAlignment: .center)
        nameLabel.text = "Select ID"
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(cancelBtn)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(tableView)
        bgImageView.addSubview(nextBtn)
        bgImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375, height: 574))
        }
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(45)
            make.left.equalToSuperview().offset(3)
            make.height.equalTo(430)
        }
        nextBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.top.equalTo(tableView.snp.bottom).offset(15)
        }
        cancelBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(bgImageView.snp.top)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(9)
            make.height.equalTo(23)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AlertAuthIDView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.value?.henceforth.instantly?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlertAuthIDViewCell", for: indexPath) as! AlertAuthIDViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        let model = self.model.value?.henceforth.instantly?[indexPath.row]
        cell.nameLabel.text = model?.hadn ?? ""
        cell.mustImageView.kf.setImage(with: URL(string: model?.probably ?? ""))
        if indexPath == selectedIndexPath {
            cell.bgView.layer.borderWidth = 2
            cell.bgView.layer.borderColor = UIColor(colorHexStr: "#5FE979")?.withAlphaComponent(0.8).cgColor
        } else {
            cell.bgView.layer.borderWidth = 0
            cell.bgView.layer.borderColor = UIColor.clear.cgColor
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for cell in tableView.visibleCells {
            if let alertCell = cell as? AlertAuthIDViewCell {
                alertCell.bgView.layer.borderWidth = 0
                alertCell.bgView.layer.borderColor = UIColor.clear.cgColor
            }
        }
        if let cell = tableView.cellForRow(at: indexPath) as? AlertAuthIDViewCell {
            cell.bgView.layer.borderWidth = 2
            cell.bgView.layer.borderColor = UIColor(colorHexStr: "#5FE979")?.withAlphaComponent(0.8).cgColor
        }
        selectedIndexPath = indexPath
        if let model = self.model.value?.henceforth.instantly?[indexPath.row] {
            self.block?(model)
        }
    }
    
}
