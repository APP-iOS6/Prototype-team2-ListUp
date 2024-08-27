//
//  TopImageCollectionViewCell.swift
//  ListUp
//
//  Created by 최승호 on 8/27/24.
//

import UIKit

class TopImageCollectionViewCell: UICollectionViewCell {
    public lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "long_bookmark")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topImageView)
        
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            topImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -0),
            topImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            topImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0),
            
//            topImageView.heightAnchor.constraint(equalToConstant: 159),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
