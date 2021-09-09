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
    //private static let defaultLayoutMargins = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
    
    init (albumName: String, artistName: String){
        super.init(frame: mainScreen.bounds)
        translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.text = albumName
        artistNameLabel.text = artistName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = ContentMode.scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        //imageView.layoutMargins = defaultLayoutMargins
        return imageView
    }()
    
    let albumNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        label.layoutMargins = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
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
        //label.layoutMargins = defaultLayoutMargins
        return label;
    }()
    
    let publishDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 18)
        //label.layoutMargins = defaultLayoutMargins
        return label;
    }()
    
    let artistNumberOfListenersLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 18)
        //label.layoutMargins = defaultLayoutMargins
        return label;
    }()
    
    var albumTrackView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.layoutMargins = defaultLayoutMargins
        return view;
        
    }()
    
    func setupAlbumInfoSubviews(album: Album){
        if let empty = album.image.first?.text.isEmpty {
            if !empty {
                addSubview(albumImageView)
                
                //ALBUM IMAGE VIEW
                addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 100))
                
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
            
            addConstraint(NSLayoutConstraint(item: albumNameLabel, attribute: .topMargin, relatedBy: .equal, toItem: lastSubview, attribute: .bottomMargin, multiplier: 1, constant: 10))
        }
        
        if !album.artist.isEmpty {
            let lastSubview = subviews.last
            addSubview(artistNameLabel)
            
            //ARTIST NAME LABEL
            addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 1))
            
            addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .topMargin, relatedBy: .equal, toItem: lastSubview, attribute: .bottomMargin, multiplier: 1, constant: 10))
        }
        
        if !album.tracks.track.isEmpty {
            var lastSubview = subviews.last
            addSubview(trackCountLabel)
            
            //TRACK COUNT LABEL
            addConstraint(NSLayoutConstraint(item: trackCountLabel, attribute: .topMargin, relatedBy: .equal, toItem: lastSubview, attribute: .bottomMargin, multiplier: 1, constant: 30))
            addConstraint(NSLayoutConstraint(item: trackCountLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 1))
            
//            lastSubview = subviews.last
//            addSubview(albumTrackView)
//
//            //ALBUM TRACK VIEW
//            addConstraint(NSLayoutConstraint(item: albumTrackView, attribute: .topMargin, relatedBy: .equal, toItem: lastSubview, attribute: .bottomMargin, multiplier: 1, constant: 30))
//            addConstraint(NSLayoutConstraint(item: albumTrackView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 1))
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
//            self.albumTrackView = albumTrackView
//            self.albumTrackView.translatesAutoresizingMaskIntoConstraints = false
//            self.albumTrackView.setNeedsDisplay()
            trackCountLabel.text = "💿 \(numberOfTracks) tracks"
        } else {
//            trackCountLabel.layoutMargins = .zero
//            self.albumTrackView.layoutMargins = .zero
        }
        if let wiki = album.wiki {
            publishDateLabel.text = "🗓 Released \(wiki.published.prefix(11))"
        } else {
//            publishDateLabel.layoutMargins = .zero
        }
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    func setupArtistInfo(artist: Artist) {
        if let stats = artist.stats {
            artistNumberOfListenersLabel.text = "🎧 \(stats.listeners) people listen to this artist"
        } else {
//            artistNumberOfListenersLabel.layoutMargins = .zero
        }
        
    }
    
    func setupImage(imageData: Data?) {
        if let data = imageData {
            let image = UIImage(data: data)
            albumImageView.image = image
        }
    }
}
