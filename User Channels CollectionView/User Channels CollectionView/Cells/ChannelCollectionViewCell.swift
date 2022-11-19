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
    
    
    //@IBOutlet weak var imageName: UIImageView!
    //@IBOutlet weak var imageTitleName: UILabel!
    //@IBOutlet weak var viewsName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.layer.cornerRadius = posterImageView.frame.width/2
        
    }
    
    func configure(movie: Result) {
        if let posterPath = movie.posterPath {
            posterImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500" + posterPath), placeholderImage: UIImage(named: "placeholder-image"))
        }
        else {
            posterImageView.image =  UIImage(named: "placeholder-image")
        }
        imageTitleName.text = movie.title
        
    }

}
