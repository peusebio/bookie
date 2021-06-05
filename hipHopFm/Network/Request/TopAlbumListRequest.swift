//
//  BookListRequest.swift
//  Bookie
//
//  Created by Pedro Eusébio on 19/05/2021.
//

import Foundation

struct TopAlbumListRequest {
    
    let parameters: [String : String]
    
    static func with(tag: String, page: Int) -> TopAlbumListRequest{
        let parameters = ["tag" : tag, "method" : "tag.gettopalbums", "page": "\(page)"]
            return TopAlbumListRequest(parameters: parameters)
    }
}
