//
//  BaseView.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/21.
//

import UIKit
import RxSwift

class BaseView: UIView {
    
    let disposeBag = DisposeBag()
    
}

class BaseViewCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
}

