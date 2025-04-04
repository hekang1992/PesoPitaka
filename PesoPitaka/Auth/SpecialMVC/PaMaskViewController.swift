//
//  PaMaskViewController.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/25.
//

import UIKit
import StoreKit
@preconcurrency import WebKit
import RxRelay

class PaMaskViewController: BaseViewController {
    
    var pageUrl: String = ""
    
    var type = BehaviorRelay<String?>(value: nil)
    
    lazy var webView: WKWebView = {
        let userContentController = WKUserContentController()
        let configuration = WKWebViewConfiguration()
        let scriptNames = ["kiteGelat",
                           "turnipIgY",
                           "limeBellp",
                           "airplaneT",
                           "zucchiniL",
                           "ravioliMa"]
        scriptNames.forEach { userContentController.add(self, name: $0) }
        configuration.userContentController = userContentController
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.scrollViewInfoApple {
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.contentInsetAdjustmentBehavior = .never
            $0.bounces = false
            $0.alwaysBounceVertical = false
        }
        webView.navigationDelegate = self
        return webView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "loginbgimage")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.namelabel.text = "Order Information"
        return headView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(bgImageView)
        view.addSubview(headView)
        view.addSubview(webView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(30)
        }
        webView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(1)
            make.left.right.bottom.equalToSuperview()
        }
        
        self.headView.backBtn
            .rx
            .tap
            .subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if self.webView.canGoBack {
                self.webView.goBack()
            }else {
                if let type = self.type.value {
                    if type == "pay" {
                        self.navigationController?.popToRootViewController(animated: true)
                    }else {
                        if let navigationController = self.navigationController {
                            JudgePushVc.popVc(ofClass: GuideViewController.self, in: navigationController)
                        }
                    }
                }
            }
        }).disposed(by: disposeBag)
        
        if let url = URL(string: pageUrl) {
            webView.load(URLRequest(url: url))
        }
        
        webView.rx.observe(String.self, "title")
            .subscribe(onNext: { [weak self] title in
                DispatchQueue.main.async {
                    self?.headView.namelabel.text = title ?? ""
                }
            }).disposed(by: disposeBag)
        
    }
    
}

extension PaMaskViewController: WKScriptMessageHandler,
                                WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        LoadingConfing.shared.showLoading()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        LoadingConfing.shared.hideLoading()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        LoadingConfing.shared.hideLoading()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let messageName = message.name
        print("message:\(message.name)")
        if messageName == "turnipIgY" {
            let body = message.body as? [String]
            let week = body?.first ?? ""
            tenInfo(from: week)
        }else if messageName == "limeBellp" || messageName == "airplaneT" {
            self.navigationController?.popToRootViewController(animated: true)
        }else if messageName == "ravioliMa" {
            DispatchQueue.main.async {
                self.requestAppReview()
            }
        }else if messageName == "zucchiniL" {
            handleMessageBody(message.body)
        }else if messageName == "kiteGelat" {
//            app://ios.pitaka.peso/fennelCapers?week=2
            let messageBody = message.body
            guard let url = messageBody as? String else { return }
            if url.contains("ugliMisoJack") {
                loginSuccessPush.toRootVc()
            } else if url.contains("fennelCapers") {
                guard let gourl = URL(string: url) else { return }
                if let week = weekUrlStr(url: gourl) {
                    self.productDetailInfo(from: week)
                }
            }
        }
    }
    
    func handleMessageBody(_ messageBody: Any) {
        guard let url = messageBody as? String else { return }
        if url.contains("email:"), let range = url.range(of: ":") {
            let email = String(url[range.upperBound...])
            let phoneStr = UserDefaultsManager.getValue(forKey: .loginPhone) as? String ?? ""
            let bodyContent = "Peso Pitaka: \(phoneStr)"
            let mailtoURLString = "mailto:\(email)?body=\(bodyContent.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
            if let mailtoURL = URL(string: mailtoURLString), UIApplication.shared.canOpenURL(mailtoURL) {
                UIApplication.shared.open(mailtoURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func requestAppReview() {
        if #available(iOS 14.0, *), let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}

extension PaMaskViewController {
    
    private func tenInfo(from week: String) {
        let location = LocationManager()
        let time = DateUtils.getCurrentTimestampInMilliseconds()
        location.getLocationInfo { [weak self] model in
            guard let self = self else { return }
            let dict = ["mom": week,
                        "mood": String(model.mood),
                        "reagar": String(model.reagar),
                        "spread": "10",
                        "saving": AwkwardManager.getIDFV(),
                        "why": AwkwardManager.getIDFA(),
                        "teeth": time,
                        "gritted": time]
            let man = NetworkConfigManager()
            let result = man.requsetData(url: "/entertain/answered",
                                         parameters: dict,
                                         contentType: .multipartFormData)
                .sink(receiveCompletion: { _ in
            }, receiveValue: {  data in
                
            })
            result.store(in: &cancellables)
        }
    }
    
}


extension UIScrollView {
    func scrollViewInfoApple(_ configuration: (UIScrollView) -> Void) {
        configuration(self)
    }
}

