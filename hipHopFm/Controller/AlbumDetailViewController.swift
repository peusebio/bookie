//
//  AlbumDetailViewController.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 29/05/2021.
//

import Foundation
import UIKit

class AlbumDetailViewController: UIViewController {
    
    let albumMbid: String
    let artistMbid: String
    
    let albumDetailView: AlbumDetailView
    let viewModel: AlbumDetailViewModel
    
    init(albumMbid: String, artistMbid: String, albumName: String, artistName: String, albumImageData: Data?, albumImageUrl: String, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.albumMbid = albumMbid
        self.artistMbid = artistMbid
        albumDetailView = AlbumDetailView(albumName: albumName, artistName: artistName)
        viewModel = AlbumDetailViewModel()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        albumDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        if let imageData = albumImageData {
            albumDetailView.setupImage(imageData: imageData)
        } else {
            fetchAlbumImage(imageUrl: albumImageUrl)
        }
        
        viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAlbumInfo()
        addAlbumDetailView(albumDetailView: albumDetailView)
    }
    
    func fetchAlbumInfo(){
        DispatchQueue.global().async {
            self.viewModel.fetchAlbumInfo(mbid: self.albumMbid)
        }
    }
    
    func fetchArtistInfo(){
        DispatchQueue.global().async {
            self.viewModel.fetchArtistInfo(mbid: self.artistMbid)
        }
    }
    
    func fetchAlbumImage(imageUrl: String){
        DispatchQueue.global().async {
            self.viewModel.fetchAlbumImage(imageUrl: imageUrl)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAlbumDetailView(albumDetailView: AlbumDetailView) {
        view.addSubview(albumDetailView)
        
        view.addConstraint(NSLayoutConstraint(item: albumDetailView, attribute: .leadingMargin, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: albumDetailView, attribute: .topMargin, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: albumDetailView, attribute: .trailingMargin, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: albumDetailView, attribute: .bottomMargin, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: 0))
    }
}

extension AlbumDetailViewController: AlbumDetailViewControllerDelegate {
    
    func albumInfoFetchCompleted(albumFromResponse: AlbumResponse) {
        
        let albumTrackTableViewController = AlbumTrackTableViewController(tracks: albumFromResponse.album.tracks.track, nibName: .none, bundle: .none)
        
        albumDetailView.setupAlbumInfo(album: albumFromResponse.album, albumTrackView: albumTrackTableViewController.tableView)
        albumDetailView.setupAlbumInfoSubviews(album: albumFromResponse.album)
        
        addChild(albumTrackTableViewController)
        albumTrackTableViewController.didMove(toParent: self)
        
        fetchArtistInfo()
    }
    
    func artistInfoFetchCompleted(artistFromResponse: ArtistResponse) {
        albumDetailView.setupArtistInfoSubviews(artist: artistFromResponse.artist)
        albumDetailView.setupArtistInfo(artist: artistFromResponse.artist)
    }
    
    func albumImageFetchCompleted(imageData: Data){
        albumDetailView.setupImage(imageData: imageData)
    }
}

protocol AlbumDetailViewControllerDelegate {
    func albumInfoFetchCompleted(albumFromResponse: AlbumResponse)
    func artistInfoFetchCompleted(artistFromResponse: ArtistResponse)
    func albumImageFetchCompleted(imageData: Data)
}
