//
//  OrdersViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/21.
//

import UIKit

class OrdersViewController: BaseViewController {
    
    lazy var orView: OrderView = {
        let orView = OrderView()
        return orView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(orView)
        orView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
