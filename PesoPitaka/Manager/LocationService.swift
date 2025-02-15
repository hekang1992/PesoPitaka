//
//  LoactionManager.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/2/9.
//

import UIKit
import CoreLocation
import RxSwift
import RxRelay

class LocationModel {
    var watched: String = ""
    var blame: String = ""
    var improve: String = ""
    var seemed: String = ""
    var reagar: Double = 0.1
    var mood: Double = 0.1
    var expression: String = "minina"
    var flustered: String = "tokyuo"
    var seeing: String = "hot"
}

class LocationManager: NSObject {
    
    var completion: ((LocationModel) -> Void)?
    
    var model = BehaviorRelay<LocationModel?>(value: nil)
    
    let disposeBag = DisposeBag()
    
    var locationMan = CLLocationManager()
    
    override init() {
        super.init()
        locationMan.delegate = self
        locationMan.desiredAccuracy = kCLLocationAccuracyBest
        model.asObservable()
            .debounce(RxTimeInterval.milliseconds(450),
                       scheduler: MainScheduler.instance)
           .subscribe(onNext: { locationModel in
                if let locationModel = locationModel {
                    self.completion?(locationModel)
                }
            }).disposed(by: disposeBag)
        
    }
    
}

extension LocationManager: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationMan.startUpdatingLocation()
        case .denied, .restricted:
            let model = LocationModel()
            self.model.accept(model)
            locationMan.stopUpdatingLocation()
        default:
            break
        }
    }
    
    func getLocationInfo(completion: @escaping (LocationModel) -> Void) {
        self.completion = completion
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let status: CLAuthorizationStatus
            if #available(iOS 14.0, *) {
                status = CLLocationManager().authorizationStatus
            } else {
                status = CLLocationManager.authorizationStatus()
            }
            if status == .notDetermined {
                locationMan.requestAlwaysAuthorization()
                locationMan.requestWhenInUseAuthorization()
            }else if status == .restricted || status == .denied {
                let model = LocationModel()
                self.model.accept(model)
            }else {
                locationMan.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let model = LocationModel()
        model.reagar = location.coordinate.longitude
        model.mood = location.coordinate.latitude
        let geocoder = CLGeocoder()
        let lion = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        geocoder.reverseGeocodeLocation(lion) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let error = error {
                return
            }
            guard let placemark = placemarks?.first else {
                return
            }
            self.onModel(model, with: placemark)
            self.model.accept(model)
            self.locationMan.stopUpdatingLocation()
        }
    }

    private func onModel(_ model: LocationModel, with placemark: CLPlacemark) {
        let countryCode = placemark.isoCountryCode ?? "PHP"
        let country = placemark.country ?? "PHP"
        var provice = placemark.administrativeArea ?? ""
        let city = placemark.locality ?? "Unknown City"
        let street = (placemark.subLocality ?? "") + (placemark.thoroughfare ?? "")
        if provice.isEmpty {
            provice = city
        }
        model.watched = provice
        model.blame = countryCode
        model.improve = country
        model.seemed = street
        model.expression = city
        model.flustered = "tokyuo"
        model.seeing = "peace"
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
}
