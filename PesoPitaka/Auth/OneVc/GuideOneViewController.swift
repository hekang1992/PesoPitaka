//
//  GuideOneViewController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/23.
//

import UIKit
import RxRelay
import TYAlertController

class GuideOneViewController: BaseViewController {
    
    var week = BehaviorRelay<String>(value: "")
    
    var model = BehaviorRelay<BaseModel?>(value: nil)
    
    var authModel = BehaviorRelay<instantlyModel?>(value: nil)
    
    var isClickID: String = "0"
    
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
    
    lazy var poImageView: UIImageView = {
        let poImageView = UIImageView()
        poImageView.image = UIImage(named: "processimaged")
        return poImageView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white.withAlphaComponent(0.7)
        whiteView.layer.cornerRadius = 10
        return whiteView
    }()
    
    lazy var oneView: GuideOneView = {
        let oneView = GuideOneView()
        return oneView
    }()
    
    lazy var leftView: GuidePhotoView = {
        let leftView = GuidePhotoView()
        leftView.ctImageView.image = UIImage(named: "fileupload")
        leftView.nameLabel.text = "Upload\nID photo"
        return leftView
    }()
    
    lazy var rightView: GuidePhotoView = {
        let rightView = GuidePhotoView()
        rightView.ctImageView.image = UIImage(named: "facial")
        rightView.nameLabel.text = "Facial\nRecognition"
        return rightView
    }()
    
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.backgroundColor = UIColor.init(colorHexStr: "#6DDEE2")
        nextBtn.setTitle("Next", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = .regularFontOfSize(size: 19)
        nextBtn.layer.cornerRadius = 30
        return nextBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(bgImageView)
        view.addSubview(scrollView)
        view.addSubview(headView)
        view.addSubview(poImageView)
        scrollView.addSubview(whiteView)
        whiteView.addSubview(oneView)
        whiteView.addSubview(leftView)
        whiteView.addSubview(rightView)
        scrollView.addSubview(nextBtn)
        
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
        
        poImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(42)
            make.size.equalTo(CGSize(width: 350, height: 40))
        }
        whiteView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(DeviceMetrics.navigationBarHeight + 120)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(SCREEN_WIDTH - 30)
            make.height.equalTo(508)
        }
        oneView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(69)
        }
        leftView.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 160, height: 140))
        }
        rightView.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 160, height: 140))
        }
        nextBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.top.equalTo(whiteView.snp.bottom)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }).disposed(by: disposeBag)
        
        
        oneView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            self?.authID()
        }).disposed(by: disposeBag)
        
        self.authModel.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            self.isClickID = "1"
            oneView.nameLabel.text = model.hadn ?? ""
            oneView.ctImageView.kf.setImage(with: URL(string: model.probably ?? ""))
        }).disposed(by: disposeBag)
        
        
        leftView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            if self.isClickID == "0" {
                ToastConfig.showMessage(form: view, message: "Please select an authentication method.")
            }else {
                self.popCamera()
            }
        }).disposed(by: disposeBag)
        
        rightView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            ToastConfig.showMessage(form: view, message: "Please complete the previous process first.")
        }).disposed(by: disposeBag)
        
        
        getIDAuthPidInfo()
    }
    
}

extension GuideOneViewController {
    
    private func authID() {
        let authView = AlertAuthIDView(frame: self.view.bounds)
        if let model = self.model.value {
            authView.model.accept(model)
            authView.tableView.reloadData()
        }
        let alertVc = TYAlertController(alert: authView, preferredStyle: .actionSheet)!
        self.present(alertVc, animated: true)
        authView.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
        authView.block = { [weak self] model in
            self?.authModel.accept(model)
        }
    }
    
    private func popCamera() {
        let authView = AlertCameraView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: authView, preferredStyle: .actionSheet)!
        self.present(alertVc, animated: true)
        
        authView.leftBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                CameraPhotoManager.shared.showImagePicker(in: self, sourceType: .photoLibrary) { image in
                    if let image = image {
                        print("Photo selected: \(image)")
                    } else {
                        print("User canceled photo library.")
                    }
                }
            }
        }).disposed(by: disposeBag)
        
        authView.rightBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                CameraPhotoManager.shared.showImagePicker(in: self, sourceType: .camera) { image in
                    if let image = image {
                        print("Photo taken: \(image)")
                    } else {
                        print("User canceled camera.")
                    }
                }
            }
        }).disposed(by: disposeBag)
    }
    
    private func getIDAuthPidInfo() {
        LoadingConfing.shared.showLoading()
        let dict = ["weak": week, "up": "1", "load": "0"] as [String : Any]
        let man = NetworkConfigManager()
        let result = man.getRequest(url: "/entertain/little", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                if herself == "0" || herself == "00" {
                    self.model.accept(model)
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
}
