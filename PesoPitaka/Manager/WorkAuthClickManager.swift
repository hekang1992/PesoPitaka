//
//  WorkAuthClickManager.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/25.
//

import UIKit
import BRPickerView

class PrimaryDataProcessor {
    static func processPrimaryData(dataSource: [Any]) -> [BRProvinceModel] {
        var regions = [BRProvinceModel]()
        for dataItem in dataSource {
            guard let regionData = dataItem as? glaredModel else {
                continue
            }
            let region = BRProvinceModel()
            region.code = String(regionData.pitiful)
            region.name = regionData.hadn ?? ""
            region.index = dataSource.firstIndex(where: { $0 as AnyObject === regionData as AnyObject }) ?? 0
            regions.append(region)
        }
        return regions
    }
}

class TertiaryDataProcessor {
    static func processTertiaryData(dataSource: [Any]) -> [BRProvinceModel] {
        var processedRegions = [BRProvinceModel]()
        for dataItem in dataSource {
            guard let regionData = dataItem as? instantlyModel else {
                continue
            }
            let region = BRProvinceModel()
            region.code = String(regionData.aware ?? 0)
            region.name = regionData.hadn ?? ""
            region.index = dataSource.firstIndex(where: { $0 as AnyObject === regionData as AnyObject }) ?? 0
            
            let citiesData = regionData.instantly ?? []
            var processedCities = [BRCityModel]()
            for cityData in citiesData {
                let city = BRCityModel()
                city.code = String(regionData.aware ?? 0)
                city.name = cityData.hadn
                city.index = citiesData.firstIndex(where: { $0 as AnyObject === cityData as AnyObject }) ?? 0
                
                let areasData = cityData.instantly ?? []
                var processedAreas = [BRAreaModel]()
                for areaData in areasData {
                    let area = BRAreaModel()
                    area.code = String(regionData.aware ?? 0)
                    area.name = areaData.hadn
                    area.index = areasData.firstIndex(where: { $0 as AnyObject === areaData as AnyObject }) ?? 0
                    processedAreas.append(area)
                }
                city.arealist = processedAreas
                processedCities.append(city)
            }
            region.citylist = processedCities
            processedRegions.append(region)
        }
        return processedRegions
    }
}

class ShowEnumConfig {
    static func showAddressPicker(
        from baseModel: bangModel,
        targetLabel: UILabel,
        dataSource: [BRProvinceModel],
        pickerMode: BRAddressPickerMode
    ) {
        let addressPicker = BRAddressPickerView()
        addressPicker.title = baseModel.knot ?? ""
        addressPicker.pickerMode = pickerMode
        addressPicker.dataSourceArr = dataSource
        addressPicker.selectIndexs = [0, 0, 0]
        addressPicker.resultBlock = { province, city, area in
            let (address, code) = generateAddressAndCode(province: province, city: city, area: area)
            baseModel.remember = address
            baseModel.pitiful = code
            targetLabel.text = address
            targetLabel.textColor = .black
        }
        addressPicker.pickerStyle = DatePickerColorConfig.defaultStyle()
        addressPicker.show()
    }
    
    private static func generateAddressAndCode(province: BRProvinceModel?,
                                               city: BRCityModel?,
                                               area: BRAreaModel?) -> (String, String) {
        let oneName = province?.name ?? ""
        let twoName = city?.name ?? ""
        let threeName = area?.name ?? ""
        let name: String
        let code: String
        switch (oneName.isEmpty, twoName.isEmpty, threeName.isEmpty) {
        case (false, true, _):
            name = oneName
            code = province?.code ?? ""
        case (false, false, true):
            let nameStr = "\(oneName)" + "|" + "\(twoName)"
            name = nameStr
            let codeStr = "\(province?.code ?? "")" + "|" + "\(city?.code ?? "")"
            code = codeStr
        case (false, false, false):
            name = "\(oneName)|\(twoName)|\(threeName)"
            code = "\(province?.code ?? "")|\(city?.code ?? "")|\(area?.code ?? "")"
        default:
            name = ""
            code = ""
        }
        return (name, code)
    }
    
    
}
