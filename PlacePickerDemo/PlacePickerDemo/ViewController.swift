//
//  ViewController.swift
//  PlacePickerDemo
//
//  Created by Anupriya on 12/10/17.
//  Copyright © 2017 Anupriya. All rights reserved.
//

import UIKit
import GooglePlaces

class ViewController: UIViewController {

    
    @IBOutlet weak var btnToPlace: LeoAutoCompletionButton!
    
    @IBOutlet weak var txtPlaceName: UITextField!
    
    @IBOutlet weak var txtFromPlace: UITextField!
    
    @IBOutlet weak var btnFromPlace: LeoAutoCompletionButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        btnFromPlace.closureDidAutocompleteWith = {
            place in
            
            self.txtFromPlace.text = place.name
        }
        
        btnToPlace.closureDidAutocompleteWith = {
            place in
            
            self.txtPlaceName.text = place.name
        }
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
