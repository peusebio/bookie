//
//  AlbumDetailView.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 29/05/2021.
//

import Foundation
import UIKit

class AlbumDetailScrollView: UIScrollView {
    
    private let mainScreen = UIScreen.main
    
    weak var vcDelegate: AlbumDetailViewController?
    
    init (albumName: String, artistName: String, backgroundColor: UIColor){
        super.init(frame: mainScreen.bounds)
        
        showsVerticalScrollIndicator = false
        self.backgroundColor = backgroundColor
        
        albumNameLabel.text = albumName
        artistNameLabel.text = artistName
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
    
    let albumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 30)
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 25)
        label.textColor = Color.artistNameTextColor
        return label
    }()
    
    let albumInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        //stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15
        return stackView
    }()
    
    let trackCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        return label
    }()
    
    let publishDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        return label
    }()
    
    let artistNumberOfListenersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        return label
    }()
    
    let trackListHeaderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Track List △", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 25)
        button.tintColor = Color.artistNameTextColor
        button.addTarget(self, action: #selector(headerButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let trackListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()
    
    func setupAlbumInfoSubviews(album: Album){
        if let empty = album.image.first?.text.isEmpty {
            if !empty {
                //ALBUM IMAGE VIEW
                addSubview(albumImageView)
                
                addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 20))
                
                addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 1))
                
                addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 2/3, constant: 1))
                
                addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 2/3, constant: 1))
            }
        }
        
        if !album.name.isEmpty {
            //ALBUM NAME LABEL
            let lastSubview = subviews.last
            addSubview(albumNameLabel)
            
            addConstraint(NSLayoutConstraint(item: albumNameLabel, attribute: .top, relatedBy: .equal, toItem: lastSubview, attribute: .bottom, multiplier: 1, constant: 15))
            
            addConstraint(NSLayoutConstraint(item: albumNameLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 1))
        }
        
        if !album.artist.isEmpty {
            //ARTIST NAME LABEL
            let lastSubview = subviews.last
            addSubview(artistNameLabel)
            
            addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .top, relatedBy: .equal, toItem: lastSubview, attribute: .bottom, multiplier: 1, constant: 10))
            
            addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        }
        
        //ALBUM INFO STACK VIEW
        let lastSubview = subviews.last
        addSubview(albumInfoStackView)
        
        addConstraint(NSLayoutConstraint(item: albumInfoStackView, attribute: .top, relatedBy: .equal, toItem: lastSubview, attribute: .bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: albumInfoStackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 40))
        
        if !album.tracks.track.isEmpty {
            //TRACK COUNT LABEL
            albumInfoStackView.addArrangedSubview(trackCountLabel)
            
            // TRACK LIST HEADER LABEL
            let lastSubview = subviews.last
            addSubview(trackListHeaderButton)
            
            addConstraint(NSLayoutConstraint(item: trackListHeaderButton, attribute: .top, relatedBy: .equal, toItem: lastSubview, attribute: .bottom, multiplier: 1, constant: 30))
            
            addConstraint(NSLayoutConstraint(item: trackListHeaderButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 40))
            
            //TRACK LIST STACK VIEW
            addTrackListToView()
        }
        
        if let empty = album.wiki?.published.isEmpty {
            if !empty {
                //PUBLISH DATE LABEL
                albumInfoStackView.addArrangedSubview(publishDateLabel)
            }
        }
    }
    
    func setupArtistInfoSubviews(artist: Artist) {
        if !(artist.stats?.listeners.isEmpty)! {
            //NUMBER OF LISTENERS LABEL
            albumInfoStackView.addArrangedSubview(artistNumberOfListenersLabel)
        }
    }
    
    func setupAlbumInfo(album: Album) {
        let numberOfTracks = album.tracks.track.count
        
        if numberOfTracks > 0 {
            trackCountLabel.text = "💿 \(numberOfTracks) tracks"
            
            let trackList = album.tracks.track
            
            for index in 0..<trackList.count {
                let trackName = trackList[index].name
                let trackLabel = createLabelForAlbumTrack(trackNumber: index + 1, trackName: trackName)
                trackListStackView.addArrangedSubview(trackLabel)
            }
        }
        
        if let wiki = album.wiki {
            publishDateLabel.text = "🗓 Released \(wiki.published.prefix(11))"
        }
    }
    
    private func createLabelForAlbumTrack(trackNumber: Int, trackName: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(trackNumber).  \(trackName)"
        label.font = UIFont.init(name: "AppleSDGothicNeo-Light", size: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
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
    
    private func addTrackListToView(){
        let lastSubview = subviews.last
        addSubview(trackListStackView)
        
        addConstraint(NSLayoutConstraint(item: trackListStackView, attribute: .top, relatedBy: .equal, toItem: lastSubview, attribute: .bottom, multiplier: 1, constant: 10))
        
        addConstraint(NSLayoutConstraint(item: trackListStackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: trackListStackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 50))
        
        addConstraint(NSLayoutConstraint(item: trackListStackView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
    }
    
    
    @objc func headerButtonPressed() {
        trackListStackView.isHidden.toggle()
        isScrollEnabled.toggle()
        
        if trackListStackView.isHidden {
            //let height = superview!.window!.rootViewController!.navigationController!.navigationBar.frame.height
            //setContentOffset(.init(x: 0, y: 0), animated: false)
            //contentInset = .init()
            //setContentOffset(.init(x: 0, y: -95), animated: true)
            trackListHeaderButton.setTitle("Track List ▽", for: .normal)
            setContentOffsetToHandleScrollDisabled()
        } else {
            trackListHeaderButton.setTitle("Track List △", for: .normal)
            //contentInset = .init()
            //setContentOffset(.init(), animated: true)
        }
    }
    
    private func setContentOffsetToHandleScrollDisabled() {
        if let navigationBarHeight = vcDelegate?.navigationController?.navigationBar.frame.height {
            if let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height {
                let totalHeight = navigationBarHeight + statusBarHeight
                contentOffset.y = -totalHeight
            }
        }
    }
    
//    private func addBottomMarginConstrainToLastVisibleSubview() {
//        let lastSubview = subviews[subviews.count-3]
//        lastSubview.backgroundColor = .red
//        addConstraint(NSLayoutConstraint(item: lastSubview, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
//    }
//
//    private func removeBottomMarginConstrainFromLastVisibleSubview() {
//        let lastSubview = subviews[subviews.count-3]
//        lastSubview.backgroundColor = .gray
//        removeConstraint(NSLayoutConstraint(item: lastSubview, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
//    }
}
