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
        setupBackgroundView(in: window)
        setupActivityIndicator(in: window)
        activityIndicator?.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            self.hideLoading()
        }
    }
    
    func hideLoading() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        backgroundView?.removeFromSuperview()
        activityIndicator = nil
        backgroundView = nil
    }
    
    private func setupBackgroundView(in window: UIWindow) {
        backgroundView = UIView(frame: window.bounds)
        backgroundView?.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        if let backgroundView = backgroundView {
            window.addSubview(backgroundView)
        }
    }
    
    private func setupActivityIndicator(in window: UIWindow) {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.color = .black
        activityIndicator?.center = window.center
        if let activityIndicator = activityIndicator {
            window.addSubview(activityIndicator)
        }
    }
}

class ToastConfig {
    static func showMessage(form view: UIView, message: String) {
        view.makeToast(message, duration: 2.0, position: .center)
    }
}
