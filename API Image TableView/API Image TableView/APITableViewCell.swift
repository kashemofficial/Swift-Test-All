//
//  APITableViewCell.swift
//  API Image TableView
//
//  Created by Abul Kashem on 19/11/22.
//

import UIKit

class APITableViewCell: UITableViewCell {
    @IBOutlet weak var apiImageName: UIImageView!
    @IBOutlet weak var apiLabelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
