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
    
    // MARK: IBAction
    @IBAction func changeDateAction(_ sender: Any) {
    }
    @IBAction func reloadDataAction(_ sender: Any) {
    }
    
    var presenter: CoursesViewPresenterProtocol?
    
//    Тестовый объект для проверки ошибки forceunwrap
//    let testCurrency = Currency(numCode: 1, charCode: "TES", nominal: "1.0", nominalDouble: 1.0, name: "Test currency", value: "1.0", valueDouble: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coursesTable.register(CurrencyCell.self, forCellReuseIdentifier: "currencyCell")
        self.presenter?.getCurrency()
    }
}

extension CoursesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.currency?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyCell
        let currency = presenter?.currency?[indexPath.row]
        
        cell.configureCell(currency: currency)
        
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
    }
    
    func failure(error: Error) {
        print("\(error.localizedDescription)")
    }
}
