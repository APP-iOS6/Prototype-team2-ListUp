//
//  MainCollectionCell.swift
//  ListUp
//
//  Created by 권희철 on 8/27/24.
//

import UIKit

class MainCollectionCell: UICollectionViewCell{
    public var mainIamgeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .subimage1
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 33
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public var heartImageView: UIButton = {
        let button = UIButton()
        button.setImage(.heartfull, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public var mainTextLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .black
        return label
    }()
    
    public var hashTagTextLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .red
        return label
    }()
    
    public var dateTextLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .gray
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
        
        stackView.addArrangedSubview(mainIamgeView)
        stackView.addArrangedSubview(mainTextLabel)
        stackView.addArrangedSubview(hashTagTextLabel)
        stackView.addArrangedSubview(dateTextLabel)
        stackView.addSubview(heartImageView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            mainIamgeView.heightAnchor.constraint(equalToConstant: 159),
            
            heartImageView.topAnchor.constraint(equalTo: stackView.topAnchor),
            heartImageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            heartImageView.widthAnchor.constraint(equalToConstant: 24),
            heartImageView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
