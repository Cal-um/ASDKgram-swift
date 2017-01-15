//
//  URL.swift
//  ASDKgram-Swift
//
//  Created by Calum Harris on 07/01/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation

extension URL {

	static func URLForFeedModelType(feedModelType: PhotoFeedModelType) -> URL {
		switch feedModelType {
		case .photoFeedModelTypePopular:
			return URL(string: assemble500PXURLString(endpoint: FiveHundredPXConstants.URLS.PopularEndpoint))!

		case .photoFeedModelTypeLocation:
			return URL(string: assemble500PXURLString(endpoint: FiveHundredPXConstants.URLS.SearchEndpoint))!

		case .photoFeedModelTypeUserPhotos:
			return URL(string: assemble500PXURLString(endpoint: FiveHundredPXConstants.URLS.UserEndpoint))!
		}
	}

	private static func assemble500PXURLString(endpoint: String) -> String {
		return FiveHundredPXConstants.URLS.Host + endpoint + FiveHundredPXConstants.URLS.ConsumerKey
	}

	mutating func addImageParameterForClosestImageSizeAndpage(size: CGSize, page: Int) -> URL {

		let imageParameterID: Int

		if size.height <= 70 {
			imageParameterID = 1
		} else if size.height <= 100 {
				imageParameterID = 100
		} else if size.height <= 140 {
				imageParameterID = 2
		} else if size.height <= 200 {
				imageParameterID = 200
		} else if size.height <= 280 {
				imageParameterID = 3
		} else if size.height <= 400 {
				imageParameterID = 400
		} else {
				imageParameterID = 600
		}

		var urlString = self.absoluteString
		urlString.append("&image_size=\(imageParameterID)&page=\(page)")

		return URL(string: urlString)!
	}

}
