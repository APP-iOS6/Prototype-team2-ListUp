//
//  MainBanerCell.swift
//  ListUp
//
//  Created by 권희철 on 8/27/24.
//

import UIKit

class MainBanerCell: UITableViewCell{
    lazy var bannerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: 3600, height: 300)
        scrollView.translatesAutoresizingMaskIntoConstraints = true
        //scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    lazy var bannerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        //stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let banners: [UIImage] = [.mainimage1, .mainimage2, .mainimage3, .mainimage4, .mainimage5, .mainimage6, .mainimage7]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .blue
        
        contentView.addSubview(bannerScrollView)
        bannerScrollView.addSubview(bannerStackView)
        
        for image in banners{
            let button = UIButton()
            button.setImage(image, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            bannerStackView.addArrangedSubview(button)
            
            button.imageView?.translatesAutoresizingMaskIntoConstraints = false
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.imageView!.heightAnchor.constraint(equalToConstant: 300),
                button.imageView!.widthAnchor.constraint(equalToConstant: 500),
                button.heightAnchor.constraint(equalToConstant: 300),
                button.widthAnchor.constraint(equalToConstant: 500)
            ])
        }

            NSLayoutConstraint.activate([
                bannerScrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
                bannerScrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                bannerScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                bannerScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ])
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
