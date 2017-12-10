//
//  DinnerItemTableViewCell.swift
//  DinnerWithFriends4.0
//
//  Created by Bart Bronselaer on 10/12/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import UIKit

class DinnerItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemPicture: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemUrlLabel: UILabel!
    @IBOutlet weak var itemRatingLabel: UILabel!
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var itemDetailButton: UIButton!
    
    weak var delegate: DinnerItemTableViewCellDelegate?
    
    @IBAction func detailTapped(_ sender: UIButton) {
        // call the tableViewCellDidTapDetail method on the delegate
        delegate?.tableViewCellDidTapDetail(self)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
