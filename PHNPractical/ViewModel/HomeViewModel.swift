//
//  HomeViewModel.swift
//  PHNPractical
//
//  Created by Snehal on 20/10/23.
//

import Foundation

class HomeViewModel: NSObject {
    
    var reloadTableView: (() -> Void)?
    var productModel = ProductModel()
    var productCellViewModels = [ProductCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    private var productService: ProductServiceProtocol
    
    init(productService: ProductServiceProtocol = ProductService()) {
        self.productService = productService
    }
    
    func getProduct() {
        productService.getProduct { success, results, error in
            if success, let product = results {
                self.fetchData(productModel: self.productModel)
            } else {
                print(error!)
                
            }
        }
    }
    
    func fetchData(productModel: ProductModel) {
        self.productModel = productModel
        var vms = [ProductCellViewModel]()
            for product in productModel {
                vms.append(createCellModel(product: product))
            }
        productCellViewModels = vms
            
        
    }
    func createCellModel(product: Product) -> ProductCellViewModel {
        let title = product.title
        let name = product.category.name
        let price = product.price
        let image = product.category.image
        
        return ProductCellViewModel(title: title, name: name, price: price, image: image)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ProductCellViewModel {
        return productCellViewModels[indexPath.row]
    }
    
}
