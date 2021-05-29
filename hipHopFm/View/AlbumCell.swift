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
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = ContentMode.scaleAspectFill
        return image
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "AvenirNextRegular", size: 22)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    func setup(with album: Album?){
        if let album = album {
            name.text = album.name
        } else {
            name.text = "Loading ..."
        }
    }
    
    override func setupSubviews() {
        addSubview(image)
        addSubview(name)
        
        addConstraint(NSLayoutConstraint(item: image, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: image, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: image, attribute: .bottomMargin, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: -5))
        addConstraint(NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: image, attribute: .height, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: name, attribute: .leadingMargin, relatedBy: .equal, toItem: image, attribute: .trailingMargin, multiplier: 1, constant:25))
        addConstraint(NSLayoutConstraint(item: name, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: name, attribute: .bottomMargin, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: -5))
        addConstraint(NSLayoutConstraint(item: name, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: -5))
    }
    
    func updateImage(imageData: Data?) {
        
        if let imageData = imageData {
            image.image = UIImage(data: imageData as Data)
        } else {
            image.image = .none
        }
    }
}
