//
//  ViewController.swift
//  ClimaPractice
//
//  Created by jae hoon lee on 2023/09/08.
//

import UIKit

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextfield: UITextField!
    
    var weatherManager = WeatherManger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        weatherManager.delegate = self
        searchTextfield.delegate = self
    }

}

//MARK: - UITextFieldDelegate
extension WeatherViewController : UITextFieldDelegate {
    
    @IBAction func searchTapped(_ sender: UIButton) {
        searchTextfield.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextfield.endEditing(true)
        print(searchTextfield.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let country = searchTextfield.text {
            weatherManager.fetchWeather(countryName: country)
            
        }
        
        searchTextfield.text = ""
    }
    
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController : WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager : WeatherManger,  weather : WeatherModel) {
        DispatchQueue.main.sync {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.countryName
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
