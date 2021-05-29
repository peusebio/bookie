//
//  BookListRequest.swift
//  Bookie
//
//  Created by Pedro Eusébio on 19/05/2021.
//

import Foundation

struct AlbumListRequest {
    
    let parameters: [String : String]
    
    static func with(tag: String, page: Int) -> AlbumListRequest{
        let parameters = ["tag" : tag, "method" : "tag.gettopalbums", "format": "json", "page": "\(page)"]
            return AlbumListRequest(parameters: parameters)
    }
}
