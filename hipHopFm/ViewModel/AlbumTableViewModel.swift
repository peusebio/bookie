//
//  AlbumTableViewModel.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 25/05/2021.
//

import Foundation

class AlbumTableViewModel {
    
    private let client: LastFMRestClient
    private var isFetchInProgress = false
    
    private var albums: [Album]
    private var totalNumberOfAlbums: Int = 0
    private var nextPageToFetch: Int = 1
    private let numberOfAlbumsPerRequest: Int = 50
    
    private var delegate: AlbumTableViewControllerDelegate?
    
    private var albumsImageData: [Int : Data] = [:]
    
    init(){
        albums = [Album]()
        client = LastFMRestClient()
    }
    
    func setDelegate(delegate: AlbumTableViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func fetchAlbums(){
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        LastFMRestClient().getAlbums(with: AlbumListRequest.with(tag: "hiphop", page: nextPageToFetch), onResponseReceived: responseReceived)
    }
    
    func responseReceived(albumsFromResponse: AlbumListResponse){
        albums.append(contentsOf: albumsFromResponse.albums.album.suffix(numberOfAlbumsPerRequest))
        
        totalNumberOfAlbums = Int(albumsFromResponse.albums.requestAttributes.total) ?? 0
        let attributes = albumsFromResponse.albums.requestAttributes
        
        if Int(attributes.page)! < Int(attributes.totalPages)! {
            self.nextPageToFetch+=1
        }
        
        if Int(attributes.page)! > 1 {
            let indexPathsToReload = self.calculateIndexPathsToReload(from: albumsFromResponse.albums.album)
            self.delegate?.fetchCompleted(with: indexPathsToReload)
        } else {
            self.delegate?.fetchCompleted(with: .none)
        }
        self.isFetchInProgress = false
    }
    
    func loadAlbumImage(albumIndex: Int) {
        DispatchQueue.global().async { [weak self] in
            
            let album = self?.albums[albumIndex]
            
            let imageUrl = album!.image[2].text
            
            if !imageUrl.isEmpty {
                let url = URL(string: imageUrl)! as URL
                if let imageData = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        self?.albumsImageData[albumIndex] = imageData
                        self?.delegate?.updateAlbumImage(cellRowIndex: albumIndex, thumbnailData: imageData)
                    }
                }
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newAlbums: [Album]) -> [IndexPath] {
        let startIndex = albums.count - newAlbums.count
        let endIndex = startIndex + newAlbums.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func albumAt(index: Int) -> Album {
        return albums[index]
    }
    
    func totalAlbumsCount() -> Int {
        return totalNumberOfAlbums
    }
    
    func currentAlbumsCount() -> Int {
        return albums.count
    }
    
    func imageData(forHeroAt index: Int) -> Data?{
        return albumsImageData[index]
    }
}
