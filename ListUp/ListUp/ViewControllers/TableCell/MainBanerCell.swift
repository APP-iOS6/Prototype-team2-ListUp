//
//  MainBanerCell.swift
//  ListUp
//
//  Created by 권희철 on 8/27/24.
//

import UIKit

class MainBanerCell: UITableViewCell{
    
    var imageTappedAction: ((URL) -> Void)? // 클릭 시 URL을 얻는 클로저
    
    lazy var bannerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: 3600, height: 300)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var bannerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        //stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let banners: [UIImage] = [.mainimage1, .mainimage2, .mainimage3, .mainimage4, .mainimage5, .mainimage6, .mainimage7]
    
    let bannerURLs: [URL] = [
        URL(string: "https://shop-events.interpark.com/exhibition?exhibitionCode=230620008")!,
        URL(string: "https://commevent.interpark.com/event/338089.do")!,
        URL(string: "https://mfront.homeplus.co.kr/")!,
        URL(string: "https://www.coupang.com/")!,
        URL(string: "https://store.cafe24.com/kr/apps/11813")!,
        URL(string: "https://www.koreamint.com/main/index.do")!,
        URL(string: "https://images.homeplus.co.kr/static/renew/event/promotion/130613-stamp/iframe_src.html")!
    ] // 배너이미지에 대응하는 URL
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //contentView.backgroundColor = .blue
        
        contentView.addSubview(bannerScrollView)
        bannerScrollView.addSubview(bannerStackView)
        
        for (index, image) in banners.enumerated(){
            let button = UIButton()
            button.setImage(image, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.tag = index // 버튼에 인덱스 태그를 추가, 연결되는 URL 식별
            
            button.addTarget(self, action: #selector(imageTapped(_:)), for: .touchUpInside)
            
            bannerStackView.addArrangedSubview(button)
            
            button.imageView?.translatesAutoresizingMaskIntoConstraints = false
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.imageView!.heightAnchor.constraint(equalToConstant: 300),
                button.imageView!.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                button.heightAnchor.constraint(equalToConstant: 300),
                button.widthAnchor.constraint(equalTo: contentView.widthAnchor)
            ])
        }

            NSLayoutConstraint.activate([
                bannerScrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
                bannerScrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                bannerScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                bannerScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ])
        }
    @objc private func imageTapped(_ sender: UIButton) {
        let url = bannerURLs[sender.tag]
        imageTappedAction?(url) //클로저 호출
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
