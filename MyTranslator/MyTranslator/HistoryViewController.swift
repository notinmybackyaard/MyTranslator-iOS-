//
//  PlayersViewController.swift
//  Ratings
//
//  Created by 김균환 on 2018. 4. 9..
//  Copyright © 2018년 김균환. All rights reserved.
//

import UIKit
import CoreLocation

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TableView: UITableView!
    
    var target: String?
    var ResultText : String?
    var coor : CLLocationCoordinate2D?
    var timestamp : Date?
    
    var HistoryDatas:[Data] = HistorySampleData
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailView" {
            if let HistoryDetailViewController = segue.destination as? HistoryDetailViewController,
                let Index = TableView.indexPathForSelectedRow?.row
            {
                HistoryDetailViewController.ResultText = HistoryDatas[Index].text
                HistoryDetailViewController.target = HistoryDatas[Index].target
                HistoryDetailViewController.coor = HistoryDatas[Index].coordinate
                HistoryDetailViewController.timestamp = HistoryDatas[Index].timestamp
            }
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return HistoryDatas.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath)
            as! DataCell
        let HistoryData = HistoryDatas[indexPath.row] as Data
        cell.HistoryData = HistoryData
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Mantle.png")!)
        TableView.delegate = self
        TableView.dataSource = self
        let indexPath = IndexPath(row: HistoryDatas.count-1, section: 0)
        TableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}


/*
//
//  PlayersViewController.swift
//  Ratings
//
//  Created by 김균환 on 2018. 4. 9..
//  Copyright © 2018년 김균환. All rights reserved.
//

import UIKit

class TableViewController: UITableView {
    
    var HistoryDatas:[Data] = HistorySampleData
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return HistoryDatas.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath)
            as! DataCell
        let HistoryData = HistoryDatas[indexPath.row] as Data
        cell.HistoryData = HistoryData
        
        return cell
    }
    
    /*  @IBAction func savePlayerDetail(segue:UIStoryboardSegue) {
     
     if let playerDetailsViewController = segue.source as? PlayerDetailsViewController {
     
     if let player = playerDetailsViewController.player {
     players.append(player)
     
     let indexPath = IndexPath(row: players.count-1, section: 0)
     tableView.insertRows(at: [indexPath], with: .automatic)
     }
     }
     } */
}
*/
