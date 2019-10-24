//
//  CoursesController.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 12.10.2019.
//  Copyright © 2019 Johnnie Walker. All rights reserved.
//

import UIKit

class CoursesController: UITableViewController {

    @IBOutlet weak var changeDataButton: UIBarButtonItem!
    @IBAction func refreshDataButton(_ sender: Any) {
        Model.shared.loadXMLFile(date: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Received a message about the start of data loading
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "startLoadingXML"), object : nil, queue: nil) { (Notification) in
            
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                
                // MARK: Not work (((
                // Run loader when updating data
                let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
                activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
                activityIndicator.color = UIColor.red
                activityIndicator.startAnimating()
                strongSelf.navigationItem.rightBarButtonItem?.customView = activityIndicator
            }
        }
        
        // MARK: Received a data load message
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dataRefreshed"), object: nil, queue: nil) { (Notification) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let strongSelf = self else { return }
                
                strongSelf.tableView.reloadData()
                
                // Set text to title
                let titleTextOfCoursesScreen = "Курс на " + Model.shared.dateFromFile
                strongSelf.navigationItem.title = titleTextOfCoursesScreen
                
                // Stop loader after updating data
                let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: strongSelf, action: #selector(strongSelf.refreshDataButton(_:)))
                strongSelf.navigationItem.rightBarButtonItem = refreshButton
            }
            
//            DispatchQueue.main.async { [weak self] in
//                guard let strongSelf = self else { return }
//
//                strongSelf.tableView.reloadData()
//
//                // Set text to title
//                let titleTextOfCoursesScreen = "Курс на " + Model.shared.dateFromFile
//                strongSelf.navigationItem.title = titleTextOfCoursesScreen
//
//                // Stop loader after updating data
//                let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: strongSelf, action: #selector(strongSelf.refreshDataButton(_:)))
//                strongSelf.navigationItem.rightBarButtonItem = refreshButton
//            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("SomeExternalError"), object: nil, queue: nil) { (Notification) in
            
            let errorName = Notification.userInfo?["ErrorName"]
            print(errorName!)
            DispatchQueue.main.async {
                
                let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(self.refreshDataButton(_:)))
                self.navigationItem.rightBarButtonItem = refreshButton
            }
        }
        
        navigationItem.title = Model.shared.dateFromFile
        
        Model.shared.loadXMLFile(date: nil)
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return Model.shared.currencies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CourseCell

        let courseForCell = Model.shared.currencies[indexPath.row]
        cell.initCell(currency: courseForCell)
        
        return cell
    }
    
    @IBOutlet weak var titleOfCourses: UINavigationItem!
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
