//
//  ViewController.swift
//  Clima
//
//  Created by Nishant Taneja on 30/08/20.
//  Copyright © 2020 Nishant Taneja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // IBOutlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    // Initialise
    
    // Override View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // IBActions
    @IBAction func currentLocationPressed(_ sender: UIButton) {}
    @IBAction func searchPressed(_ sender: UIButton) {}
}

