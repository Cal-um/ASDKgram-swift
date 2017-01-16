//
//  PhotoFeedTableNodeController.swift
//  ASDKgram-Swift
//
//  Created by Calum Harris on 06/01/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import AsyncDisplayKit

class PhotoFeedTableNodeController: ASViewController<ASTableNode> {

	var activityIndicator: UIActivityIndicatorView!
	var photoFeed: PhotoFeedModel

	init() {
		photoFeed = PhotoFeedModel(initWithPhotoFeedModelType: .photoFeedModelTypePopular, requiredImageSize: screenSizeForWidth)
		super.init(node: ASTableNode())
		self.navigationItem.title = "ASDK"

	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		configActivityIndicator()
		node.allowsSelection = false
		node.view.separatorStyle = .none
		node.dataSource = self
		node.delegate = self
		node.view.leadingScreensForBatching = 2.5
		navigationController?.hidesBarsOnSwipe = true

	}

	// helper functions

	func configActivityIndicator() {

		let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
		self.activityIndicator = activityIndicator
		let bounds = self.node.frame
		var refreshRect = activityIndicator.frame
		refreshRect.origin = CGPoint(x: (bounds.size.width - activityIndicator.frame.size.width) / 2.0, y: (bounds.size.height - activityIndicator.frame.size.height) / 2.0)
		activityIndicator.frame = refreshRect
		self.node.view.addSubview(activityIndicator)
	}

	var screenSizeForWidth: CGSize = {
		let screenRect = UIScreen.main.bounds
		let screenScale = UIScreen.main.scale
		return CGSize(width: screenRect.size.width * screenScale, height: screenRect.size.width * screenScale)
	}()

	func fetchNewBatchWithContext(_ context: ASBatchContext?) {

		activityIndicator.startAnimating()
		photoFeed.updateNewBatchOfPopularPhotos() { additions, connectionStatus in
			switch connectionStatus {
			case .connected:
				self.activityIndicator.stopAnimating()
				self.addRowsIntoTableNode(newPhotoCount: additions)
				context?.completeBatchFetching(true)
			case .noConnection:
				self.activityIndicator.stopAnimating()
				if context != nil {
					context!.completeBatchFetching(true)
				}
				break
			}
		}
	}

	func addRowsIntoTableNode(newPhotoCount newPhotos: Int) {
		let indexRange = (photoFeed.photos.count - newPhotos..<photoFeed.photos.count)
		let indexPaths = indexRange.map { IndexPath(row: $0, section: 0) }
		node.insertRows(at: indexPaths, with: .none)
	}
}

extension PhotoFeedTableNodeController: ASTableDataSource, ASTableDelegate {

	func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
		return photoFeed.numberOfItemsInFeed
	}

	func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
		let photo = photoFeed.photos[indexPath.row]
		let nodeBlock: ASCellNodeBlock = { _ in
			return PhotoTableNodeCell(photoModel: photo)
		}
		return nodeBlock
	}

	func shouldBatchFetchForCollectionNode(collectionNode: ASCollectionNode) -> Bool {
		return true
	}

	func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
		fetchNewBatchWithContext(context)
	}
}
