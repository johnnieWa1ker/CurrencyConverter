//
//  SettingsController.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 15.10.2019.
//  Copyright © 2019 Johnnie Walker. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func pushDoneButton(_ sender: Any) {
        Model.shared.loadXMLFile(date: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
        
//        self.view.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height * 0.5, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
