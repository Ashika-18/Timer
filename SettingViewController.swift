//
//  SettingViewController.swift
//  Timer
//
//  Created by ホセ・ゴンザレス on 2023/04/09.
//

import UIKit

class SettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let settingArray : [Int] = [10, 20, 30, 40, 50, 60]
    
    let settingKey = "timer_value"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        timerSettingPicker.delegate = self
        timerSettingPicker.dataSource = self
        
        let settings = UserDefaults.standard
        
        let timerValue = settings.integer(forKey: settingKey)
        
        for row in 0..<settingArray.count {
            
            if settingArray[row] == timerValue {
                
                timerSettingPicker.selectRow(row, inComponent: 0, animated: true)
                
            }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var timerSettingPicker: UIPickerView!
    
    @IBAction func decisionButton(_ sender: Any) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settingArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(settingArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let settings = UserDefaults.standard
        
        settings.setValue(settingArray[row], forKey: settingKey)
        
        settings.synchronize()
    }
}
