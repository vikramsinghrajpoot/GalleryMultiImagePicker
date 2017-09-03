//
//  LibraryImageCell.swift
//  PhotoLibrary
//
//  Created by vikram singh rajpoot on 03/09/17.
//  Copyright © 2017 vikram singh rajpoot. All rights reserved.
//

import UIKit
import Photos

class LibraryImageCell: UICollectionViewCell {

    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadingIndicator.hidesWhenStopped = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setSelected(false, animated: false)
    }

    var asset:PHAsset? {
        didSet{
           self.loadImage(asset: asset!)
        }
    }
    
    override var isSelected: Bool {
        set {
            setSelected(newValue, animated: true)
        }
        get {
            return super.isSelected
        }
    }
    
    func setSelected(_ isSelected: Bool, animated: Bool) {
        super.isSelected = isSelected
        self.updateSelected(true)
    }
    
    fileprivate func updateSelected(_ animated: Bool) {

        if isSelected {
           self.selectImageView.isHidden = false
        }
        else {
            self.selectImageView.isHidden = true

        }
    }
    
    func loadImage(asset:PHAsset){
        self.loadingIndicator.startAnimating()
        GalleryManager.shared.getThumbNailImageFromAssets(asset: asset) {[weak self] (image) in
            OperationQueue.main.addOperation {
                self?.cellImageView.image = image
                self?.loadingIndicator.stopAnimating()
            }
        }
    }

}
