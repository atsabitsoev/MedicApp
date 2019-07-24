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
    @IBOutlet weak var labName: UILabel!
    
    
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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    }
    
    
    func openImage(url: URL) {
        delegate.openImage(url: url)
    }
    
    func openVideo(url: URL) {
        delegate.openVideo(url: url)
    }

}
