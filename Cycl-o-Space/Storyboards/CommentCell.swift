//
//  CommentCell.swift
//  Cycl-o-Space
//
//  Created by Kervens Delpe on 11/29/21.
//

import UIKit

class CommentCell: UITableViewCell {
    
    
    @IBOutlet weak var currentUsername: UILabel!
    
    
    @IBOutlet weak var currentUserPhoto: UIImageView!
    
    
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
