//
//  ArtistRequest.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 29/05/2021.
//

import Foundation

struct ArtistRequest {
    let parameters: [String : String]
    
    static func with(mbid: String) -> ArtistRequest{
        let parameters = ["method" : "artist.getinfo", "mbid" : mbid]
        return ArtistRequest(parameters: parameters)
    }
}
