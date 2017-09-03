//
//  GalleryManager.swift
//  PhotoLibrary
//
//  Created by vikram singh rajpoot on 03/09/17.
//  Copyright © 2017 vikram singh rajpoot. All rights reserved.
//

import Foundation
import Photos

class GalleryManager {
    
    static let shared = GalleryManager()
    private var imageManage:PHImageManager?
    private var requestOptions:PHImageRequestOptions?
    
    private init(){
        imageManage = PHImageManager.default()
        requestOptions = PHImageRequestOptions()
        print("Dont creat another instance.")
    }
    
    func getPhotosList(index:Int, complition:@escaping (_ images:PHFetchResult<PHAsset>?, _ error:String?)->Void){
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                print("Good to proceed")
                let fetchOptions = PHFetchOptions()
                //fetchOptions.fetchLimit = 20 * index
            
                let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                print("Found \(allPhotos.count) images")
                complition(allPhotos, nil)
            case .denied, .restricted:
                print("Not allowed")
                complition(nil, "You dont have gallery permissions.")

            case .notDetermined:
                print("Not determined yet")
                complition(nil, "Status not determined yet.")

            }
        }
    }
    
    
    func getThumbNailImageFromAssets(asset:PHAsset, complition:@escaping (_ image:UIImage)->Void){
        imageManage?.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: requestOptions, resultHandler: {(result, info)->Void in
            if let nonNilResult = result {
                complition(nonNilResult)
            }
        })
    }
    
    func getFullImageFromAsset(asset:PHAsset, complition:@escaping (_ image:UIImage)->Void){
        imageManage?.requestImageData(for: asset, options: requestOptions) { (data, type, orientation, keys) in
            if let nonNildata = data{
                complition(UIImage(data: nonNildata)!)
            }
            
        }
    }

    
}
