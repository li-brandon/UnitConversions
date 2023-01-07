//
//  ContentView.swift
//  UnitConversions
//
//  Created by Brandon Li on 1/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputTemperature = 0.0
    @State private var inputUnit = ""
    @State private var outputUnit = ""
    
    let temperatureConversions = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertedTemperature: Double {
        var finalTemperature = 0.0
        
        if inputUnit == "Celsius" {
            if outputUnit == "Celsius" {
                return inputTemperature
            } else if outputUnit == "Fahrenheit" {
                finalTemperature = (inputTemperature * 1.8) + 32
            } else {
                finalTemperature = inputTemperature + 273
            }
        } else if inputUnit == "Fahrenheit" {
            if outputUnit == "Fahrenheit" {
                return inputTemperature
            } else if outputUnit == "Celsius" {
                finalTemperature = (inputTemperature / 1.8) + 32
            } else {
                finalTemperature = (inputTemperature + 460) * 5/9
            }
        } else if inputUnit == "Kelvin" {
            if outputUnit == "Kelvin" {
                return inputTemperature
            } else if outputUnit == "Celsius" {
                finalTemperature = inputTemperature - 273
            } else {
                finalTemperature = (inputTemperature - 460) * 9/5
            }
        }
        return finalTemperature
    }
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                // Input
                Section {
                    TextField("Current Temperature", value: $inputTemperature, format: .number).keyboardType(.decimalPad).focused($amountIsFocused)
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(temperatureConversions, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(temperatureConversions, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                // Output
                Section {
                    Text(convertedTemperature, format: .number)
                } header: {
                    Text("Converted Temperature")
                }
                
            }.navigationTitle("Unit Conversion")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
