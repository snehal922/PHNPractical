//
//  ProductCell.swift
//  PHNPractical
//
//  Created by Snehal on 12/10/23.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var cellViewModel: ProductCellViewModel? {
        didSet {
            
            if let cellViewM = cellViewModel {
                configureCell(product: cellViewM)
            }
        }
    }
    
    func configureCell(product: ProductCellViewModel) {
       
        let url = URL(string: product.image)
        productImg.kf.setImage(with: url)
        titlelbl.text = product.title
        nameLbl.text = product.name
    }
    
}
