//
//  PhotoModel.swift
//  ASDKgram-Swift
//
//  Created by Calum Harris on 07/01/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String : Any]

class PhotoModel: NSObject {
	
	let url: String
	let photoID: Int
	let uploadDateString: String
	let descriptionText: String
	let likesCount: Int
	let ownerUserName: String
	let ownerPicURL: String
	
	
	init?(dictionary: JSONDictionary) {
		
		guard let url = dictionary["image_url"] as? String, let date = dictionary["created_at"] as? String, let photoID = dictionary["id"] as? Int, let descriptionText = dictionary["name"] as? String, let likesCount = dictionary["positive_votes_count"] as? Int else { print("error parsing JSON within PhotoModel Init"); return nil }
		
		guard let user = dictionary["user"] as? JSONDictionary, let username = user["username"] as? String, let ownerPicURL = user["userpic_url"] as? String else { print("error parsing JSON within PhotoModel Init"); return nil }
		
		self.url = url
		self.photoID = photoID
		self.descriptionText = descriptionText
		self.likesCount = likesCount
		self.uploadDateString = date
		self.ownerUserName = username
		self.ownerPicURL = ownerPicURL
	}
}
