//
//  AlbumTrackTableViewController.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 05/06/2021.
//

import UIKit

class AlbumTrackTableViewController: UITableViewController {
    
    let tracks: [Track]
    
    init(tracks: [Track], nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!){
        self.tracks = tracks
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "trackCellID")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCellID")!
        cell.textLabel?.text = tracks[indexPath.row].name
        return cell
    }
    
}
