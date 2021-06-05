//
//  AlbumRequest.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 29/05/2021.
//

import Foundation

struct AlbumRequest {
    let parameters: [String : String]
    
    static func with(mbid: String) -> AlbumRequest{
        let parameters = ["method" : "album.getinfo", "mbid": "\(mbid)"]
            return AlbumRequest(parameters: parameters)
    }
}
