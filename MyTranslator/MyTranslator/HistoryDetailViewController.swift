//
//  HistoryDetailViewController.swift
//  MyTranslator
//
//  Created by 김균환 on 2018. 6. 12..
//  Copyright © 2018년 김균환. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class HistoryDetailViewController: UIViewController, MKMapViewDelegate {
    
    var target: String?
    var ResultText : String?
    var coor : CLLocationCoordinate2D?
    var timestamp : Date?
    
    let date = DateFormatter()
    var kr : String?
    
    let regionRadius: CLLocationDistance = 100
    
    var Datas : [Data] = []
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coor!, regionRadius, regionRadius)
        MapLabel.setRegion(coordinateRegion, animated: true)
    }
    
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var TargetLabel: UILabel!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    
    @IBOutlet weak var TextLabel: UITextView!
    
    @IBOutlet weak var MapLabel: MKMapView!
    
    // MARK: - Table view data source
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Mantle.png")!)
        date.locale = Locale(identifier: "ko_kr")
        date.timeZone = TimeZone(abbreviation: "KST") // "2018-03-21 18:07:27"
        date.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        MapLabel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        kr = date.string(from: timestamp!)
        
        TimeLabel.text = "Time : " + kr!
        TargetLabel.text = "ko -> " + target!
        xLabel.text = "Latitude : " +  (coor?.latitude.description)!
        yLabel.text = "Longitude : " +  (coor?.longitude.description)!
        TextLabel.text = ResultText!
        let initialLocation = CLLocation(latitude: 0, longitude: 0)
        centerMapOnLocation(location: initialLocation)
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
