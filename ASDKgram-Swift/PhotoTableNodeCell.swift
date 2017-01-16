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
		self.usernameLabel.attributedText = photoModel.attrStringForUserName(withSize: Constants.CellLayout.FontSize)
		self.timeIntervalLabel.attributedText = photoModel.attrStringForTimeSinceString(withSize: Constants.CellLayout.FontSize)
		self.photoLikesLabel.attributedText = photoModel.attrStringLikes(withSize: Constants.CellLayout.FontSize)
		self.photoDescriptionLabel.attributedText = photoModel.attrStringForDescription(withSize: Constants.CellLayout.FontSize)
		self.automaticallyManagesSubnodes = true
	}

	let photoImageNode: ASNetworkImageNode = {
		let imageNode = ASNetworkImageNode()
		imageNode.contentMode = .scaleAspectFill
		return imageNode
	}()

	var avatarImageNode: ASNetworkImageNode = {
		let imageNode = ASNetworkImageNode()
		imageNode.contentMode = .scaleAspectFill
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
		avatarImageNode.style.preferredSize = CGSize(width: Constants.CellLayout.UserImageHeight, height: Constants.CellLayout.UserImageHeight)
		headerChildren.append(ASInsetLayoutSpec(insets: Constants.CellLayout.InsetForAvatar, child: avatarImageNode))
		usernameLabel.style.flexShrink = 1.0
		headerChildren.append(usernameLabel)

		let spacer = ASLayoutSpec()
		spacer.style.flexGrow = 1.0
		headerChildren.append(spacer)

		timeIntervalLabel.style.spacingBefore = Constants.CellLayout.HorizontalBuffer
		headerChildren.append(timeIntervalLabel)

		let footerStack = ASStackLayoutSpec.vertical()
		footerStack.spacing = Constants.CellLayout.VerticalBuffer
		footerStack.children = [photoLikesLabel, photoDescriptionLabel]
		headerStack.children = headerChildren

		let verticalStack = ASStackLayoutSpec.vertical()

		verticalStack.children = [ASInsetLayoutSpec(insets: Constants.CellLayout.InsetForHeader, child: headerStack), ASRatioLayoutSpec(ratio: 1.0, child: photoImageNode), ASInsetLayoutSpec(insets: Constants.CellLayout.InsetForFooter, child: footerStack)]

		return verticalStack
	}
}
