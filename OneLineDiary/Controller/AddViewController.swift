//
//  ViewController.swift
//  OneLineDiary
//
//  Created by 백래훈 on 2023/07/31.
//

import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        
        title = "추가화면"
        
        let xmark = UIImage(systemName: "xmark")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func closeButtonClicked() {
        // Present - Dismiss
        dismiss(animated: true)
        
    }

}

