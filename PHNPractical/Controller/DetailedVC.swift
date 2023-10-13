//
//  DetailedVC.swift
//  PHNPractical
//
//  Created by Snehal on 13/10/23.
//

import UIKit
import Kingfisher

class DetailedVC: UIViewController {

    @IBOutlet weak var categoryImagesCollectionView: UICollectionView!
    
    @IBOutlet weak var loopVideo: VideoPlay!
    @IBOutlet weak var imgPageContol: UIPageControl!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var DescipLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    
    
    
    
    var currentImage : Int = 0
//    let productApi = ProductApi()
    var product : Product?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPageContol.currentPage = 0
        imgPageContol.numberOfPages = product?.images.count ?? 0
        categoryImagesCollectionView.dataSource = self
        categoryImagesCollectionView.delegate = self
        guard let product = product else {
            return
        }
        DescipLbl.text = "Description: \n\(product.description)"
        titleLbl.text = product.title
        priceLbl.text = "Price: \(String(Int(product.price)))"
        categoryLbl.text = "Category: \n\(product.category.name)"
    }
}
extension DetailedVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        if let imgurl = product?.images[indexPath.item],
           let url = URL(string: imgurl) {
            cell.detailedImage.kf.setImage(with: url)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imgPageContol.currentPage = indexPath.row
    }
    
    
}
