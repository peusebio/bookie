//
//  AlbumListWrapper.swift
//  Bookie
//
//  Created by Pedro Eusébio on 19/05/2021.
//

import Foundation

struct AlbumListWrapper: Decodable {
    let album: [TopAlbum]
    let requestAttributes: RequestAttributes
    
    enum CodingKeys: String, CodingKey {
        case album
        case requestAttributes = "@attr"
    }
}
