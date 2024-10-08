//
//  ShoppingmallListCel.swift
//  ListUp
//
//  Created by 권희철 on 8/27/24.
//

import UIKit


class ShoppingmallListCell: UITableViewCell{
    lazy var listScrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: 850, height: 80)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var listStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var shoppingmalls: [UIImage] = []
    
    lazy var buttonAction: ()-> () = {}
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(listScrollView)
        listScrollView.addSubview(listStackView)
        
        for i in 1...9{
            if let image = UIImage(named: "mallicon\(i)"){
                shoppingmalls.append(image)
            }
        }
        
        for image in shoppingmalls{
            let button = UIButton()
            button.setImage(image, for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
            button.layer.cornerRadius = 8
            button.imageView?.layer.cornerRadius = 8
            button.addAction(UIAction{ _ in
                self.buttonAction()
                    
            }, for: .touchUpInside)
            
            listStackView.addArrangedSubview(button)
            
            button.imageView?.translatesAutoresizingMaskIntoConstraints = false
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.imageView!.heightAnchor.constraint(equalToConstant: 80),
                button.imageView!.widthAnchor.constraint(equalToConstant: 80),
                button.heightAnchor.constraint(equalToConstant: 80),
                button.widthAnchor.constraint(equalToConstant: 80)
            ])
            
        }
        
        NSLayoutConstraint.activate([
            listScrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            listScrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            listScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            listScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listScrollView.heightAnchor.constraint(equalToConstant: 80)

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
