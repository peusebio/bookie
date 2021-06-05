//
//  AlbumCell.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 29/05/2021.
//

import Foundation
import UIKit

class BaseCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    func setupSubviews() { }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AlbumCell: BaseCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        setup(with: .none)
    }
    
    let albumImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 4
        image.clipsToBounds = true
        image.contentMode = ContentMode.scaleAspectFill
        return image
    }()
    
    let albumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "AvenirBold", size: 25)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Avenir", size: 13)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.gray
        return label
    }()
    
    let informationLoadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "AvenirBold", size: 30)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Loading ..."
        return label
    }()
    
    func setup(with album: TopAlbum?){
        if let album = album {
            informationLoadingLabel.isHidden = true
            albumImageView.isHidden = false
            albumNameLabel.isHidden = false
            artistNameLabel.isHidden = false
            albumNameLabel.text = album.name
            artistNameLabel.text = album.artist.name
        } else {
            informationLoadingLabel.isHidden = false
            albumImageView.isHidden = true
            albumNameLabel.isHidden = true
            artistNameLabel.isHidden = true
            albumNameLabel.text = "Loading ..."
        }
    }
    
    override func setupSubviews() {
        addSubview(albumImageView)
        addSubview(albumNameLabel)
        addSubview(artistNameLabel)
        addSubview(informationLoadingLabel)
        
        addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .bottomMargin, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: -5))
        addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .width, relatedBy: .equal, toItem: albumImageView, attribute: .height, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: albumNameLabel, attribute: .leadingMargin, relatedBy: .equal, toItem: albumImageView, attribute: .trailingMargin, multiplier: 1, constant: 25))
        addConstraint(NSLayoutConstraint(item: albumNameLabel, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: albumNameLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: -5))
        
        addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .leadingMargin, relatedBy: .equal, toItem: albumImageView, attribute: .trailingMargin, multiplier: 1, constant: 25))
        addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .topMargin, relatedBy: .equal, toItem: albumNameLabel, attribute: .bottomMargin, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: -5))
        
        addConstraint(NSLayoutConstraint(item: informationLoadingLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: informationLoadingLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: -10))
        addConstraint(NSLayoutConstraint(item: informationLoadingLabel, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: informationLoadingLabel, attribute: .bottomMargin, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: 10))
    }
    
    func updateImage(imageData: Data?) {
        
        if let imageData = imageData {
            albumImageView.image = UIImage(data: imageData as Data)
        } else {
            albumImageView.image = .none
        }
    }
}
