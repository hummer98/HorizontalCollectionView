//
//  ViewController.swift
//  HorizontalCollectionView
//
//  Created by kdg-developer on 06/19/2019.
//  Copyright (c) 2019 kdg-developer. All rights reserved.
//

import UIKit
import HorizontalCollectionView

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    static var identifier = "ImageCell"
}

class ViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var size = CGSize(width: 44, height: 44)
    lazy var items: [UIImage] = [
        UIImage.box(size: size, color: .white),
        UIImage.box(size: size, color: .red),
        UIImage.box(size: size, color: .green),
        UIImage.box(size: size, color: .blue)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        cell.imageView.image = items[indexPath.row]
        return cell
    }
}
