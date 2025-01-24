//
//  BaseViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/11.
//

import UIKit
import RxSwift
import Combine

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    
}

extension BaseViewController {
    
    func toGuideVc(from type: String, week: String) {
        if type == "familiarf" {
            let oneVc = GuideOneViewController()
            oneVc.week.accept(week)
            self.navigationController?.pushViewController(oneVc, animated: true)
        }else if type == "familiarg" {
            let twoVc = TwoAuthViewController()
            twoVc.week.accept(week)
            self.navigationController?.pushViewController(twoVc, animated: true)
        }
    }
    
    
}
