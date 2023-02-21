//
//  DirectionCvCell.swift
//  CollectionViewLeft&RightDirection
//
//  Created by Abul Kashem on 21/2/23.
//

import UIKit

class DirectionCvCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var viewEdit: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewEdit.layer.cornerRadius = 10
        viewEdit.layer.borderWidth = 1.4
        viewEdit.layer.borderColor = UIColor.systemGray5.cgColor
        
    }

}
