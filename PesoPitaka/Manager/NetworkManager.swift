//
//  NetworkManager.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/21.
//


import Alamofire
import AppTrackingTransparency
import Combine
import FBSDKCoreKit

class NetworkManager {
    
    var cancellables = Set<AnyCancellable>()
    
    static let shared = NetworkManager()
    
    private var reachaManager: NetworkReachabilityManager?
    
    private init() {
        self.reachaManager = NetworkReachabilityManager()
    }
    
    func startListening() {
        self.reachaManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                break
            case .reachable(.ethernetOrWiFi):
                self.uvinfo()
                break
            case .reachable(.cellular):
                self.uvinfo()
                break
            case .unknown:
                break
            }
        })
    }
    
    func stopListening() {
        self.reachaManager?.stopListening()
    }
    
    func uvinfo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if #available(iOS 14.0, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .restricted:
                        break
                    case .authorized, .notDetermined, .denied:
                        self.getIDFAInfo()
                        break
                    @unknown default:
                        break
                    }
                }
            }
        }
    }
    
    private func getIDFAInfo() {
        let man = NetworkConfigManager()
        let dict = ["than": AwkwardManager.getIDFV(),
                    "speechless": "1","better":
                        AwkwardManager.getIDFA()]
        let result = man.requsetData(url: "/entertain/illustration", parameters: dict, contentType: .json).sink(receiveCompletion: {_ in 
            
        }, receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let herself = model.herself
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(herself) {
                    if let model = model.henceforth.third {
                        thridToUfc(from: model)
                    }
                }
            } catch  {
                print("JSON: \(error)")
            }
        })
        result.store(in: &cancellables)
    }
    
    private func thridToUfc(from model: thirdModel) {
        Settings.shared.appID = model.coincidentally ?? ""
        Settings.shared.clientToken = model.hands ?? ""
        Settings.shared.displayName = model.passing ?? ""
        Settings.shared.appURLSchemeSuffix = model.met ?? ""
        ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
    }

}
