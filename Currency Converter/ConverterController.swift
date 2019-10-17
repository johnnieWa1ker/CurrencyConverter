//
//  ConverterController.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 12.10.2019.
//  Copyright © 2019 Johnnie Walker. All rights reserved.
//

import UIKit

class ConverterController: UIViewController {

    @IBOutlet weak var dateForConverter: UILabel!
    
    // Buttons
    // View info
    @IBOutlet weak var fromCurrencyButtonName: UIButton!
    @IBOutlet weak var toCurrencyButtonName: UIButton!
    
    // Actions
    @IBAction func fromCurrencyButtonAction(_ sender: Any) {
    }
    @IBAction func toCurrencyButtonAction(_ sender: Any) {
    }
    
    // Textfields
    // View info
    @IBOutlet weak var fromCurrencyValue: UITextField!
    @IBOutlet weak var toCurrencyValue: UITextField!
    
    // Actions
    @IBAction func fromCurrencyValueChange(_ sender: Any) {
        let amount = Double(fromCurrencyValue.text!)
        toCurrencyValue.text = Model.shared.convert(amount: amount!)
    }
    @IBAction func toCurrencyValueChange(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func refreshButtons () {
        fromCurrencyButtonName.setTitle(Model.shared.fromCurrency.charCode, for: UIControl.State.normal)
        
        toCurrencyButtonName.setTitle(Model.shared.toCurrency.charCode, for: UIControl.State.normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
         refreshButtons()
        
        toCurrencyValue.isUserInteractionEnabled = false
        
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
