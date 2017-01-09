//
//  PhotoTableNodeCell.swift
//  ASDKgram-Swift
//
//  Created by Calum Harris on 09/01/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class PhotoTableNodeCell: ASCellNode {
	
	init(photoModel: PhotoModel) {
		super.init()
		self.photoImageNode.url = URL(string: photoModel.url)
		self.avatarImageNode.url = URL(string: photoModel.ownerPicURL)
		let attrs = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 16)!]
		self.usernameLabel.attributedText = NSAttributedString(string: photoModel.ownerUserName, attributes: attrs)
		self.timeIntervalLabel.attributedText = NSAttributedString(string: "24 Hours", attributes: attrs)
		self.photoLikesLabel.attributedText = NSAttributedString(string: String("Likes: \(photoModel.likesCount)"), attributes: attrs)
		self.photoDescriptionLabel.attributedText = NSAttributedString(string: photoModel.descriptionText, attributes: attrs)
		self.automaticallyManagesSubnodes = true
	}
	
	let photoImageNode: ASNetworkImageNode = {
		let imageNode = ASNetworkImageNode()
		imageNode.contentMode = .scaleAspectFill
		imageNode.backgroundColor = .blue
		return imageNode
	}()

	let avatarImageNode: ASNetworkImageNode = {
		let imageNode = ASNetworkImageNode()
		imageNode.contentMode = .scaleAspectFill
		imageNode.backgroundColor = .blue
		return imageNode
	}()
	
	let usernameLabel: ASTextNode = {
		let label = ASTextNode()
		return label
	}()
	
	let timeIntervalLabel: ASTextNode = {
		let label = ASTextNode()
		return label
	}()
	
	let photoLikesLabel: ASTextNode = {
		let label = ASTextNode()
		return label
	}()
	
	let photoDescriptionLabel: ASTextNode = {
		let label = ASTextNode()
		return label
	}()
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		// Header Stack
		
		var headerChildren: [ASLayoutElement] = []
		
		let headerStack = ASStackLayoutSpec.horizontal()
		headerStack.alignItems = .center
		avatarImageNode.style.preferredSize = CGSize(width: 30, height: 30)
		headerChildren.append(ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10), child: avatarImageNode))
		usernameLabel.style.flexShrink = 1.0
		headerChildren.append(usernameLabel)
		
		let spacer = ASLayoutSpec()
		spacer.style.flexGrow = 1.0
		headerChildren.append(spacer)
		
		timeIntervalLabel.style.spacingBefore = 10.0
		headerChildren.append(timeIntervalLabel)
		
		let footerStack = ASStackLayoutSpec.vertical()
		footerStack.spacing = 5.0
		footerStack.children = [photoLikesLabel, photoDescriptionLabel]
		headerStack.children = headerChildren
		
		let verticalStack = ASStackLayoutSpec.vertical()
		
		verticalStack.children = [ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10), child: headerStack), ASRatioLayoutSpec(ratio: 1.0, child: photoImageNode), ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10), child: footerStack)]
		
		return verticalStack
	}
}
