//
//  TableViewController.swift
//  FacilitiesDemo
//
//  Created by MAC-01 on 28/06/23.
//

import UIKit

class TableViewController: UITableViewController {
    
    var FacilitiesData : FacilitiesModel? = nil{
        didSet {
            DispatchQueue.main.async {
                self.disabledFacilityIDs = FacilitiesViewModel.shared.disabledFacilityIDs(FacilitiesData: self.FacilitiesData)
                self.tableView.reloadData()
            }
        }
    }
    var selectedFacilityID : String? = nil
    var disabledFacilityIDs = [sortedExclusions]()
    var disabledOrderID : String? = nil
    var disabledSubOrderID : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        FacilitiesViewModel.shared.getFacilities { FacilitiesData, error in
            if FacilitiesData != nil {
                self.FacilitiesData = FacilitiesData
            } else {
                print("SomethingWentWrong")
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return FacilitiesData?.facilities?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FacilitiesData?.facilities?[section].options?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell

        if let data = FacilitiesData?.facilities?[indexPath.section] {
            if let options = data.options?[indexPath.row]{
                if indexPath.row == 0 {
                    cell.HeadingLabel.isHidden = false
                    cell.HeadingLabel.text = data.name
                } else {
                    cell.HeadingLabel.isHidden = true
                }
                cell.facilitiesImView.image = UIImage(named: options.icon ?? "")
                
                if options.isSelected ?? false {
                    cell.selectionImageView.image = UIImage(systemName: "circle.fill")
                } else {
                    cell.selectionImageView.image = UIImage(systemName: "circle")
                }
                cell.facilitiesLbl.text = options.name
                if options.id == self.disabledOrderID ?? "" || options.id == self.disabledSubOrderID ?? "" {
                    cell.facilitiesLbl.textColor = .placeholderText
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.facilitiesLbl.textColor = .black
                    cell.isUserInteractionEnabled = true
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let data = FacilitiesData?.facilities?[indexPath.section] {
            
            if let options = data.options{
                for i in 0..<options.count {
                    if options[i].isSelected ?? false == false && i == indexPath.row {
                        FacilitiesData?.facilities?[indexPath.section].options?[i].isSelected = true
                        self.selectedFacilityID = FacilitiesData?.facilities?[indexPath.section].facilityID
                        let optionalId = FacilitiesData?.facilities?[indexPath.section].options?[indexPath.row].id ?? ""
                        for i in 0..<(disabledFacilityIDs.count) {
                            if disabledFacilityIDs[i].onFacility_id == selectedFacilityID && optionalId == disabledFacilityIDs[i].disableForOptionId {
                                print("yes i found selectedFacilityID \(selectedFacilityID ?? "")")
                                if self.disabledOrderID != nil {
                                    self.disabledSubOrderID = disabledFacilityIDs[i].options_id
                                } else {
                                    self.disabledOrderID = disabledFacilityIDs[i].options_id
                                }
                                break
                            }
                        }
                    } else {
                        if i == indexPath.row {
                            self.selectedFacilityID = nil
                            self.disabledOrderID = nil
                            self.disabledSubOrderID = nil
                        }
                        FacilitiesData?.facilities?[indexPath.section].options?[i].isSelected = false
                    }
                }
                tableView.reloadData()
            }
        }
    }
}
