//
//  NetworkManager.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/21.
//


import Alamofire
import AppTrackingTransparency

class NetworkManager {
    
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
//                        self.uploidfainfo()
                        break
                    @unknown default:
                        break
                    }
                }
            }
        }
    }
    
//    private func uploidfainfo() {
//        let provider = MoyaProvider<LargeLoanAPI>()
//        let former = GetIdfv.getIDFV()
//        let gathering = GetIdfa.getIDFA()
//        let dict = ["pretense": "av",
//                    "macdownad": "1",
//                    "former": former,
//                    "gathering": gathering]
//        provider.request(.soundsInfo(emptyDict: dict)) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let model = try JSONDecoder().decode(BaseModel.self, from: response.data)
//                    let anyone = model.anyone
//                    if anyone == "0" {
//                        if let faboo = model.exuding.narratedfb {
//                            self.toFabookc(model: faboo)
//                        }
//                    }
//                } catch {
//                    print("JSON: \(error)")
//                }
//                break
//            case .failure(_):
//                break
//            }
//        }
//    }
//    
//    private func toFabookc(model: narratedfbModel) {
//        Settings.shared.appID = model.facebookAppID ?? ""
//        Settings.shared.clientToken = model.facebookClientToke ?? ""
//        Settings.shared.displayName = model.facebookDisplayName ?? ""
//        Settings.shared.appURLSchemeSuffix = model.cFBundleURLScheme ?? ""
//        ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
//    }

}
