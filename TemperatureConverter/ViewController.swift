//
//  ViewController.swift
//  TemperatureConverter
//
//  Created by Ivan Dedic on 2024-08-28.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var lblResult: UILabel!
    
    @IBOutlet weak var myPickerView: UIPickerView!
    
    var celciusValues: [Int] = (-50...50).map{$0}
    var fahrenheitValues: [Int] = (-58...122).map{$0}
    
    let converter = Converter()
    
    let CELSIUS_COLUMN = 0
    let FAHRENHEIT_COLUMN = 1
    
    let CELCIUS_KEY = "celcius"
    let FAHRENHEIT_KEY = "fahrenheit"
    
   let DEFAULT_INDEXES_BY_UNIT = [
    "fahrenheit": 90,
    "celcius": 50
   ]
 
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        myPickerView.selectRow(getSavedRow(key: "celcius"), inComponent: CELSIUS_COLUMN, animated: false)
        myPickerView.selectRow(getSavedRow(key: "fahrenheit"), inComponent: FAHRENHEIT_COLUMN, animated: false)
        
        pickerView(myPickerView, didSelectRow: getSavedRow(key: CELCIUS_KEY), inComponent: CELSIUS_COLUMN)
        pickerView(myPickerView, didSelectRow: getSavedRow(key: FAHRENHEIT_KEY), inComponent: FAHRENHEIT_COLUMN)
        
      /*  if let foundValue = fahrenheitValues.firstIndex(of: 32) {
            
            myPickerView.selectRow(foundValue, inComponent: FAHRENHEIT_COLUMN, animated: false)
            
        } */
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(component == CELSIUS_COLUMN) {
           return celciusValues.count
        }
        else{
            return fahrenheitValues.count
        }
        
    }
    
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        // Returnerar hela arrayens indexexeringar -> som string för varje rad
        
        if component == 0 {
           let celciusValues =  String(celciusValues[row])
            return "\(celciusValues)  ℃"
            
        } else {
            let fahrenHeitValues = String(fahrenheitValues[row])
            return "\(fahrenHeitValues)  ℉"
        }
        
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print("user selected \(row) in component \(component)" )
        
        
        
        if component == CELSIUS_COLUMN {
            
            let result = converter.toFahrenheit(celcius: celciusValues[row])
            
            lblResult.text = "Result: \(result) ℉"
            
            
            saveSelectedRow(row: row, key: CELCIUS_KEY)
            
        } else {
            
            let result = converter.toCelcius(fahrenheit: fahrenheitValues[row])
            lblResult.text = "Result: \(result) ℃"
            
            saveSelectedRow(row: row, key: FAHRENHEIT_KEY)
        }
        
        
        
    }
    
    
    
    func getSelectedRow(key: String) -> Int {
        
        let defaults = UserDefaults.standard
        
        let savedRow = defaults.value(forKey: key) as? Int
        
        if let savedRow = savedRow {
            return savedRow
        } else {
            return DEFAULT_INDEXES_BY_UNIT[key] ?? 0
        }
        
    }
    
    
    
    func getSavedRow(key: String) -> Int {
        
        let defaults = UserDefaults.standard
        
        let savedRow = defaults.value(forKey: key) as? Int
        
        if let savedRow = savedRow {
            return savedRow
        } else {
            return DEFAULT_INDEXES_BY_UNIT[key] ?? 0
        }
        
    }
    
    func saveSelectedRow(row: Int, key: String) {
       
        // accest till standard userdefault
        let defaults = UserDefaults.standard
        
        defaults.set(row, forKey: key)
        
    }
    
    
 

}

