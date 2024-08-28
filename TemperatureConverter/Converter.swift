//
//  Converter.swift
//  TemperatureConverter
//
//  Created by Ivan Dedic on 2024-08-28.
//

import Foundation


class Converter {
    
    func toFahrenheit(celcius: Int) -> Int {
        
        let fahrenheit = round(1.8 * Double(celcius) + 32)
        
        return Int(fahrenheit)
        
    }
    
    
    func toCelcius(fahrenheit: Int) -> Int {
        
        let celcius = round(Double((fahrenheit) - 32) / 1.8)
        
        return Int(celcius)
    }
    
}
