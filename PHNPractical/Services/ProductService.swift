//
//  ProductService.swift
//  PHNPractical
//
//  Created by Snehal on 21/10/23.
//

import Foundation

protocol ProductServiceProtocol {
    func getProduct(complition: @escaping (_ success: Bool, _ results: ProductModel?, _ error: Error?)-> ())
}

class ProductService: ProductServiceProtocol {
    func getProduct(complition: @escaping (Bool, ProductModel?, Error?) -> ()) {
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products")
        else {
            return complition(false, nil, APIError.incorrectUrl )
        }
        
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            guard data != nil else {
                print("data is nil")
                return complition(false, nil, APIError.dataIsNil)
            }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(ProductModel?.self, from: data!)
                
                return complition(true, decodedData, nil)
                
            } catch {
                return complition(false, nil, APIError.invalidJSON)
            }
        }.resume()
    }
}

enum APIError: Error {
    case incorrectUrl
    case invalidJSON
    case invalidModelClass
    case dataIsNil
}
