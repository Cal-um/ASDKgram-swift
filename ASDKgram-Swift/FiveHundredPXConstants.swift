//
//  FiveHundredPXConstants.swift
//  ASDKgram-Swift
//
//  Created by Calum Harris on 07/01/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation

struct FiveHundredPXConstants {
	struct URLS {
		static let Host = "https://api.500px.com/v1/"
		static let PopularEndpoint = "photos?feature=popular&exclude=Nude,People,Fashion&sort=rating&image_size=3&include_store=store_download&include_states=voted"
		static let SearchEndpoint = "photos/search?geo="    //latitude,longitude,radius<units>
		static let UserEndpoint = "photos?user_id="
		static let ConsumerKey = "&consumer_key=Fi13GVb8g53sGvHICzlram7QkKOlSDmAmp9s9aqC"
	}
}
