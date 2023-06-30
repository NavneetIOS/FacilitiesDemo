//
//  FacilitiesViewModel.swift
//  FacilitiesDemo
//
//  Created by MAC-01 on 30/06/23.
//

import Foundation
 
class FacilitiesViewModel {
    
    static let shared = FacilitiesViewModel()
    
    var callBack:(()->())? = nil
    
    private init(){}
    
    func getFacilities(completion:@escaping(FacilitiesModel?,Error?)->Void){
        showUniversalLoadingView(true)
        NetworkManager.shared.dataTask(serviceURL: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db", httpMethod: .get, parameters: nil) { responce, error in
            if let responceData = responce as? [String:Any]{
                DispatchQueue.main.async {
                    showUniversalLoadingView(false)
                }
                    let json = try! JSONSerialization.data(withJSONObject: responceData as Any)
                    let dataModel = try! JSONDecoder().decode(FacilitiesModel.self, from: json)
                    completion(dataModel,nil)
            } else {
                completion(nil,error)
            }
        }
    }
    func disabledFacilityIDs(FacilitiesData : FacilitiesModel?)->[sortedExclusions]{
        var disabledFacilityIDs = [sortedExclusions]()
        for i in 0..<(FacilitiesData?.exclusions?.count ?? 0) {
            var fid : String? = nil
            var Oid : String? = nil
            for ind in 0..<(FacilitiesData?.exclusions?[i].count ?? 0) {
                if ind == 0 {
                    fid = FacilitiesData?.exclusions?[i][ind].facilityID
                    Oid = FacilitiesData?.exclusions?[i][ind].optionsID ?? ""
                } else {
                    disabledFacilityIDs.append(sortedExclusions(onFacility_id: fid ?? "", disableForOptionId: Oid ?? "", options_id: FacilitiesData?.exclusions?[i][ind].optionsID ?? ""))
                }
            }
        }
        return disabledFacilityIDs
    }
}
