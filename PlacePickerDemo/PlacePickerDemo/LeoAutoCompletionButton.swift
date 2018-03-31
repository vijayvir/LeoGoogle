//
//  LeoAutoCompletionButton.swift
//  PlacePickerDemo
//
//  Created by Anupriya on 12/10/17.
//  Copyright © 2017 Anupriya. All rights reserved.
//

import UIKit
import GooglePlaces

extension AppDelegate {
    func googlePlacesConfigure() {
        GMSPlacesClient.provideAPIKey("AIzaSyA0fsUa44bbtcu5SwuB7D2usCf9srpdT-I") // GraySoon
        
    }
}
class LeoAutoCompletionButton : UIButton {

    @IBOutlet var presentOn :UIViewController?
    
    var  closureDidAutocompleteWith : ((GMSPlace) -> Void)?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addTarget(self, action:#selector(tapOnactionTapOn(_:)), for: .touchUpInside)
    }
    
    
    @objc func tapOnactionTapOn(_ sender: UIButton) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        presentOn?.present(autocompleteController, animated: true, completion: nil)
    }
  
}

extension LeoAutoCompletionButton : GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
//        print("Place name: \(place.name)")
//        print("Place address: \(String(describing: place.formattedAddress))")
//        print("Place attributions: \(String(describing: place.attributions))")
//
        closureDidAutocompleteWith?(place)
        
        presentOn?.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        presentOn?.dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
/* Step for  Implemnetation
 
   1. In  application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) ->Bool method of appDelegate Class call
                  googlePlacesConfigure()
   2 . In ViewController and Storyboard class
        1 In storyboard Change the class of UIButton and assigns UIviewController as present on Property of LeoAutoCompletionButton
        2 Then make outlet in view controller
        3 At last define the closure of this button
 */

