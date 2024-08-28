//
//  SectionCell.swift
//  ListUp
//
//  Created by 권희철 on 8/27/24.
//

import UIKit

class SectionCell:UITableViewCell{
    lazy var sectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "questionmark")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(sectionImageView)
        
        NSLayoutConstraint.activate([
            sectionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
