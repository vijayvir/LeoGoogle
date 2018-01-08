//
//  LeoGoogleAutoCompleteSearch.swift
//  LeoGoogleSearchPlaces
//
//  Created by vijay vir on 1/8/18.
//  Copyright © 2018 vijay vir. All rights reserved.
//
// further : https://developers.google.com/places/ios-api/place-id

/*

# Pods for LeoGoogleSearchPlaces
pod 'GooglePlaces'
pod 'GooglePlacePicker'
pod 'GoogleMaps'
pod 'Alamofire'


*/
import Foundation
import GooglePlaces
import Alamofire
import UIKit
typealias LeoGoogleMapACompletionBlock = (AnyObject, AnyObject) -> Void

typealias LeoGoogleMapAFailureBlock = (AnyObject, AnyObject) -> Void

struct LeoGoogleMapsApiPlaceAutocomplete {
	static func get(url: URL,
	               completionHandler: LeoGoogleMapACompletionBlock? = nil,
	               failureHandler: LeoGoogleMapAFailureBlock? = nil) {
		print("🛫🛫🛫🛫🛫🛫🛫 get :", url)

		Alamofire.request(url,
		                  method: .get
			)
			.responseJSON { response in

				print(" get 🛬🛬🛬🛬🛬🛬🛬 " )

				if let json = response.result.value {

					//	print("WebServices : - ", json)

					completionHandler!(json as AnyObject, response.result as AnyObject)

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
	


	struct Prediction {
		var description : String?
		var id : String?
		var placeId : String?
		init(dictionary : NSDictionary) {
			description = dictionary["description"] as? String
			id = dictionary["id"] as? String
			placeId = dictionary["place_id"] as? String
		}
	}
	var predictions: [Prediction] = []
	init(response: AnyObject) {
		if let searchList = response["predictions"] as? [Any] {
			for object in searchList {
				let tempPrediction = Prediction(dictionary: (object as? NSDictionary)!)
				predictions.append(tempPrediction)
			}
		}
	}
}
class LeoGoogleAutoCompleteSearch: NSObject {
	@IBOutlet weak var searchBar: UISearchBar!
	var closureDidUpdateSearchBar : ((LeoGoogleMapsApiPlaceAutocomplete)-> Void)?
	var closureDidUpdateSearchBarWithPredictions : (([LeoGoogleMapsApiPlaceAutocomplete.Prediction])-> Void)?

}
extension LeoGoogleAutoCompleteSearch : UISearchBarDelegate  {
	func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
		return true
	}
	func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {

		return true }
	func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		return true
	}
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { // called when text changes (including clear)
		webserviceSearchBy(text: searchBar.text!)
	}
	func webserviceSearchBy(text : String) {

		let newString = text.replacingOccurrences(of: " ", with: "+")

		let url : URL = URL(string: "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(newString)&key=AIzaSyAVrXmSPxOR56IlDJfPK_ceurWlZJgrpWY")!

		LeoGoogleMapsApiPlaceAutocomplete.get(url: url, completionHandler: { (response, _) in
			let some  : LeoGoogleMapsApiPlaceAutocomplete = LeoGoogleMapsApiPlaceAutocomplete(response: response)
			self.closureDidUpdateSearchBar?(some)
			self.closureDidUpdateSearchBarWithPredictions?(some.predictions)

		}) { (response, _) in

		}

	}

}
//MARK:- Usages

/*
@IBOutlet var leoGoogleAutoCompleteSearch: LeoGoogleAutoCompleteSearch!
override func viewDidLoad() {
super.viewDidLoad()
leoGoogleAutoCompleteSearch.closureDidUpdateSearchBarWithPredictions = { predictions in

predictions.map({ (prediction ) -> Void in

print(prediction.placeId ?? "NG" , "     🚸🚸   " , prediction.description ?? "NG" )

})

}


*/
