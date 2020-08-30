//
//  ViewController.swift
//  Clima
//
//  Created by Nishant Taneja on 30/08/20.
//  Copyright © 2020 Nishant Taneja. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    // IBOutlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    // Initialise
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    // Override View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Delegates
        locationManager.delegate = self
        weatherManager.delegate = self
        searchTextField.delegate = self
        // Authorisation
        locationManager.requestWhenInUseAuthorization()
        // Requestion Current Location
        locationManager.requestLocation()
    }
    
    // IBActions
    @IBAction func currentLocationPressed(_ sender: UIButton) {locationManager.requestLocation()}
    @IBAction func searchPressed(_ sender: UIButton) {searchTextField.resignFirstResponder()}
}

//MARK:- LocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last?.coordinate {
            weatherManager.fetchWeather(forLocation: currentLocation)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {print(error)}
}

//MARK:- WeatherManagerDelegate
extension ViewController: WeatherManagerDelegate {
    func didFetchWeather(_ weatherData: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weatherData.temperatureString
            self.weatherImageView.image = UIImage(systemName: weatherData.condition)
            self.cityLabel.text = weatherData.name
        }
    }
    func didFailWithError(_ error: Error) {print(error)}
}

//MARK:- SearchTextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {textField.resignFirstResponder()}
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {return true}
        else {textField.placeholder = "Enter city name here..."; return false}
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = textField.text {
            weatherManager.fetchWeather(forCityName: cityName)
            textField.text = ""
            textField.placeholder = "Search City"
        }
    }
}
