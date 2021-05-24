//
//  ViewController.swift
//  Bookie
//
//  Created by Pedro Eusébio on 19/05/2021.
//

import UIKit

class AlbumTableViewController: UITableViewController, AlbumTableViewControllerDelegate {
    
    let viewModel: AlbumTableViewModel
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!){
        viewModel = AlbumTableViewModel()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        viewModel.setDelegate(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        viewModel.fetchAlbums()
        // Do any additional setup after loading the view.
    }
    
    func reloadData(){
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        let album = viewModel.albumAt(index: indexPath.row)
        cell.textLabel?.text = album.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albumsCount()
    }
    
}

protocol AlbumTableViewControllerDelegate {
    func reloadData()
}

