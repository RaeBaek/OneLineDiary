//
//  LottoViewController.swift
//  OneLineDiary
//
//  Created by 백래훈 on 2023/08/03.
//

import UIKit

class LottoViewController: UIViewController {

    @IBOutlet var numberTextField: UITextField!
    
    let pickerView = UIPickerView()
    
    var list: [Int] = Array(1...1100).reversed()
    var list2 = Array(repeating: 100, count: 100)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
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
        print("select \(row)")
        
        numberTextField.text = "\(list[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(list[row])"
    }
    
}
