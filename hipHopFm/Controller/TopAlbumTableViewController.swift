//
//  ViewController.swift
//  Bookie
//
//  Created by Pedro Eusébio on 19/05/2021.
//

import UIKit

class TopAlbumTableViewController: UITableViewController, AlbumTableViewControllerDelegate {
    
    let viewModel: TopAlbumTableViewModel
    private var firstAccessoryButtonTapOccurred: Bool = false
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!){
        viewModel = TopAlbumTableViewModel()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        viewModel.setDelegate(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "HipHop FM"
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.prefetchDataSource = self
        tableView.register(TopAlbumCell.self, forCellReuseIdentifier: "cellId")
        tableView.showsVerticalScrollIndicator = false
    
        viewModel.fetchAlbums()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! TopAlbumCell
        
        if indexPath.row >= viewModel.currentAlbumsCount() {
            cell.setup(with: .none, albumPosition: .none)
        } else {
            let album = viewModel.albumAt(index: indexPath.row)
            cell.setup(with: album, albumPosition: indexPath.row + 1)
            if album.mbid.count > 0 {
                cell.accessoryType = .detailButton
            } else {
                cell.accessoryType = .none
            }
            
            if let albumImage = viewModel.imageData(forAlbumAt: indexPath.row){
                cell.updateImage(imageData: albumImage)
            } else {
                cell.updateImage(imageData: .none)
                viewModel.loadAlbumImage(albumIndex: indexPath.row)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let backgroundView = UIView()
        
        let label = UILabel()
        label.text = "Top HipHop Albums"
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(label)
        
        backgroundView.addConstraint(NSLayoutConstraint(item: label, attribute: .leadingMargin, relatedBy: .equal, toItem: backgroundView, attribute: .leadingMargin, multiplier: 1, constant: 10))
        
        backgroundView.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: backgroundView, attribute: .centerY, multiplier: 1, constant: 0))
        
        return backgroundView
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let album = viewModel.albumAt(index: indexPath.row)
        
        let albumMbid = album.mbid
        let artistMbid = album.artist.mbid
        let albumImageData = viewModel.imageData(forAlbumAt: indexPath.row)
        let albumImageUrl = album.image[3].text
        let albumDetailViewController = AlbumDetailViewController(albumMbid: albumMbid, artistMbid: artistMbid, albumName: album.name, artistName: album.artist.name, albumImageData: albumImageData, albumImageUrl: albumImageUrl, nibName: .none, bundle: .none)
        
        navigationController?.pushViewController(albumDetailViewController, animated: false)
        
        userDidTapAlbumCellAccessoryButton()
    }
    
    private func userDidTapAlbumCellAccessoryButton() {
        if(!firstAccessoryButtonTapOccurred){
            firstAccessoryButtonTapOccurred.toggle()
            AppStoreReview.showReviewDialogIfNecessary()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.maximumNumberOfAlbumsToFetch()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
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

        if let cell = tableView.cellForRow(at: indexPath) as? TopAlbumCell {
            cell.updateImage(imageData: thumbnailData)
        }
    }
}

extension TopAlbumTableViewController: UITableViewDataSourcePrefetching {
    
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

