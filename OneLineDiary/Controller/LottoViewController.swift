//
//  LottoViewController.swift
//  OneLineDiary
//
//  Created by 백래훈 on 2023/08/03.
//

import UIKit
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {

    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var timesLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var firstNumberLabel: UILabel!
    @IBOutlet var secondNumberLabel: UILabel!
    @IBOutlet var thirdNumberLabel: UILabel!
    @IBOutlet var fourthNumberLabel: UILabel!
    @IBOutlet var fifthNumberLabel: UILabel!
    @IBOutlet var sixthNumberLabel: UILabel!
    @IBOutlet var bounsNumberLabel: UILabel!
    
    let pickerView = UIPickerView()
    
    var list: [Int] = Array(1...1079).reversed()
//    var lottoNumberList: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        callRequest(drawNo: 1079)
        
    }
    
    func callRequest(drawNo: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drawNo)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                // 로또 날짜
                let date = json["drwNoDate"].stringValue
                // 회차
                let drawTimes = json["drwNo"].intValue
                
                // 로또 번호들
                let firstNumber = json["drwtNo1"].intValue
                let secondNumber = json["drwtNo2"].intValue
                let thirdNumber = json["drwtNo3"].intValue
                let fourthNumber = json["drwtNo4"].intValue
                let fifthNumber = json["drwtNo5"].intValue
                let sixthNumber = json["drwtNo6"].intValue
                let bonusNumber = json["bnusNo"].intValue
                
                self.timesLabel.text = "\(drawTimes) 회차"
                self.dateLabel.text = date
                self.firstNumberLabel.text = "첫 번째 당첨번호: \(firstNumber)"
                self.secondNumberLabel.text = "두 번째 당첨번호: \(secondNumber)"
                self.thirdNumberLabel.text = "세 번째 당첨번호: \(thirdNumber)"
                self.fourthNumberLabel.text = "네 번째 당첨번호: \(fourthNumber)"
                self.fifthNumberLabel.text = "다섯 번째 당첨번호: \(fifthNumber)"
                self.sixthNumberLabel.text = "여섯 번째 당첨번호: \(sixthNumber)"
                self.bounsNumberLabel.text = "보너스 당첨번호: \(bonusNumber)"
                
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // 몇개의 휠?
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 휠안에 몇개의 항목?
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        numberTextField.text = "\(list[row])"
        
        callRequest(drawNo: list[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(list[row])"
    }
    
}
