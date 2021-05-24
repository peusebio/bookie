//
//  AlbumTableViewModel.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 25/05/2021.
//

import Foundation

class AlbumTableViewModel {
    
    private var albums: [Album]
    private let client: LastFMRestClient
    
    private var delegate: AlbumTableViewControllerDelegate?
    
    init(){
        albums = [Album]()
        client = LastFMRestClient()
    }
    
    func setDelegate(delegate: AlbumTableViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func fetchAlbums(){
        LastFMRestClient().getAlbums(with: AlbumListRequest.with(tag: "hiphop"), onResponseReceived: responseReceived)
    }
    
    func responseReceived(albumsFromResponse: [Album]){
        albums.append(contentsOf: albumsFromResponse)
        DispatchQueue.main.async {
            self.delegate?.reloadData()
        }
    }
    
    func albumAt(index: Int) -> Album {
        return albums[index]
    }
    
    func albumsCount() -> Int {
        return albums.count
    }
}
