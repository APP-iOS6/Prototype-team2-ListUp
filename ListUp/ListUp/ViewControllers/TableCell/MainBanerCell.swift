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
        URL(string: "https://flyairseoul.com/CM/ko/eventView.do?seq=1797&type=I")!,
        URL(string: "https://www.baskinrobbins.co.kr/play/event/view.php?seq=205&category=ALL")!,
        URL(string: "https://www.shinhansec.com/cms/contents/event/240715_ISAEvent_pc.html")!,
        URL(string: "https://www.hiddenbay.co.kr/gnu/bbs/board.php?bo_table=event&wr_id=59")!,
        URL(string: "https://www.suto.co.kr/bbs/board.php?bo_table=cpevent&wr_id=309377")!,
        URL(string: "https://www.facebook.com/jeonjuncmarket/posts/%EC%97%AC%EB%A6%84%EB%A7%9E%EC%9D%B4-sns%ED%8C%94%EB%A1%9C%EC%9A%B0-%EC%9D%B4%EB%B2%A4%ED%8A%B8-%EC%9D%B4%EB%B2%A4%ED%8A%B8-%EA%B8%B0%EA%B0%84-2024710%EC%88%98-717%EC%88%98-%EC%9D%B4%EB%B2%A4%ED%8A%B8-%EB%8C%80%EC%83%81-%EA%B3%B5%EC%8B%9D-sns-%ED%8C%94%EB%A1%9C%EC%9A%B0-%EA%B3%A0%EA%B0%9D-%EC%9D%B8%EC%8A%A4%ED%83%80%EA%B7%B8%EB%9E%A8%ED%8E%98%EC%9D%B4%EC%8A%A4%EB%B6%81-%EC%B0%B8%EC%97%AC%EB%B0%A9%EB%B2%95-1-%EA%B3%B5%EC%8B%9D-sn/348503028294235/")!,
        URL(string: "https://www.giantzplay.com/forum/view/1007301")!
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
