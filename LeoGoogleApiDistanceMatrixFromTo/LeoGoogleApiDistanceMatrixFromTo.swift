//
//  LeoGoogleApiDistanceMatrixFromTo.swift
//  4MEVoiceMailApp
//
//  Created by vijay vir on 1/19/18.
//  Copyright © 2018 Anupriya. All rights reserved.
//
import Foundation
import CoreLocation
import UIKit
import MapKit
import Alamofire
typealias CompletionBlockLeoGoogleApiDistanceMatrix = (LeoGoogleApiDistanceMatrixFromTo, AnyObject) -> Void
typealias FailureBlockLeoGoogleApiDistanceMatrix = (AnyObject, AnyObject) -> Void
struct LeoGoogleApiDistanceMatrixFromTo {

	static let from = CLLocationCoordinate2D(latitude: 31.1414, longitude: 76.5026)
	static let to = CLLocationCoordinate2D(latitude: 30.7333, longitude: 76.7794)

	static func leoGoogleApiDistanceMatrixFromTo ( from : CLLocationCoordinate2D ,
	                                               to : CLLocationCoordinate2D ,
	                                               completionHandler: CompletionBlockLeoGoogleApiDistanceMatrix? = nil  ,
	                                               failureHandler: FailureBlockLeoGoogleApiDistanceMatrix? = nil )  {

		let stringURL = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=\(from.latitude),\(from.longitude)&destinations=\(to.latitude),\(to.longitude)"

		let url : URL = URL(string: stringURL)!

		Alamofire.request(url,
		                  method: .get
			)
			.responseJSON { response in
				if let json = response.result.value {
					let some = LeoGoogleApiDistanceMatrixFromTo(json: json as! [String : Any])
					completionHandler!(some, response.result as AnyObject)

				} else {

					failureHandler?("" as AnyObject, "" as AnyObject)

				}

			}
			.responseString { _ in

				failureHandler?("" as AnyObject, "" as AnyObject)

				//	print("responseString Success: \(responseString)")

			}
			.responseData { _ in
		}


	}
	struct DestinationAddresses {
		let destinationAddress : String?
		init(json : String ) {
      destinationAddress = json
		}
	}
	struct OriginAddresses {
		let originAddresses : String?
		init(json : String ) {
			originAddresses = json
		}
	}
	struct Row {
		struct Element {
			struct  Distance {
				var text : String?
				var value : Int?
				init(json : [String : Any] ) {
					text = json["text"] as? String
					value = json["value"] as? Int
				}
			}
			struct  Duration {
				var text : String?
				var value : Int?
			init(json : [String : Any] ) {
				text = json["text"] as? String
				value = json["value"] as? Int
				}
			}
			var distance : Distance?
			var duration : Duration?
			init(json : [String : Any] ) {
					if let distanceTemp = json["distance"]  as? [String : Any]  {
           distance = Distance(json: distanceTemp)
				}
				if let durationTemp = json["duration"]  as? [String : Any]  {
					duration = Duration(json: durationTemp)
				}
			}
		}
		var  elements : [Element] = []
		init(json : [String : Any] ) {
			if let elementsTemp = json["elements"]  as? [[String : Any] ] {
				_ = elementsTemp.map({ (element) -> Void in
            let tempElement = Element(json: element)
			  		elements.append(tempElement)
				})
			}
		}
	}
	var destinationAddresses : [DestinationAddresses] = []
	var originAddresses : [OriginAddresses] = []
	var rows : [Row] = []
	init(json : [String: Any]) {
		if let destination_addresses = json["destination_addresses"]  as? [String ] {
		_ = 	destination_addresses.map({ (destination_address) -> Void in
			 let some = DestinationAddresses(json: destination_address)
        destinationAddresses.append(some)
			})
		}
		if let origin_addresses = json["origin_addresses"]  as? [String ] {
			_ = 	origin_addresses.map({ (origin_address) -> Void in
				let some = OriginAddresses(json: origin_address)
				originAddresses.append(some)
			})
		}
		if let tempRows = json["rows"]  as? [ [String :Any] ] {
			_ = 	tempRows.map({ (row) -> Void in
				let some = Row(json: row)
						rows.append(some)
			})
		}
	}
}

/*
LeoGoogleApiDistanceMatrixFromTo.leoGoogleApiDistanceMatrixFromTo(from: LeoGoogleApiDistanceMatrixFromTo.from, to:  LeoGoogleApiDistanceMatrixFromTo.to, completionHandler: { ( leoGoogleApiDistanceMatrixFromTo , _) in
print("🐧🐧🐧🐧🐧🐧" ,leoGoogleApiDistanceMatrixFromTo)
}) { (_, _) in

}
*/



