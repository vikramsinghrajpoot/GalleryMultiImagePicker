//
//  PhotoTableViewCell.swift
//  PhotoLibrary
//
//  Created by vikram singh rajpoot on 03/09/17.
//  Copyright © 2017 vikram singh rajpoot. All rights reserved.
//

import UIKit
import Photos

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var assets:PHAsset? {
        didSet{
            GalleryManager.shared.getFullImageFromAsset(asset: assets!) { (image) in
                self.cellImageView.image = image
            }
        }
    }

}
