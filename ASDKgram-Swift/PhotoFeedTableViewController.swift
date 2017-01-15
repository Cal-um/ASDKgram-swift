//
//  PhotoFeedTableViewController.swift
//  ASDKgram-Swift
//
//  Created by Calum Harris on 06/01/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

class PhotoFeedTableViewController: UITableViewController {

	var activityIndicator: UIActivityIndicatorView!
	var photoFeed: PhotoFeedModel

	init() {
		photoFeed = PhotoFeedModel(initWithPhotoFeedModelType: .photoFeedModelTypePopular, requiredImageSize: screenSizeForWidth)
		super.init(nibName: nil, bundle: nil)
		self.navigationItem.title = "UIKit"

	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {

		activityIndicatorConfig()
		tableViewProperties()
		fetchNewBatch()
	}

	func fetchNewBatch() {

		activityIndicator.startAnimating()
		photoFeed.updateNewBatchOfPopularPhotos() { additions, connectionStatus in
			switch connectionStatus {
			case .connected:
				print(additions)
				self.activityIndicator.stopAnimating()
				self.addRowsIntoTableView(newPhotoCount: additions)
			case .noConnection:
				self.activityIndicator.stopAnimating()
				break
			}
		}
	}

	var screenSizeForWidth: CGSize = {
		let screenRect = UIScreen.main.bounds
		let screenScale = UIScreen.main.scale
		return CGSize(width: screenRect.size.width * screenScale, height: screenRect.size.width * screenScale)
	}()

	// helper functions

	func activityIndicatorConfig() {
		let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
		self.activityIndicator = activityIndicator
		self.tableView.addSubview(activityIndicator)
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor)
			])
	}

	func tableViewProperties() {
		tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "photoCell")
		tableView.allowsSelection = false
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = screenSizeForWidth.width + 100
		tableView.separatorStyle = .none
	}
}

extension PhotoFeedTableViewController {

	func addRowsIntoTableView(newPhotoCount newPhotos: Int) {

		let indexRange = (photoFeed.photos.count - newPhotos..<photoFeed.photos.count)
		let indexPaths = indexRange.map { IndexPath(row: $0, section: 0) }
		tableView.insertRows(at: indexPaths, with: .none)
	}

	// TableView Data Source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return photoFeed.photos.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoTableViewCell else { fatalError("Wrong cell type") }
		cell.photoModel = photoFeed.photos[indexPath.row]
		return cell
	}

	override func scrollViewDidScroll(_ scrollView: UIScrollView) {

		let currentOffSetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let screenHeight = UIScreen.main.bounds.size.height
		let screenfullsBeforeBottom = (contentHeight - currentOffSetY) / screenHeight
		if screenfullsBeforeBottom < 2.5 {
				self.fetchNewBatch()
		}
	}
}
