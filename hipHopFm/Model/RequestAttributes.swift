//
//  RequestAttributes.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 28/05/2021.
//

import Foundation

struct RequestAttributes: Decodable {
    let tag: String
    let page: String
    let perPage: String
    let totalPages: String
    let total: String
}
