//
//  SettingsViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 22/03/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit

enum SettingsType: String {
    case colorScheme = "colorscheme"
    case autoplay = "autoplay"
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var scColorScheme: UISegmentedControl!
    @IBOutlet weak var swAutoPlay: UISwitch!
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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






