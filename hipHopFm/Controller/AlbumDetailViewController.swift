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
    
    let albumDetailScrollView: AlbumDetailScrollView
    let viewModel: AlbumDetailViewModel
    var retrievingAlbumImageNecessary: Bool = true
    var albumImageUrl: String?
    var imageData: Data?
    
    init(albumMbid: String, artistMbid: String, albumName: String, artistName: String, albumImageData: Data?, albumImageUrl: String, backgroundColor: UIColor, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.albumMbid = albumMbid
        self.artistMbid = artistMbid
        
        albumDetailScrollView = AlbumDetailScrollView(albumName: albumName, artistName: artistName, backgroundColor: backgroundColor)
        
        viewModel = AlbumDetailViewModel()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        albumDetailScrollView.vcDelegate = self
        
        if let imageData = albumImageData {
            self.imageData = imageData
        } else {
            self.albumImageUrl = albumImageUrl
        }
        
        viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAlbumInfo()
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
    
    func setupAlbumDetailView(albumDetailView: AlbumDetailScrollView) {
        view.addSubview(albumDetailView)
        
        view.addConstraint(NSLayoutConstraint(item: albumDetailView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: albumDetailView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: albumDetailView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: albumDetailView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
    }
}

extension AlbumDetailViewController: AlbumDetailViewControllerDelegate {
    
    func albumInfoFetchCompleted(albumFromResponse: AlbumResponse) {
        
        if let album = albumFromResponse.album {
            fetchArtistInfo()
            if let imageData = self.imageData {
                albumDetailScrollView.setupImage(imageData: imageData)
            } else {
                fetchAlbumImage(imageUrl: albumImageUrl!)
            }
            albumDetailScrollView.setupAlbumInfo(album: album)
            albumDetailScrollView.setupAlbumInfoSubviews(album: album)
            setupAlbumDetailView(albumDetailView: albumDetailScrollView)
        } else {
            configureErrorView()
        }
    }
    
    func configureErrorView(){
        
        let errorMessageLabel = UILabel()
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.lineBreakMode = .byWordWrapping
        errorMessageLabel.text = "🥲 There was an error while retrieving this album's information"
        
        view.addSubview(errorMessageLabel)
        view.addConstraint(NSLayoutConstraint(item: errorMessageLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: errorMessageLabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: errorMessageLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.75, constant: 1))
    }
    
    func artistInfoFetchCompleted(artistFromResponse: ArtistResponse) {
        albumDetailScrollView.setupArtistInfoSubviews(artist: artistFromResponse.artist)
        albumDetailScrollView.setupArtistInfo(artist: artistFromResponse.artist)
    }
    
    func albumImageFetchCompleted(imageData: Data){
        albumDetailScrollView.setupImage(imageData: imageData)
    }
}

protocol AlbumDetailViewControllerDelegate {
    func albumInfoFetchCompleted(albumFromResponse: AlbumResponse)
    func artistInfoFetchCompleted(artistFromResponse: ArtistResponse)
    func albumImageFetchCompleted(imageData: Data)
}
