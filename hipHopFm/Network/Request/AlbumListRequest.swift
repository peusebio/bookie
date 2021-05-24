//
//  BookListRequest.swift
//  Bookie
//
//  Created by Pedro Eusébio on 19/05/2021.
//

import Foundation

struct AlbumListRequest {
    
    let parameters: [String : String]
    
    static func with(tag: String) -> AlbumListRequest{
        let parameters = ["tag" : tag, "method" : "tag.gettopalbums", "format": "json"]
            return AlbumListRequest(parameters: parameters)
    }
}
