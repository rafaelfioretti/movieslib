//
//  SettingsViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 22/03/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit
import CoreMotion

enum SettingsType: String {
    case colorScheme = "colorscheme"
    case autoplay = "autoplay"
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var ivBG: UIImageView!
    @IBOutlet weak var scColorScheme: UISegmentedControl!
    @IBOutlet weak var swAutoPlay: UISwitch!
    @IBOutlet weak var tfFood: UITextField!
    
    var motionManager = CMMotionManager()
    var pickerView: UIPickerView!
    var dataSource = [
        "Arroz"
        ,"Feijão"
        ,"Batata"
        ,"Macarrao"
        
    ]
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        toolbar.items = [btCancel, btSpace, btDone]

        tfFood.inputView = pickerView
        tfFood.inputAccessoryView = toolbar
        if motionManager.isDeviceMotionAvailable{
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: { (data:
                CMDeviceMotion?, error: Error?) in
                if error == nil{
                    if let data = data{
                        let angle = atan2(data.gravity.x, data.gravity.y) - M_PI
                        self.ivBG.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
                        
                    }
                }
            })
            
        }
        
    }
    
    func cancel(){
        tfFood.resignFirstResponder()
        
    }
    
    func done(){
        tfFood.text = dataSource[pickerView.selectedRow(inComponent: 0)]
        cancel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scColorScheme.selectedSegmentIndex = UserDefaults.standard.integer(forKey: SettingsType.colorScheme.rawValue)
        swAutoPlay.setOn(UserDefaults.standard.bool(forKey: SettingsType.autoplay.rawValue), animated: false)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    
    
    @IBAction func changeColorScheme(_ sender: Any) {
        UserDefaults.standard.set((sender as AnyObject).selectedSegmentIndex, forKey: SettingsType.colorScheme.rawValue)
    }
    
    
    @IBAction func changeAutoPlay(_ sender: Any) {
        UserDefaults.standard.set((sender as AnyObject).isOn, forKey: SettingsType.autoplay.rawValue)
    }

}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}


extension SettingsViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("acabaram de comer..:", dataSource[row])
        //tfFood.text = dataSource[row]
    }
    
    
}

extension SettingsViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    
}






