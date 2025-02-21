//
//  HiveMustView.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/26.
//

import UIKit
import RxRelay
import RxSwift
import TYCyclePagerView

class HiveMustView: BaseView {
    
    var model = BehaviorRelay<BaseModel?>(value: nil)
    
    var block: ((ownModel) -> Void)?
    
    var block1: ((ownModel) -> Void)?
    
    var block2: ((ownModel) -> Void)?

    lazy var cycleMustSignView: TYCyclePagerView = {
        let cycleMustSignView = TYCyclePagerView()
        cycleMustSignView.delegate = self
        cycleMustSignView.dataSource = self
        cycleMustSignView.autoScrollInterval = 2
        cycleMustSignView.isInfiniteLoop = true
        cycleMustSignView.register(HiveMustViewCellCollectionViewCell.self,
                            forCellWithReuseIdentifier: "HiveMustViewCellCollectionViewCell")
        return cycleMustSignView
    }()
    
    lazy var cycleMinSignView: TYCyclePagerView = {
        let cycleMinSignView = TYCyclePagerView()
        cycleMinSignView.delegate = self
        cycleMinSignView.dataSource = self
        cycleMinSignView.autoScrollInterval = 2
        cycleMinSignView.isInfiniteLoop = true
        cycleMinSignView.register(HiveMiniViewCellCollectionViewCell.self,
                            forCellWithReuseIdentifier: "HiveMiniViewCellCollectionViewCell")
        return cycleMinSignView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 60
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.register(HivePeoViewCell.self, forCellReuseIdentifier: "HivePeoViewCell")
        return tableView
    }()
    
    lazy var productBtn: UIButton = {
        let productBtn = UIButton(type: .custom)
        productBtn.setBackgroundImage(UIImage(named: "proiimagsec"), for: .normal)
        productBtn.setTitle("Loan Products", for: .normal)
        productBtn.setTitleColor(.black, for: .normal)
        productBtn.titleLabel?.font = .regularFontOfSize(size: 18)
        return productBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.setDataSource(self).disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HiveMustView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.value?.henceforth.original?.own?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.model.value?.henceforth.original?.own?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HivePeoViewCell", for: indexPath) as! HivePeoViewCell
        cell.model.accept(model)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.addSubview(cycleMustSignView)
        if let model = self.model.value?.henceforth.woke, let count = model.own?.count, count > 0 {
            headView.addSubview(cycleMinSignView)
            cycleMinSignView.snp.makeConstraints { make in
                make.top.equalTo(cycleMustSignView.snp.bottom)
                make.centerX.equalToSuperview()
                make.left.equalToSuperview().offset(12)
                make.height.equalTo(60)
            }
        }else {
            headView.removeFromSuperview()
        }
        headView.addSubview(productBtn)
        cycleMustSignView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(198)
        }
        
        productBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 189, height: 37))
        }
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let model = self.model.value?.henceforth.woke, let count = model.own?.count, count > 0 {
            return 340
        }else {
            return 280
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = self.model.value?.henceforth.original?.own?[indexPath.row] {
            self.block?(model)
        }
        
    }
    
}

extension HiveMustView: TYCyclePagerViewDelegate, TYCyclePagerViewDataSource {
    
    func numberOfItems(in pagerView: TYCyclePagerView) -> Int {
        if pagerView == cycleMustSignView {
            let model = self.model.value?.henceforth.forced?.own ?? []
            return model.count
        }else {
            return 1
        }
    }
    
    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        if pagerView == cycleMustSignView {
            guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "HiveMustViewCellCollectionViewCell", for: index) as? HiveMustViewCellCollectionViewCell else { return UICollectionViewCell() }
            let model = self.model.value?.henceforth.forced?.own?[index]
            cell.mustImgaView.kf.setImage(with: URL(string: model?.host ?? ""), placeholder: UIImage(named: "homeone"))
            return cell
        }else {
            guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "HiveMiniViewCellCollectionViewCell", for: index) as? HiveMiniViewCellCollectionViewCell else { return UICollectionViewCell() }
            let model = self.model.value?.henceforth.woke?.own?[index]
            cell.mlabel.text = model?.washed ?? ""
            return cell
        }
        
    }
    
    func pagerView(_ pageView: TYCyclePagerView, didSelectedItemCell cell: UICollectionViewCell, at index: Int) {
        if pageView == cycleMustSignView {
            if let model = self.model.value?.henceforth.forced?.own?[index] {
                self.block1?(model)
            }
        }else {
            if let model = self.model.value?.henceforth.woke?.own?[index] {
                self.block2?(model)
            }
        }
    }
    
    func layout(for pagerView: TYCyclePagerView) -> TYCyclePagerViewLayout {
        let layout = TYCyclePagerViewLayout()
        if pagerView == cycleMustSignView {
            layout.itemSize = CGSizeMake(375, 198)
            layout.itemSpacing = 2
            return layout
        }else {
            layout.itemSize = CGSizeMake(375, 60)
            layout.itemSpacing = 2
            return layout
        }
    }
}
