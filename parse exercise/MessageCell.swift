//
//  MessageCell.swift
//  parse exercise
//
//  Created by Scott Tong on 3/16/15.
//  Copyright (c) 2015 Scott Tong. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

	@IBOutlet weak var messageLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
