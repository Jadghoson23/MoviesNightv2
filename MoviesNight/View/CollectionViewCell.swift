//
//  CollectionViewCell.swift
//  MoviesNight-choose your movie
//
//  Created by Jad Ghoson on 06/02/2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var castName: UILabel!
    @IBOutlet weak var charachterName: UILabel!
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var viewCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        imageCell.layer.cornerRadius = min(imageCell.frame.size.width,imageCell.frame.size.height) / 2
        imageCell.clipsToBounds = true
        imageCell.layer.borderWidth = 1.0
        imageCell.layer.borderColor = UIColor.black.cgColor
        viewCell.layer.cornerRadius = min(viewCell.frame.size.width,viewCell.frame.size.height) / 8
        
        
    }

}
