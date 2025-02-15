//
//  HomeZeroView.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/22.
//

import UIKit

class HomeZeroView: BaseView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "homeone")
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "hometwo")
        return twoImageView
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "homethree")
        return threeImageView
    }()
    
    lazy var fourImageView: UIImageView = {
        let fourImageView = UIImageView()
        fourImageView.image = UIImage(named: "homefour")
        return fourImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(oneImageView)
        scrollView.addSubview(twoImageView)
        scrollView.addSubview(threeImageView)
        scrollView.addSubview(fourImageView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(198)
            make.width.equalTo(SCREEN_WIDTH)
        }
        twoImageView.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH, height: 62))
        }
        threeImageView.snp.makeConstraints { make in
            make.top.equalTo(twoImageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH, height: 391))
        }
        fourImageView.snp.makeConstraints { make in
            make.top.equalTo(threeImageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH, height: 175))
            make.bottom.equalToSuperview().offset(-DeviceMetrics.tabBarHeight)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
