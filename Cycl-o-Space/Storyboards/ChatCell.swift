//
//  ChatCell.swift
//  Cycl-o-Space
//
//  Created by Kervens Delpe on 11/30/21.
//

import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var profilePhoto: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var newMsgLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
