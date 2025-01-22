//
//  BaseView.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/21.
//

import UIKit
import RxSwift

class BaseView: UIView {

    let disposing = DisposeBag()

}

class BaseViewCell: UITableView {

    let disposing = DisposeBag()

}

