//
//  AlbumDetailViewModel.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 29/05/2021.
//

import Foundation

class AlbumDetailViewModel {
    
    let client: LastFMRestClient
    var delegate: AlbumDetailViewControllerDelegate?
    
    private var isAlbumFetchInProgress = false
    private var isArtistFetchInProgress = false
    
    init(){
        self.client = LastFMRestClient.shared
    }
    
    func fetchAlbumInfo(mbid: String) {
        guard !isAlbumFetchInProgress else {
            return
        }
        
        isAlbumFetchInProgress = true
        
        client.getAlbumInfo(with: AlbumRequest.with(mbid: mbid), onResponseReceived: albumInfoResponseReceived)
    }
    
    func fetchArtistInfo(mbid: String) {
        guard !isArtistFetchInProgress else {
            return
        }
        
        isArtistFetchInProgress = true
        
        client.getArtistInfo(with: ArtistRequest.with(mbid: mbid), onResponseReceived: artistInfoResponseReceived)
    }
    
    func fetchAlbumImage(imageUrl: String) {
        if(imageUrl != ""){
            let url = URL(string: imageUrl)! as URL
            if let imageData = try? Data(contentsOf: url){
                DispatchQueue.main.async {
                    self.delegate?.albumImageFetchCompleted(imageData: imageData)
                }
            }
        }
    }
    
    func albumInfoResponseReceived (album: AlbumResponse) {
        DispatchQueue.main.async {
            self.delegate?.albumInfoFetchCompleted(albumFromResponse: album)
        }
    }
    
    func artistInfoResponseReceived (artist: ArtistResponse) {
        DispatchQueue.main.async {
            self.delegate?.artistInfoFetchCompleted(artistFromResponse: artist)
        }
    }
}
