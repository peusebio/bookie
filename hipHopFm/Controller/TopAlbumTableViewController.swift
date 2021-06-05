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
        title = "HipHop FM"
        
        tableView.prefetchDataSource = self
        tableView.register(AlbumCell.self, forCellReuseIdentifier: "cellId")
        viewModel.fetchAlbums()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! AlbumCell
        
        if indexPath.row >= viewModel.currentAlbumsCount() {
            cell.setup(with: .none)
        } else {
            let album = viewModel.albumAt(index: indexPath.row)
            cell.setup(with: album)
            
            if let albumImage = viewModel.imageData(forHeroAt: indexPath.row){
                cell.updateImage(imageData: albumImage)
            } else {
                cell.updateImage(imageData: .none)
                viewModel.loadAlbumImage(albumIndex: indexPath.row)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.maximumNumberOfAlbumsToFetch()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func fetchCompleted(with newIndexPathsToReload: [IndexPath]?){
        DispatchQueue.main.async {
            guard let newIndexPathsToReload = newIndexPathsToReload else {
                self.tableView.isHidden = false
                self.tableView.reloadData()
                return
            }
            let indexPathsToReload = self.visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
            self.tableView.reloadRows(at: indexPathsToReload, with: .automatic)
        }
    }
    
    func updateAlbumImage(cellRowIndex: Int, thumbnailData: Data) {
        let indexPath = IndexPath(row: cellRowIndex, section: 0)

        if let cell = tableView.cellForRow(at: indexPath) as? AlbumCell {
            cell.updateImage(imageData: thumbnailData)
        }
    }
}

extension AlbumTableViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchAlbums()
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentAlbumsCount()
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

protocol AlbumTableViewControllerDelegate {
    func fetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func updateAlbumImage(cellRowIndex: Int, thumbnailData: Data)
}

