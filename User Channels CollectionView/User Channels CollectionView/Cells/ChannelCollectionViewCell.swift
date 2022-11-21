//
//  ChannelCollectionViewCell.swift
//  User Channels CollectionView
//
//  Created by Abul Kashem on 19/11/22.
//

import UIKit
import SDWebImage

class ChannelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var imageTitleName: UILabel!
    @IBOutlet weak var viewsName: UILabel!
    

    override func awakeFromNib(){
        super.awakeFromNib()
   
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.layer.cornerRadius = posterImageView.bounds.width/2.0

    }
    
    
    func configure(movie: Result) {
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.darkGray.cgColor
        
        if let posterPath = movie.posterPath {
            posterImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500" + posterPath), placeholderImage: UIImage(named: "placeholder-image"))
        }
        else {
            posterImageView.image =  UIImage(named: "placeholder-image")
        }
        imageTitleName.text = movie.title
        viewsName.text = String(movie.id!)+"K"
    }
}
