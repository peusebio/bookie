//
//  Album.swift
//  Bookie
//
//  Created by Pedro Eusébio on 19/05/2021.
//

import Foundation

struct Album: Decodable {
    let name: String
    let image: [Image]
}
