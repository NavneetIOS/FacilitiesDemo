//
//  TableViewCell.swift
//  FacilitiesDemo
//
//  Created by MAC-01 on 28/06/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var facilitiesImView: UIImageView!
    @IBOutlet weak var facilitiesLbl: UILabel!
    @IBOutlet weak var selectionImageView: UIImageView!
    @IBOutlet weak var HeadingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
