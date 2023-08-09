//
//  CelebrityTableViewCell.swift
//  appCelebrities
//
//  Created by DavidEmanuel on 7/10/23.
//

import UIKit

class CelebrityTableViewCell: UITableViewCell {

    @IBOutlet weak var stackAll: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
   
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
