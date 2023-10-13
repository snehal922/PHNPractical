//
//  ProductModel.swift
//  PHNPractical
//
//  Created by Snehal on 12/10/23.
//

import Foundation

typealias ProductModel = [Product]

struct Product: Codable {
    let id: Int
    let title: String
    let price: Int
    let description: String
    let images: [String]
    let creationAt: String
    let updatedAt: String
    let category: Category
}

struct Category: Codable {
    let id: Int
    let name: String
    let image: String
    let creationAt: String
    let updatedAt: String
}
