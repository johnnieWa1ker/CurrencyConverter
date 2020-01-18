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
    
    var presenter: CoursesViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: IBAction
    @IBAction func previousValueAction(_ sender: Any) {
        
    }
    
    @IBAction func reloadDataAction(_ sender: Any) {
    }
    
}

extension CoursesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.currency?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currency = presenter.currency?[indexPath.row]
        cell.textLabel?.text = currency?.name
        return cell
    }
}


extension CoursesViewController: CoursesViewProtocol {
    func success() {
        
    }
    
    func failure(error: Error) {
        
    }
}
