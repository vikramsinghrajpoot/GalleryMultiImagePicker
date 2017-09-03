//
//  ViewController.swift
//  PhotoLibrary
//
//  Created by vikram singh rajpoot on 03/09/17.
//  Copyright © 2017 vikram singh rajpoot. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    var assets:[PHAsset] = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var tableView: UITableView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? GalleryPickerViewController
        vc?.delegate = self
        vc?.previousSelected = assets
    }

}

extension ViewController:GalleryPickerViewControllerDelegate{
    func didFinishPicking(images: [PHAsset]?) {
        self.assets.removeAll()
        self.assets = images!
        //print(images?.count)
        self.tableView.reloadData()
    }
}

extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.assets.count ??  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as? PhotoTableViewCell
        cell?.assets = self.assets[indexPath.row]
        return cell!
    }
}
