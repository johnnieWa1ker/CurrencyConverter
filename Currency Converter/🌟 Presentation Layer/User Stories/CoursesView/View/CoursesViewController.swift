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
    @IBOutlet weak var coursesTable: UITableView!
    @IBOutlet weak var baseCurrency: UILabel!
    @IBOutlet weak var currencyConversion: UILabel!
    
    // MARK: IBAction
    @IBAction func changeDateAction(_ sender: Any) {
    }
    @IBAction func reloadDataAction(_ sender: Any) {
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
        
        cell.setupView()
        
        print(presenter?.currency?[11])
        
        cell.configureCell(baseCurrency: (presenter?.currency![11].valueDouble)!, currencyConversion: (presenter?.currency?[12].valueDouble)!)
        
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
        coursesTable.reloadData()
        
        // Поместить char коды в label
//        baseCurrency.text = presenter?.currency?[11].valueDouble
//        currencyConversion.text = presenter?.currency?[12].valueDouble
        
        presenter?.calculateCurrencyRatio(baseCurrency: (presenter?.currency?[11])!, currencyConversion: (presenter?.currency?[12])!)
    }
    
    func failure(error: Error) {
        print("\(error.localizedDescription)")
    }
}
