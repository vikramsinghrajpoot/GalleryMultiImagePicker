//
//  ViewController.swift
//  PhotoLibrary
//
//  Created by vikram singh rajpoot on 03/09/17.
//  Copyright © 2017 vikram singh rajpoot. All rights reserved.
//

import UIKit
import Photos

protocol GalleryPickerViewControllerDelegate:class {
    func didFinishPicking(images:[PHAsset]?)
}

class GalleryPickerViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let gallery = GalleryManager.shared
    var allAssets:PHFetchResult<PHAsset>?
    var currentIndex = 1
    weak var delegate:GalleryPickerViewControllerDelegate?
    var maximum = 0
    var previousSelected:[PHAsset]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.allowsMultipleSelection = true
        self.fetch()
    }
    
    func fetch(){
        gallery.getPhotosList(index: currentIndex) { (images, status) in
            OperationQueue.main.addOperation {
                self.allAssets = images
                self.collectionView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func donePress(_ sender: UIBarButtonItem) {
        let selectedPaths = self.collectionView.indexPathsForSelectedItems
        guard let _ = selectedPaths else {
            return
        }
        var selectedAssets = [PHAsset]()
        
        for indexPath in selectedPaths! {
            if let asset = self.allAssets?.object(at: indexPath.item) {
                selectedAssets.append(asset)
            }
        }
        self.dismiss(animated: true) {
            self.delegate?.didFinishPicking(images: selectedAssets)
        }

    }
    
}


extension GalleryPickerViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let rows = self.allAssets?.count {
           return rows
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryImageCell", for: indexPath) as? LibraryImageCell
        let asset = self.allAssets?[indexPath.item]
        if let nonNilPreSelected = self.previousSelected {
            let current = nonNilPreSelected.filter({$0.localIdentifier == asset?.localIdentifier})
            if current.count > 0 {
               //cell?.isSelected = true
               collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
            }
        }
        cell?.asset = asset!
        return cell!
    }
    
}


extension GalleryPickerViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = collectionView.frame.size.width / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }

}
