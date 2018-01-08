//
//  ViewController.swift
//  LeoGoogleSearchPlaces
//
//  Created by vijay vir on 1/8/18.
//  Copyright © 2018 vijay vir. All rights reserved.
//


import Foundation


import UIKit


class ViewController: UIViewController  {


	@IBOutlet var leoGoogleAutoCompleteSearch: LeoGoogleAutoCompleteSearch!
	override func viewDidLoad() {
		super.viewDidLoad()
		leoGoogleAutoCompleteSearch.closureDidUpdateSearchBarWithPredictions = { predictions in

			predictions.map({ (prediction ) -> Void in

				print(prediction.placeId ?? "NG" , "     🚸🚸   " , prediction.description ?? "NG" )
				
			})

		}
		
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

