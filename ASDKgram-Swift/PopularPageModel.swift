//
//  PopularPageModel.swift
//  ASDKgram-Swift
//
//  Created by Calum Harris on 08/01/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation

class PopularPageModel: NSObject {

	let page: Int
	let totalPages: Int
	let totalNumberOfItems: Int
	let photos: [PhotoModel]

	init?(dictionary: JSONDictionary, photosArray: [PhotoModel]) {
		print("gothere")
		guard let page = dictionary["current_page"] as? Int, let totalPages = dictionary["total_pages"] as? Int, let totalItems = dictionary["total_items"] as? Int else { print("error parsing JSON within PhotoModel Init"); return nil }

		self.page = page
		self.totalPages = totalPages
		self.totalNumberOfItems = totalItems
		self.photos = photosArray
	}
}
