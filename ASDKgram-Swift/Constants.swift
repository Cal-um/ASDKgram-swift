//
//  Constants
//  ASDKgram-Swift
//
//  Created by Calum Harris on 07/01/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//
// swiftlint:disable nesting

import Foundation

struct Constants {

	struct PX500 {
		struct URLS {
			static let Host = "https://api.500px.com/v1/"
			static let PopularEndpoint = "photos?feature=popular&exclude=Nude,People,Fashion&sort=rating&image_size=3&include_store=store_download&include_states=voted"
			static let SearchEndpoint = "photos/search?geo="    //latitude,longitude,radius<units>
			static let UserEndpoint = "photos?user_id="
			static let ConsumerKey = "&consumer_key=Fi13GVb8g53sGvHICzlram7QkKOlSDmAmp9s9aqC"
		}
	}

	struct CellLayout {
		static let FontSize: CGFloat = 14
		static let HeaderHeight: CGFloat = 50
		static let UserImageHeight: CGFloat = 30
		static let HorizontalBuffer: CGFloat = 10
		static let VerticalBuffer: CGFloat = 5
		static let InsetForAvatar = UIEdgeInsets(top: HorizontalBuffer, left: 0, bottom: HorizontalBuffer, right: HorizontalBuffer)
		static let InsetForHeader = UIEdgeInsets(top: 0, left: HorizontalBuffer, bottom: 0, right: HorizontalBuffer)
		static let InsetForFooter = UIEdgeInsets(top: VerticalBuffer, left: HorizontalBuffer, bottom: VerticalBuffer, right: HorizontalBuffer)
	}
}
