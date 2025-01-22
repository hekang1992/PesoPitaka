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
    
    let disposing = DisposeBag()

    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
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
