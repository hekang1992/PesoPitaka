//
//  GuideOneViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/23.
//

import UIKit
import RxRelay

class GuideOneViewController: BaseViewController {
    
    var week = BehaviorRelay<String>(value: "")
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "loginbgimage")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.namelabel.text = "Identity Verification"
        return headView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(bgImageView)
        view.addSubview(scrollView)
        view.addSubview(headView)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(30)
        }
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
