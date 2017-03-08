//
//  TaskTableViewCell.swift
//  TasksLists
//
//  Created by Ali Darwiche  on 3/8/17.
//  Copyright © 2017 Ali Darwiche . All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var textField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
