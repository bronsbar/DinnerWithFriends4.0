//
//  DinnerItemTableViewCellDelegate.swift
//  DinnerWithFriends4.0
//
//  Created by Bart Bronselaer on 10/12/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import Foundation

// protocol 
protocol DinnerItemTableViewCellDelegate: class {
    func tableViewCellDidTapDetail (_ sender: DinnerItemTableViewCell)
}
