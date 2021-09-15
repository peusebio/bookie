//
//  AlbumDetailView.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 29/05/2021.
//

import Foundation
import UIKit

class AlbumDetailView: UIView {
    
    private let mainScreen = UIScreen.main
    
    init (albumName: String, artistName: String){
        super.init(frame: mainScreen.bounds)
        translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.text = albumName
        artistNameLabel.text = artistName
        self.backgroundColor = Color.random()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 7.5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let albumNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        return label;
    }()
    
    let artistNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 19)
        label.textColor = Color.artistNameTextColor
        return label;
    }()
    
    let trackCountLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 18)
        return label;
    }()
    
    let publishDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 18)
        return label;
    }()
    
    let artistNumberOfListenersLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 18)
        return label;
    }()
    
    var albumTrackView: UIView?
    
    func setupAlbumInfoSubviews(album: Album){
        if let empty = album.image.first?.text.isEmpty {
            if !empty {
                addSubview(albumImageView)
                
                //ALBUM IMAGE VIEW
                addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 30))
                
                addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 1))
                
                addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 2/3, constant: 1))
                
                addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 2/3, constant: 1))
            }
        }
        
        if !album.name.isEmpty {
            let lastSubview = subviews.last
            addSubview(albumNameLabel)
            
            //ALBUM NAME LABEL
            addConstraint(NSLayoutConstraint(item: albumNameLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 1))
            
            addConstraint(NSLayoutConstraint(item: albumNameLabel, attribute: .topMargin, relatedBy: .equal, toItem: lastSubview, attribute: .bottomMargin, multiplier: 1, constant: 25))
        }
        
        if !album.artist.isEmpty {
            let lastSubview = subviews.last
            addSubview(artistNameLabel)
            
            //ARTIST NAME LABEL
            addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            
            addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .topMargin, relatedBy: .equal, toItem: lastSubview, attribute: .bottomMargin, multiplier: 1, constant: 20))
        }
        
        if !album.tracks.track.isEmpty {
            var lastSubview = subviews.last
            addSubview(trackCountLabel)
            
            //TRACK COUNT LABEL
            addConstraint(NSLayoutConstraint(item: trackCountLabel, attribute: .topMargin, relatedBy: .equal, toItem: lastSubview, attribute: .bottomMargin, multiplier: 1, constant: 30))
            addConstraint(NSLayoutConstraint(item: trackCountLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            
            lastSubview = subviews.last
            addSubview(albumTrackView!)

            //ALBUM TRACK VIEW
            addConstraint(NSLayoutConstraint(item: albumTrackView!, attribute: .topMargin, relatedBy: .equal, toItem: lastSubview, attribute: .bottomMargin, multiplier: 1, constant: 30))
            addConstraint(NSLayoutConstraint(item: albumTrackView!, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 30))
            addConstraint(NSLayoutConstraint(item: albumTrackView!, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: -30))
            addConstraint(NSLayoutConstraint(item: albumTrackView!, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1/4, constant: 0))
        }
        
        if let empty = album.wiki?.published.isEmpty {
            if !empty {
                let lastSubview = subviews.last
                addSubview(publishDateLabel)
                
                //PUBLISH DATE LABEL
                addConstraint(NSLayoutConstraint(item: publishDateLabel, attribute: .topMargin, relatedBy: .equal, toItem: lastSubview, attribute: .bottomMargin, multiplier: 1, constant: 30))
                
                addConstraint(NSLayoutConstraint(item: publishDateLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            }
        }
    }
    
    func setupArtistInfoSubviews(artist: Artist) {
        
        if !(artist.stats?.listeners.isEmpty)! {
            let lastSubview = subviews.last
            addSubview(artistNumberOfListenersLabel)
            
            //NUMBER OF LISTENERS LABEL
            addConstraint(NSLayoutConstraint(item: artistNumberOfListenersLabel, attribute: .topMargin, relatedBy: .equal, toItem: lastSubview, attribute: .bottomMargin, multiplier: 1, constant: 30))
            
            addConstraint(NSLayoutConstraint(item: artistNumberOfListenersLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        }
    }
    
    func setupAlbumInfo(album: Album, albumTrackView: UIView) {
        let numberOfTracks = album.tracks.track.count
        
        if numberOfTracks > 0 {
            self.albumTrackView = albumTrackView
            self.albumTrackView!.translatesAutoresizingMaskIntoConstraints = false
            //self.albumTrackView!.backgroundColor = self.backgroundColor
            trackCountLabel.text = "💿 \(numberOfTracks) tracks"
        }
        
        if let wiki = album.wiki {
            publishDateLabel.text = "🗓 Released \(wiki.published.prefix(11))"
        }
    }
    
    func setupArtistInfo(artist: Artist) {
        if let stats = artist.stats {
            artistNumberOfListenersLabel.text = "🎧 \(stats.listeners) people listen to this artist"
        }
    }
    
    func setupImage(imageData: Data?) {
        if let data = imageData {
            let image = UIImage(data: data)
            albumImageView.image = image
        }
    }
}
