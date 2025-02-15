//
//  GuideOneViewController.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/23.
//

import UIKit
import RxRelay
import TYAlertController
import BRPickerView

class GuideOneViewController: BaseViewController {
    
    var week = BehaviorRelay<String>(value: "")
    
    var model = BehaviorRelay<BaseModel?>(value: nil)
    
    var authModel = BehaviorRelay<instantlyModel?>(value: nil)
    
    var since: String = ""
    
    var built: Int = 0
    
    //3
    var photoonetime = ""
    var phototwitime = ""
    
    //4
    var faceonetime = ""
    var facetwitime = ""
    
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
        leftView.mustImageView.image = UIImage(named: "fileupload")
        leftView.nameLabel.text = "Upload\nID photo"
        return leftView
    }()
    
    lazy var rightView: GuidePhotoView = {
        let rightView = GuidePhotoView()
        rightView.mustImageView.image = UIImage(named: "facial")
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
            self.since = model.hadn ?? ""
            oneView.nameLabel.text = model.hadn ?? ""
            oneView.mustImageView.kf.setImage(with: URL(string: model.probably ?? ""))
        }).disposed(by: disposeBag)
        
        leftView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            photoonetime = DateUtils.getCurrentTimestampInMilliseconds()
            if self.since.isEmpty {
                ToastConfig.showMessage(form: view, message: "Please select an authentication method.")
            }else {
                self.popCamera()
            }
        }).disposed(by: disposeBag)
        
        rightView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            faceonetime = DateUtils.getCurrentTimestampInMilliseconds()
            if self.built == 1 {
                CameraPhotoManager.shared.showImagePicker(in: self, sourceType: .camera) { [weak self] image in
                    if let image = image {
                        self?.toServiceImage(from: "10", image: image)
                    } else {
                        print("User canceled camera.")
                    }
                }
            }else {
                ToastConfig.showMessage(form: view, message: "Please complete the previous process first.")
            }
        }).disposed(by: disposeBag)
        
        nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.productDetailInfo(from: week.value)
        }).disposed(by: disposeBag)
        
        
        getIDAuthPidInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getServiceInfo {
            
        }
    }
    
    private func getServiceInfo(complete: @escaping (() -> Void)) {
        LoadingConfing.shared.showLoading()
        let dict = ["week": week.value,
                    "bloodshot": "0"]
        let man = NetworkConfigManager()
        let result = man.getRequest(url: "/entertain/smile", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    complete()
                    if let standing = model.henceforth.standing, standing == 1 {
                        self.rightView.isUserInteractionEnabled = false
                        self.rightView.placeImageView.isHidden = false
                        self.rightView.placeImageView.kf.setImage(with: URL(string: model.henceforth.residing ?? ""))
                    }else {
                        self.rightView.isUserInteractionEnabled = true
                        self.rightView.placeImageView.isHidden = true
                    }
                    if let model = model.henceforth.came {
                        if let built = model.built, built == 1 {
                            self.built = built
                            self.leftView.isUserInteractionEnabled = false
                            self.leftView.placeImageView.isHidden = false
                            self.leftView.placeImageView.kf.setImage(with: URL(string: model.residing ?? ""))
                            self.oneView.nameLabel.text = model.since ?? ""
                        }else {
                            self.leftView.isUserInteractionEnabled = true
                            self.leftView.placeImageView.isHidden = true
                        }
                    }
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
}

extension GuideOneViewController {
    
    private func authID() {
        let onetime = DateUtils.getCurrentTimestampInMilliseconds()
        let authView = AlertAuthIDView(frame: self.view.bounds)
        if let model = self.model.value {
            authView.model.accept(model)
            authView.tableView.reloadData()
        }
        let alertVc = TYAlertController(alert: authView, preferredStyle: .actionSheet)!
        self.present(alertVc, animated: true)
        authView.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                self.twoInfo(from: onetime, twotime: DateUtils.getCurrentTimestampInMilliseconds())
            }
        }).disposed(by: disposeBag)
        authView.block = { [weak self] model in
            self?.authModel.accept(model)
        }
    }
    
    private func twoInfo(from onetime: String, twotime: String) {
        let location = LocationManager()
        location.getLocationInfo { [weak self] model in
            guard let self = self else { return }
            let dict = ["mom": week.value,
                        "mood": String(model.mood),
                        "reagar": String(model.reagar),
                        "spread": "2",
                        "saving": AwkwardManager.getIDFV(),
                        "why": AwkwardManager.getIDFA(),
                        "teeth": onetime,
                        "gritted": twotime]
            let man = NetworkConfigManager()
            let result = man.requsetData(url: "/entertain/answered", parameters: dict, contentType: .multipartFormData).sink(receiveCompletion: { _ in
            }, receiveValue: {  data in
                
            })
            result.store(in: &cancellables)
        }
    }
    
    private func popCamera() {
        let authView = AlertCameraView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: authView, preferredStyle: .actionSheet)!
        authView.iconImageView.kf.setImage(with: URL(string: self.authModel.value?.probably ?? ""))
        self.present(alertVc, animated: true)
        
        //photo
        authView.leftBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                CameraPhotoManager.shared.showImagePicker(in: self, sourceType: .photoLibrary) { [weak self] image in
                    if let image = image {
                        self?.toServiceImage(from: "11", image: image, since: self?.since)
                    } else {
                        print("User canceled photo library.")
                    }
                }
            }
        }).disposed(by: disposeBag)
        
        //camera
        authView.rightBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                CameraPhotoManager.shared.showImagePicker(in: self, sourceType: .camera) { [weak self] image in
                    if let image = image {
                        self?.toServiceImage(from: "11", image: image)
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
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    self.model.accept(model)
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    private func toServiceImage(from pitiful: String, image: UIImage, since: String? = "") {
        LoadingConfing.shared.showLoading()
        let man = NetworkConfigManager()
        let illuminated = 0 + 1
        let dict = ["week": week.value,
                    "illuminated": "\(illuminated)",
                    "since": since ?? "",
                    "pitiful": pitiful,
                    "things": "",
                    "hear": "1"] as [String : String]
        let imageData = Data.compressImage(image: image)!
        let result = man.uploadImage(url: "/entertain/cheerfully", imageData: imageData, parameters: dict, contentType: .multipartFormData).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    if pitiful == "11" {
                        self.popModel(from: model.henceforth)
                    }else {
                        self.fourInfo()
                        self.getServiceInfo { [weak self] in
                            guard let self = self else { return }
                            productDetailInfo(from: week.value)
                        }
                    }
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
}

extension GuideOneViewController {
    
    private func popModel(from model: henceforthModel) {
        let authView = AlertSuccessNameView(frame: self.view.bounds)
        authView.oneView.nameTx.text = model.name ?? ""
        authView.twoView.nameTx.text = model.idnumber ?? ""
        authView.threeView.nameLabel.text = model.secretly ?? ""
        authView.threeView.nameLabel.textColor = .black
        let alertVc = TYAlertController(alert: authView, preferredStyle: .actionSheet)!
        self.present(alertVc, animated: true)
        authView
            .threeView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.setUpTime(for: authView.threeView.nameLabel)
            }).disposed(by: disposeBag)
        
        authView.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.babyInfo(from: authView)
        }).disposed(by: disposeBag)
        
    }
    
    private func setUpTime(for label: UILabel) {
        guard let dateComponents = extractDateComponents(from: label.text) else { return }
        let datePickerView = createDatePickerView(with: dateComponents)
        datePickerView.resultBlock = { [weak self] selectedDate, selectedValue in
            guard let self = self, let selectedValue = selectedValue else { return }
            updateTextField(label, with: selectedValue)
        }
        datePickerView.pickerStyle = DatePickerColorConfig.defaultStyle()
        datePickerView.show()
    }
    
    private func extractDateComponents(from text: String?) -> (day: Int, month: Int, year: Int)? {
        let defaultDate = "01-01-1900"
        let timeStr = text ?? defaultDate
        let timeArray = timeStr.components(separatedBy: "-")
        guard timeArray.count == 3,
              let day = Int(timeArray[0]),
              let month = Int(timeArray[1]),
              let year = Int(timeArray[2]) else {
            return nil
        }
        
        return (day, month, year)
    }
    
    private func createDatePickerView(with dateComponents: (day: Int, month: Int, year: Int)) -> BRDatePickerView {
        let datePickerView = BRDatePickerView()
        datePickerView.pickerMode = .YMD
        datePickerView.title = "Date"
        datePickerView.minDate = NSDate.br_setYear(1900, month: 01, day: 01)
        datePickerView.selectDate = NSDate.br_setYear(dateComponents.year, month: dateComponents.month, day: dateComponents.day)
        datePickerView.maxDate = Date()
        return datePickerView
    }
    
    private func updateTextField(_ label: UILabel, with selectedValue: String) {
        let selectedArray = selectedValue.components(separatedBy: "-")
        guard selectedArray.count == 3 else { return }
        let selectedDay = selectedArray[2]
        let selectedMonth = selectedArray[1]
        let selectedYear = selectedArray[0]
        let formattedDate = String(format: "%@-%@-%@", selectedDay, selectedMonth, selectedYear)
        label.text = formattedDate
    }
    
    private func babyInfo(from authView: AlertSuccessNameView) {
        LoadingConfing.shared.showLoading()
        let pitiful = 8 + 3
        let man = NetworkConfigManager()
        let since = self.oneView.nameLabel.text ?? ""
        let dict = ["secretly": authView.threeView.nameLabel.text ?? "",
                    "protecting": authView.twoView.nameTx.text ?? "",
                    "hadn": authView.oneView.nameTx.text ?? "",
                    "pitiful": "\(pitiful)",
                    "since": since,
                    "slammed": "1"]
        let result = man.requsetData(url: "/entertain/gotten", parameters: dict, contentType: .json).sink(receiveCompletion: { _ in
            LoadingConfing.shared.hideLoading()
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    self.dismiss(animated: true) {
                        self.getServiceInfo {}
                        //mai === 3
                        self.threeInfo()
                    }
                }
                ToastConfig.showMessage(form: authView, message: model.washed)
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
}

extension GuideOneViewController {
    
    private func threeInfo() {
        let location = LocationManager()
        let time = DateUtils.getCurrentTimestampInMilliseconds()
        location.getLocationInfo { [weak self] model in
            guard let self = self else { return }
            let dict = ["mom": week.value,
                        "mood": String(model.mood),
                        "reagar": String(model.reagar),
                        "spread": "3",
                        "saving": AwkwardManager.getIDFV(),
                        "why": AwkwardManager.getIDFA(),
                        "teeth": photoonetime,
                        "gritted": time]
            let man = NetworkConfigManager()
            let result = man.requsetData(url: "/entertain/answered", parameters: dict, contentType: .multipartFormData).sink(receiveCompletion: { _ in
            }, receiveValue: {  data in
                
            })
            result.store(in: &cancellables)
        }
    }
    
    private func fourInfo() {
        let location = LocationManager()
        var time = DateUtils.getCurrentTimestampInMilliseconds()
        location.getLocationInfo { [weak self] model in
            guard let self = self else { return }
            let dict = ["mom": week.value,
                        "mood": String(model.mood),
                        "reagar": String(model.reagar),
                        "spread": "4",
                        "saving": AwkwardManager.getIDFV(),
                        "why": AwkwardManager.getIDFA(),
                        "teeth": faceonetime,
                        "gritted": time]
            let man = NetworkConfigManager()
            let result = man.requsetData(url: "/entertain/answered", parameters: dict, contentType: .multipartFormData).sink(receiveCompletion: { _ in
            }, receiveValue: {  data in
                
            })
            result.store(in: &cancellables)
        }
    }
    
}


extension Data {
    
    static func compressImage(image: UIImage, compressionQuality: CGFloat = 0.8) -> Data? {
        guard let compressedData = image.jpegData(compressionQuality: compressionQuality) else {
            return nil
        }
        if compressedData.count <= 1_200_000 {
            return compressedData
        }
        if compressionQuality <= 0.1 {
            return compressedData
        }
        return compressImage(image: image,
                             compressionQuality:
                                compressionQuality - 0.1)
    }
    
}

class DatePickerColorConfig {
    static func defaultStyle() -> BRPickerStyle {
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = .white
        customStyle.pickerTextFont = .regularFontOfSize(size: 16)
        customStyle.selectRowTextColor = .black
        return customStyle
    }
    
}
