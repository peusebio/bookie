//
//  Album.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 29/05/2021.
//

import Foundation

struct Album: Decodable {
    let name: String
    let artist: String
    let mbid: String?
    let image: [Image]
    let tracks: TrackListWrapper
    let wiki: Wiki?
}
