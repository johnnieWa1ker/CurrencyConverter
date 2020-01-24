//
//  CoursesViewController.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 14.01.2020.
//  Copyright © 2020 Johnnie Walker. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var baseCurrencyCharLabel: UILabel!
    @IBOutlet weak var conversionCurrencyCharLabel: UILabel!
    @IBOutlet weak var coursesTable: UITableView!
    
    // MARK: IBAction
    @IBAction func changeDateAction(_ sender: Any) {
    }
    @IBAction func reloadDataAction(_ sender: Any) {
    }
    @IBAction func replaceCurrencyAction(_ sender: Any) {
    }
    
    var presenter: CoursesViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "CurrencyCell", bundle: nil)
        coursesTable.register(nib, forCellReuseIdentifier: "CurrencyCell")
        
        self.presenter?.getCurrency()
    }
}

extension CoursesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        
        guard presenter?.conversionCurrencyValue != nil else { return cell }
        
        cell.configureCell(baseCurrencyValue: presenter?.baseCurrencyValue[indexPath.row], conversionCurrencyValue: presenter?.conversionCurrencyValue![indexPath.row])
        
        return cell
    }
}

extension CoursesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt \(indexPath.row)")
    }
}


extension CoursesViewController: CoursesViewProtocol {
    
    func success() {
        
        baseCurrencyCharLabel.text = presenter?.baseCurrency?.charCode
        conversionCurrencyCharLabel.text = presenter?.conversionCurrency?.charCode
        
        coursesTable.reloadData()
    }
    
    func failure(error: Error) {
        print("\(error.localizedDescription)")
    }
}
