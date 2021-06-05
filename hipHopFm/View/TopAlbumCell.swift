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

class TopAlbumCell: BaseCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        setup(with: .none, albumPosition: 0)
        tintColor = UIColor.black
    }
    
    let cellBackgroundView: UIView = {
        let view = UIView(frame: CGRect())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.backgroundColor = Color.random()
        return view
    }()
    
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
        label.font = UIFont.init(name: "Avenir-Heavy", size: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.black
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Avenir", size: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = Color.artistNameTextColor
        return label
    }()
    
    let informationLoadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Avenir-Heavy", size: 35)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Loading ..."
        return label
    }()
    
    func setup(with album: TopAlbum?, albumPosition: Int?){
        if let album = album {
            informationLoadingLabel.isHidden = true
            albumImageView.isHidden = false
            albumNameLabel.isHidden = false
            artistNameLabel.isHidden = false
            albumNameLabel.text = "#\(albumPosition!): \(album.name)"
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
        addSubview(cellBackgroundView)
        
        cellBackgroundView.addSubview(albumImageView)
        cellBackgroundView.addSubview(albumNameLabel)
        cellBackgroundView.addSubview(artistNameLabel)
        cellBackgroundView.addSubview(informationLoadingLabel)
        
        //CELL BACKGROUND VIEW
        addConstraint(NSLayoutConstraint(item: cellBackgroundView, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: cellBackgroundView, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 2))
        
        addConstraint(NSLayoutConstraint(item: cellBackgroundView, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: cellBackgroundView, attribute: .bottomMargin, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: -2))
        
        //ALBUM IMAGE VIEW
        addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .leadingMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .leadingMargin, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .topMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .topMargin, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .bottomMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .bottomMargin, multiplier: 1, constant: -5))
        addConstraint(NSLayoutConstraint(item: albumImageView, attribute: .width, relatedBy: .equal, toItem: albumImageView, attribute: .height, multiplier: 1, constant: 0))
        
        //ALBUM NAME LABEL
        addConstraint(NSLayoutConstraint(item: albumNameLabel, attribute: .leadingMargin, relatedBy: .equal, toItem: albumImageView, attribute: .trailingMargin, multiplier: 1, constant: 25))
        addConstraint(NSLayoutConstraint(item: albumNameLabel, attribute: .topMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .topMargin, multiplier: 1, constant: 5))
        
        //ARTIST NAME LABEL
        addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .leadingMargin, relatedBy: .equal, toItem: albumImageView, attribute: .trailingMargin, multiplier: 1, constant: 25))
        addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .topMargin, relatedBy: .equal, toItem: albumNameLabel, attribute: .bottomMargin, multiplier: 1, constant: 20))
        
        //INFORMATION LOADING LABEL
        addConstraint(NSLayoutConstraint(item: informationLoadingLabel, attribute: .leading, relatedBy: .equal, toItem: cellBackgroundView, attribute: .leading, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: informationLoadingLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .trailingMargin, multiplier: 1, constant: -10))
        addConstraint(NSLayoutConstraint(item: informationLoadingLabel, attribute: .topMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .topMargin, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: informationLoadingLabel, attribute: .bottomMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .bottomMargin, multiplier: 1, constant: 10))
        
        if let accessoryView = self.accessoryView {
            addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: accessoryView, attribute: .leadingMargin, multiplier: 1, constant: -25))
            addConstraint(NSLayoutConstraint(item: albumNameLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: accessoryView, attribute: .leadingMargin, multiplier: 1, constant: -25))
        } else {
            addConstraint(NSLayoutConstraint(item: artistNameLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .trailingMargin, multiplier: 1, constant: -5))
            addConstraint(NSLayoutConstraint(item: albumNameLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .trailingMargin, multiplier: 1, constant: -5))
        }
    }
    
    func updateImage(imageData: Data?) {
        if let imageData = imageData {
            albumImageView.image = UIImage(data: imageData as Data)
        } else {
            albumImageView.image = .none
            albumImageView.layoutMargins = .zero
        }
    }
}
