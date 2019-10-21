//
//  ConverterController.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 12.10.2019.
//  Copyright © 2019 Johnnie Walker. All rights reserved.
//

import UIKit

class ConverterController: UIViewController {
    
    // Buttons that change currency
    @IBOutlet weak var fromCurrencyButtonOutlet: UIButton!
    @IBOutlet weak var toCurrencyButtonOutlet: UIButton!
    @IBAction func fromCurrencyButtonAction(_ sender: Any) {
        let ns = storyboard?.instantiateViewController(identifier: "selectedCurrencyNSID") as! UINavigationController
        (ns.viewControllers[0] as! СhangeCurrencyController).flagCurrency = .from
        ns.modalPresentationStyle = .fullScreen
    }
    @IBAction func toCurrencyButtonAction(_ sender: Any) {
        let ns = storyboard?.instantiateViewController(identifier: "selectedCurrencyNSID") as! UINavigationController
        (ns.viewControllers[0] as! СhangeCurrencyController).flagCurrency = .to
        ns.modalPresentationStyle = .fullScreen
    }
    
    // Textfields with currency value
    @IBOutlet weak var fromCurrencyValueOutlet: UITextField!
    @IBOutlet weak var toCurrencyValueOutlet: UITextField!
    @IBAction func fromCurrencyValueChange(_ sender: Any) {
        let amount = Double(fromCurrencyValueOutlet.text!)
        if amount != nil {
            toCurrencyValueOutlet.text = String(Model.shared.convert(amount: amount))
        } else {
            toCurrencyValueOutlet.text = ""
        }
        
    }
    @IBAction func toCurrencyValueChange(_ sender: Any) {
    }
    
    // Button that hides the keyboard
    @IBOutlet weak var buttonDoneOutlet: UIBarButtonItem!
    @IBAction func pushDoneAction(_ sender: Any) {
        fromCurrencyValueOutlet.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromCurrencyValueOutlet.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func refreshButtons () {
        fromCurrencyButtonOutlet.setTitle(Model.shared.fromCurrency.charCode, for: UIControl.State.normal)
        toCurrencyButtonOutlet.setTitle(Model.shared.toCurrency.charCode, for: UIControl.State.normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshButtons()
        toCurrencyValueOutlet.isUserInteractionEnabled = false
        fromCurrencyValueChange(self)
    }
}

extension ConverterController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        navigationItem.rightBarButtonItem = buttonDoneOutlet
        return true
    }
}
