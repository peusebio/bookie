//
//  AlbumTrackTableViewController.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 05/06/2021.
//

import UIKit

class AlbumTrackTableViewController: UITableViewController {
    
    let tracks: [Track]
    let cellId = "trackCellId"
    
    let rowHeight: CGFloat = 45
    let tableViewFont = UIFont(name: "Avenir", size: 15)
    
    init(tracks: [Track], nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!){
        self.tracks = tracks
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .clear
        tableView.tableHeaderView = nil
        tableView.tableFooterView = nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel()
        
        view.textColor = Color.artistNameTextColor
        view.font = tableViewFont
        view.text = " 🎵 Track List"
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        rowHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        
        cell.translatesAutoresizingMaskIntoConstraints = false
        
        cell.textLabel?.font = tableViewFont
        cell.textLabel?.text = tracks[indexPath.row].name
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        return cell
    }
    
}
