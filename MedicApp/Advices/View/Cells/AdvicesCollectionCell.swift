//
//  AdvicesCollectionCell.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 24/07/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class AdvicesCollectionCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var delegate: ShowableImageVideo!
    
    
    var type: AdviceType = .text
    var images: [URL]!
    var videos: [URL]?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func openImage(url: URL) {
        delegate.openImage(url: url)
    }
    
    func openVideo(url: URL) {
        delegate.openVideo(url: url)
    }

}
