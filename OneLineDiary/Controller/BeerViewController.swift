//
//  BeerViewController.swift
//  OneLineDiary
//
//  Created by 백래훈 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class BeerViewController: UIViewController {
    
    @IBOutlet var beerImage: UIImageView!
    @IBOutlet var beerName: UILabel!
    @IBOutlet var beerKind: UILabel!
    @IBOutlet var beerDetailInfo: UILabel!
    @IBOutlet var randomBeerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
    }
    
    @IBAction func randomButtonClicked(_ sender: UIButton) {
        callRequest()
    }
    
    func callRequest() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let beerImage = json[0]["image_url"].stringValue
                let beerName = json[0]["name"].stringValue
                let beerKind = json[0]["tagline"].stringValue
                let beerDetailInfo = json[0]["description"].stringValue
                
                self.beerName.font = .systemFont(ofSize: 18, weight: .bold)
                self.beerName.text = beerName
                
                self.beerKind.font = .systemFont(ofSize: 15, weight: .medium)
                self.beerKind.text = beerKind
                
                self.beerDetailInfo.font = .systemFont(ofSize: 13, weight: .regular)
                self.beerDetailInfo.text = beerDetailInfo
                
                self.randomBeerButton.layer.borderColor = UIColor.black.cgColor
                self.randomBeerButton.layer.borderWidth = 1
                self.randomBeerButton.layer.cornerRadius = 5
                
                guard let url = URL(string: beerImage) else { return self.beerImage.image = nil }
                
                DispatchQueue.global().async {
                    guard let data = try? Data(contentsOf: url) else { return }
                    DispatchQueue.main.async {
                        self.beerImage.image = UIImage(data: data)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
