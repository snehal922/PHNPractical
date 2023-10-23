//
//  HomeVC.swift
//  PHNPractical
//
//  Created by Snehal on 12/10/23.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    
    var product : ProductModel?
    let productApi = ProductApi()
    var visibleProducts: ProductModel = []
    
    let itemPerPage = 20
    var currentPage = 1
    
    lazy var viewModel = {
        HomeViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTableView.delegate = self
        productTableView.dataSource = self
        
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        getApi()
        
        // Do any additional setup after loading the view.
    }
    
    func initViewModel() {
        viewModel.getProduct()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.productTableView.reloadData()
            }
    }
    func getApi() {
        
        productApi.fetchApi() { response in
            self.product = response
            
            DispatchQueue.main.async {
                self.loadVisibleData()
                //                self.productTableView.reloadData()
                
            }
        }
    }
    
    func loadVisibleData() {
        // Determine the range of products to be displayed on the current page
        guard let product = product else { return }
        let startIndex = (currentPage - 1) * itemPerPage
        let endIndex = min(startIndex + itemPerPage, product.count)
        
        // Update the visible products array
        visibleProducts = Array(product[0..<endIndex])
        
        // Reload the table view
        productTableView.reloadData()
    }
    @IBAction func loadMoreBtnTapped(_ sender: Any) {
        // Increment the current page
        currentPage += 1
        
        // Load the next page of data
        loadVisibleData()
    }
    
    
}
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.productCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        performSegue(withIdentifier: "toDetailed", sender: indexPath)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailedVC") as! DetailedVC
        controller.product = self.visibleProducts[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
