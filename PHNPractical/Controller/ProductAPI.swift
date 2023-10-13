//
//  ProductAPI.swift
//  PHNPractical
//
//  Created by Snehal on 12/10/23.
//

import Foundation
class ProductApi {
    func fetchApi(complition: @escaping(ProductModel?) -> Void) {
        
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products")
        else {
            return complition(nil)
        }
        
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            guard data != nil else {
                print("data is nil")
                return complition(nil)
            }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(ProductModel?.self, from: data!)
                
                return complition(decodedData)
                
            } catch {
                return complition(nil)
            }
        }.resume()
    }
}
