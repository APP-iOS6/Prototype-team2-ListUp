//
//  AlarmButtonCollectionViewCell.swift
//  ListUp
//
//  Created by 권희철 on 8/28/24.
//

import UIKit

class AlarmButtonCollectionViewCell: UICollectionViewCell {
    
    var buttonAction: () -> () = {}
    
    var buttonSelected:Bool = false{
        didSet{
            self.checkImageView.isHidden = !self.buttonSelected
        }
    }
    
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.red.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(identifier: .init("Check")){_ in
            self.buttonAction()
        }, for: .touchUpInside)
        
        return button
    }()
    
    lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .checkbox
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: 6, height: 6)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = !self.buttonSelected
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buttonSelected = false
        contentView.addSubview(button)
        contentView.addSubview(checkImageView)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            checkImageView.topAnchor.constraint(equalTo: button.topAnchor, constant: -3),
            checkImageView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 3),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //self.buttonSelected = false
    }
}
