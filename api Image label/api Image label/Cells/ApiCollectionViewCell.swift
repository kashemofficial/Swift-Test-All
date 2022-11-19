//
//  ApiCollectionViewCell.swift
//  api Image label
//
//  Created by Abul Kashem on 19/11/22.
//

import UIKit

class ApiCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var apiImageName: UIImageView!
    @IBOutlet weak var apiLabelName1: UILabel!
    @IBOutlet weak var apiLabelName2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        apiImageName.layer.cornerRadius = 15
    }

}
