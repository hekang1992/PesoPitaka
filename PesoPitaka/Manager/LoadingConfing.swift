//
//  Untitled.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/21.
//

import UIKit
import Toast_Swift

final class LoadingConfing {
    static let shared = LoadingConfing()
    
    private var activityIndicator: UIActivityIndicatorView?
    private var backgroundView: UIView?
    
    private init() {}

    func showLoading() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        if activityIndicator != nil { return }
        backgroundView = UIView(frame: window.bounds)
        backgroundView?.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.color = .black
        activityIndicator?.center = window.center
        if let backgroundView = backgroundView, let activityIndicator = activityIndicator {
            window.addSubview(backgroundView)
            window.addSubview(activityIndicator)
        }
        activityIndicator?.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        backgroundView?.removeFromSuperview()
        activityIndicator = nil
        backgroundView = nil
    }
}

class ToastConfig {
    static func showMessage(form view: UIView, message: String) {
        view.makeToast(message, duration: 2.0, position: .center)
    }
}
