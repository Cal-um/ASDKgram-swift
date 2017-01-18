//
//  UIImage.swift
//  ASDKgram-Swift
//
//  Created by Calum Harris on 18/01/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

// This extension was copied directly from LayoutSpecExamples-Swift. It is an example of how to create Precomoposed Alpha Corners. I have used the helper ASImageNodeRoundBorderModificationBlock:boarderWidth:boarderColor function in practice which does the same.

extension UIImage {
	
	func makeCircularImage(size: CGSize, borderWidth width: CGFloat) -> UIImage {
		// make a CGRect with the image's size
		let circleRect = CGRect(origin: .zero, size: size)
		
		// begin the image context since we're not in a drawRect:
		UIGraphicsBeginImageContextWithOptions(circleRect.size, false, 0)
		
		// create a UIBezierPath circle
		let circle = UIBezierPath(roundedRect: circleRect, cornerRadius: circleRect.size.width * 0.5)
		
		// clip to the circle
		circle.addClip()
		
		UIColor.white.set()
		circle.fill()
		
		// draw the image in the circleRect *AFTER* the context is clipped
		self.draw(in: circleRect)
		
		// create a border (for white background pictures)
		if width > 0 {
			circle.lineWidth = width;
			UIColor.white.set()
			circle.stroke()
		}
		
		// get an image from the image context
		let roundedImage = UIGraphicsGetImageFromCurrentImageContext();
		
		// end the image context since we're not in a drawRect:
		UIGraphicsEndImageContext();
		
		return roundedImage ?? self
	}
}
