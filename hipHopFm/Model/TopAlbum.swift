//
//  TopAlbum.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 29/05/2021.
//

import Foundation

struct TopAlbum: Decodable {
    let name: String
    let mbid: String
    let image: [Image]
    let artist: TopAlbumArtist
}
