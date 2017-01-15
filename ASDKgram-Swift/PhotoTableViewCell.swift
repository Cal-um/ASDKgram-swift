//
//  PhotoTableViewCell.swift
//  ASDKgram-Swift
//
//  Created by Calum Harris on 08/01/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

	var photoModel: PhotoModel? {
		didSet {
			if let url = photoModel?.url, let avatarURL = photoModel?.ownerPicURL, let likes = photoModel?.likesCount {
				print("image loaded")
				photoImageView.loadImageUsingUrlString(urlString: url)
				avatarImageView.loadImageUsingUrlString(urlString: avatarURL)
				photoLikesLabel.text = "Likes: \(likes)"
			}
			usernameLabel.text = photoModel?.ownerUserName
			timeIntervalLabel.text = "24 hours ago"
			photoDescriptionLabel.text = photoModel?.descriptionText
		}
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	let photoImageView: CustomImageView = {
		let imageView = CustomImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.backgroundColor = .blue
		return imageView
	}()

	let avatarImageView: CustomImageView = {
		let imageView = CustomImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.backgroundColor = .blue
		return imageView
	}()

	let usernameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let timeIntervalLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let photoLikesLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let photoDescriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	func setupViews() {
		addSubview(photoImageView)
		addSubview(avatarImageView)
		addSubview(usernameLabel)
		addSubview(timeIntervalLabel)
		addSubview(photoLikesLabel)
		addSubview(photoDescriptionLabel)
		setupConstraints()
	}

	func setupConstraints() {

		NSLayoutConstraint.activate ([
			//photoImageView
			photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
			photoImageView.widthAnchor.constraint(equalTo: widthAnchor),
			photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
			// avatarImageView
			avatarImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
			avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			avatarImageView.heightAnchor.constraint(equalToConstant: 30),
			avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
			// usernameLabel
			usernameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 10),
			usernameLabel.rightAnchor.constraint(equalTo: timeIntervalLabel.leftAnchor, constant: -10),
			usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
			// timeIntervalLabel
			timeIntervalLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
			timeIntervalLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
			// photoLikesLabel
			photoLikesLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 5),
			photoLikesLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
			// photoDescriptionLabel
			photoDescriptionLabel.topAnchor.constraint(equalTo: photoLikesLabel.bottomAnchor, constant: 5),
			photoDescriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
			photoDescriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -10),
			photoDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
		])
	}
}
