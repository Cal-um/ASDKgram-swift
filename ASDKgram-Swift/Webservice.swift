//
//  Webservice.swift
//  ASDKgram-Swift
//
//  Created by Calum Harris on 06/01/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//
// swiftlint:disable force_cast


import UIKit

final class WebService {
	func load<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> ()) {
		URLSession.shared.dataTask(with: resource.url) { data, response, error in

			// Check for errors in responses.
			let errorCheck = self.checkForNetworkErrors(data, response, error)

			if let data = errorCheck.1 {
				completion(resource.parse(data))
			} else if let error = errorCheck.0 {
				completion(.failure(error))
			}
		}.resume()
	}
}

extension WebService {

	// returns a tuple with .0 as error and .1 as data.
	
	fileprivate func checkForNetworkErrors(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> (NetworkingErrors?, Data?) {
		// Check for errors in responses.
		guard error == nil else {
			if (error as! NSError).domain == NSURLErrorDomain && ((error as! NSError).code == NSURLErrorNotConnectedToInternet || (error as! NSError).code == NSURLErrorTimedOut) {
				return (.noInternetConnection, nil)
			} else {
				return (.returnedError(error!), nil)
			}
		}

		guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
			return (.invalidStatusCode("Request returned status code other than 2xx \(response)"), nil)
		}

		guard let data = data else { return (.dataReturnedNil, nil) }

		return (nil, data)
	}
}

struct Resource<A> {
	let url: URL
	let parse: (Data) -> Result<A>
}

extension Resource {

	init(url: URL, parseJSON: @escaping (Any) -> Result<A>) {
		self.url = url
		self.parse = { data	in
			do {
				let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
				return parseJSON(jsonData)
			} catch {
				fatalError("Error parsing data")
			}
		}
	}
}

enum Result<T> {
	case success(T)
	case failure(NetworkingErrors)
}

enum NetworkingErrors: Error {
	case errorParsingJSON
	case noInternetConnection
	case dataReturnedNil
	case returnedError(Error)
	case invalidStatusCode(String)
	case customError(String)
}
