//
//  CustomImageView.swift
//  ASDKgram-Swift
//
//  Created by Calum Harris on 09/01/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {

	var imageUrlString: String?

	func loadImageUsingUrlString(urlString: String) {

		imageUrlString = urlString

		let url = URL(string: urlString)

		image = nil

		if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
			self.image = imageFromCache
			return
		}

		URLSession.shared.dataTask(with: url!, completionHandler: { (data, respones, error) in

			if error != nil {
				print(error!)
				return
			}

			DispatchQueue.main.async {
				let imageToCache = UIImage(data: data!)
				if self.imageUrlString == urlString {
					self.image = imageToCache
				}
				imageCache.setObject(imageToCache!, forKey: urlString as NSString)
			}
		}).resume()
	}
}
