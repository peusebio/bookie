//
//  Artist.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 29/05/2021.
//

import Foundation

struct Artist: Decodable {
    let name: String
    let mbid: String?
    let stats: ArtistStats?
}
