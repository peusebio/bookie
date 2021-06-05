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
        setupSubviews()
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
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.layoutMargins = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
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
        label.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return label;
    }()
    
    let trackCountLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 18)
        label.layoutMargins = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        return label;
    }()
    
    let publishDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 18)
        label.layoutMargins = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        return label;
    }()
    
    let artistNumberOfListenersLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 18)
        label.layoutMargins = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        return label;
    }()
    
    private func setupSubviews(){
        addSubview(albumImageView)
        addSubview(albumNameLabel)
        addSubview(artistNameLabel)
        addSubview(trackCountLabel)
        addSubview(publishDateLabel)
        addSubview(artistNumberOfListenersLabel)
        
        //ALBUM IMAGE VIEW
        addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 2/3, constant: 1))
        
        addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.3, constant: 1))
        
        //ALBUM NAME LABEL
        addConstraint(NSLayoutConstraint(item: albumNameLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: albumNameLabel, attribute: .topMargin, relatedBy: .equal, toItem: albumImageView, attribute: .bottomMargin, multiplier: 1, constant: 0))
        
        //ARTIST NAME LABEL
        addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .topMargin, relatedBy: .equal, toItem: albumNameLabel, attribute: .bottomMargin, multiplier: 1, constant: 0))
        
        //addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: -10))
        
        //TRACK COUNT LABEL
        //addConstraint(NSLayoutConstraint(item: trackCountLabel, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 25))
        
        addConstraint(NSLayoutConstraint(item: trackCountLabel, attribute: .topMargin, relatedBy: .equal, toItem: artistNameLabel, attribute: .bottomMargin, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: trackCountLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        //addConstraint(NSLayoutConstraint(item: trackCountLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: -10))
        
        //PUBLISH DATE LABEL
        //addConstraint(NSLayoutConstraint(item: publishDateLabel, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 25))
        
        addConstraint(NSLayoutConstraint(item: publishDateLabel, attribute: .topMargin, relatedBy: .equal, toItem: trackCountLabel, attribute: .bottomMargin, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: publishDateLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        //addConstraint(NSLayoutConstraint(item: publishDateLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: -10))
        
        //NUMBER OF LISTENERS LABEL
        //addConstraint(NSLayoutConstraint(item: artistNumberOfListenersLabel, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 25))
        
        addConstraint(NSLayoutConstraint(item: artistNumberOfListenersLabel, attribute: .topMargin, relatedBy: .equal, toItem: publishDateLabel, attribute: .bottomMargin, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: artistNumberOfListenersLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        //addConstraint(NSLayoutConstraint(item: artistNumberOfListenersLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: -10))
    }
    
    func setup(album: Album?, artist: Artist?) {
        if let album = album {
            let numberOfTracks = album.tracks.track.count
            if numberOfTracks > 0 {
                trackCountLabel.text = "ℹ️ \(numberOfTracks) tracks"
            } else {
                trackCountLabel.layoutMargins = .zero
            }
            if let wiki = album.wiki {
                publishDateLabel.text = "🗓 Released \(wiki.published.prefix(11))"
            } else {
                publishDateLabel.layoutMargins = .zero
            }
        }
        
        if let artist = artist {
            if let stats = artist.stats {
                artistNumberOfListenersLabel.text = "🎧 \(stats.listeners) people listen to this artist"
            } else {
                artistNumberOfListenersLabel.layoutMargins = .zero
            }
        }
    }
    
    func setupImage(imageData: Data?) {
        if let data = imageData {
            let image = UIImage(data: data)
            albumImageView.image = image
        }
    }
}
