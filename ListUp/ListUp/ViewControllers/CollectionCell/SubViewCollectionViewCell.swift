//
//  SubViewCollectionViewCell.swift
//  ListUp
//
//  Created by 최승호 on 8/27/24.
//

import UIKit

class SubViewCollectionViewCell: UICollectionViewCell {
    public var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "subimage1")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 33
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public var heartImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heart"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    public var mainTextLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .blackFontColor
        
        return label
    }()
    
    public var hashTagTextLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .redFontColor
        
        return label
    }()
    
    public var dateTextLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .grayFontColor
        
        return label
    }()
    
    public var imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    public var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        
        stackView.addArrangedSubview(mainImageView)
        stackView.addArrangedSubview(mainTextLabel)
        stackView.addArrangedSubview(hashTagTextLabel)
        stackView.addArrangedSubview(dateTextLabel)
        stackView.addSubview(heartImageView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0),
            
            mainImageView.heightAnchor.constraint(equalToConstant: 159),
            
            heartImageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0),
            heartImageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -0),
            heartImageView.widthAnchor.constraint(equalToConstant: 24),
            heartImageView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
