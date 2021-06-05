//
//  AlbumTableViewModel.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 25/05/2021.
//

import Foundation

class TopAlbumTableViewModel {
    
    private let client: LastFMRestClient
    private var isTopAlbumFetchInProgress = false
    
    private var topAlbums: [TopAlbum]
    private var albums: [Album]
    private var totalNumberOfAlbums: Int = 0
    private var nextPageToFetch: Int = 1
    private let numberOfAlbumsPerRequest: Int = 50
    private let numberOfAlbumsToFetch: Int = 1000
    
    private var delegate: AlbumTableViewControllerDelegate?
    
    private var albumsImageData: [Int : Data] = [:]
    
    init(){
        topAlbums = [TopAlbum]()
        albums = [Album]()
        client = LastFMRestClient.shared
    }
    
    func setDelegate(delegate: AlbumTableViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func fetchAlbums(){
        guard !isTopAlbumFetchInProgress else {
            return
        }
        
        isTopAlbumFetchInProgress = true
        
        client.getTopAlbums(with: TopAlbumListRequest.with(tag: "hiphop", page: nextPageToFetch), onResponseReceived: topAlbumsResponseReceived)
    }
    
    func topAlbumsResponseReceived(albumsFromResponse: AlbumListResponse){
        topAlbums.append(contentsOf: albumsFromResponse.albums.album.suffix(numberOfAlbumsPerRequest))
        
        totalNumberOfAlbums = Int(albumsFromResponse.albums.requestAttributes.total) ?? 0
        let attributes = albumsFromResponse.albums.requestAttributes
        
        if topAlbums.count < numberOfAlbumsToFetch {
            self.nextPageToFetch+=1
        }
        
        if Int(attributes.page)! > 1 {
            let indexPathsToReload = self.calculateIndexPathsToReload(from: albumsFromResponse.albums.album)
            self.delegate?.fetchCompleted(with: indexPathsToReload)
        } else {
            self.delegate?.fetchCompleted(with: .none)
        }
        self.isTopAlbumFetchInProgress = false
    }
    
    func loadAlbumImage(albumIndex: Int) {
        DispatchQueue.global().async { [weak self] in
            
            let album = self?.topAlbums[albumIndex]
            
            let imageUrl = album!.image[3].text
            
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
    
    private func calculateIndexPathsToReload(from newAlbums: [TopAlbum]) -> [IndexPath] {
        let startIndex = topAlbums.count - newAlbums.count
        let endIndex = startIndex + newAlbums.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func albumAt(index: Int) -> TopAlbum {
        return topAlbums[index]
    }
    
    func totalAlbumsCount() -> Int {
        return totalNumberOfAlbums
    }
    
    func currentAlbumsCount() -> Int {
        return topAlbums.count
    }
    
    func imageData(forAlbumAt index: Int) -> Data?{
        return albumsImageData[index]
    }
    
    func maximumNumberOfAlbumsToFetch() -> Int {
        return numberOfAlbumsToFetch
    }
}
