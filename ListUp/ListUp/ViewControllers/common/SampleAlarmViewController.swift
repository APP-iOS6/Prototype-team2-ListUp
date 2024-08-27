//
//  SampleAlarmViewController.swift
//  ListUp
//
//  Created by 최승호 on 8/27/24.
//

import UIKit
import SafariServices

class SampleAlarmViewController: UIViewController {

    lazy var sampleAlarmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "listalarm")
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(clickAlarm)))
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(sampleAlarmImageView)
        sampleAlarmImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sampleAlarmImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sampleAlarmImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sampleAlarmImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sampleAlarmImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc func clickAlarm(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: "https://www.naver.com") {
            let vc = SFSafariViewController(url: url)
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }

}
