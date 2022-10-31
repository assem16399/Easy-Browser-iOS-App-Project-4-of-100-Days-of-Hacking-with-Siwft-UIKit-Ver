//
//  WebsitesListViewController.swift
//  Easy Browser
//
//  Created by Aasem Hany on 31/10/2022.
//

import UIKit

class WebsitesListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var websites=[
        "hackingwithswift",
        "google",
        "github"
    ]
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Here")
        if let webviewVC = storyboard?.instantiateViewController(withIdentifier: "Webview") as? WebviewViewController{
            webviewVC.selectedWebsite = websites[indexPath.row]
                  navigationController?.pushViewController(webviewVC, animated: true)
            }

    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCell = tableView.dequeueReusableCell(withIdentifier: "website",for: indexPath)
        
        var cellContentConfig = currentCell.defaultContentConfiguration()

        cellContentConfig.text = websites[indexPath.row]
        
        currentCell.contentConfiguration = cellContentConfig
        
        return currentCell 

    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
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
