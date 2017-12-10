//
//  DinnerTableViewCell.swift
//  DinnerWithFriends4.0
//
//  Created by Bart Bronselaer on 10/12/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import UIKit

class DinnerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dinnerPicture: UIImageView!
    
    @IBOutlet weak var dinnerNameLabel: UILabel!
    
    @IBOutlet weak var dinnerFriendsLabel: UILabel!
    
    @IBOutlet weak var dinnerDateLabel: UILabel!
    
    @IBOutlet weak var dinnerViewLabel: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
