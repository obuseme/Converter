//
//  ContentView.swift
//  Converter
//
//  Created by Andrew Obusek on 7/7/20.
//

import SwiftUI

struct ContentView: View {

    enum Units: String, CaseIterable {
        case Inches, Feet, Yards, Miles, Meters, Kilometers
    }
    enum MeterConversion: Double {
        case ToInches = 39.3701
        case ToFeet = 3.28084
        case ToYards = 1.09361
        case ToMiles = 0.0006213
        case ToKilometers = 0.001
    }

    @State private var inputValue = ""
    @State private var outputValue = ""
    @State private var inputUnits = 2
    @State private var outputUnits = 2

    var output: Double {
        var conversionFactor = 0.0
        var outputInMeters = 0.0
        var toReturn = 0.0
        switch Units.allCases[inputUnits].rawValue {
        case Units.Inches.rawValue:
            conversionFactor = (1 / MeterConversion.ToInches.rawValue)
        case Units.Feet.rawValue:
            conversionFactor = (1 / MeterConversion.ToFeet.rawValue)
        case Units.Yards.rawValue:
            conversionFactor = (1 / MeterConversion.ToYards.rawValue)
        case Units.Miles.rawValue:
            conversionFactor = (1 / MeterConversion.ToMiles.rawValue)
        case Units.Meters.rawValue:
            conversionFactor = 1.0
        case Units.Kilometers.rawValue:
            conversionFactor = (1 / MeterConversion.ToKilometers.rawValue)
        default:
            return 0.0
        }
        outputInMeters = (Double(inputValue) ?? 0.0) * conversionFactor

        switch Units.allCases[outputUnits].rawValue {
        case Units.Inches.rawValue:
            toReturn = outputInMeters * MeterConversion.ToInches.rawValue
        case Units.Feet.rawValue:
            toReturn = outputInMeters * MeterConversion.ToFeet.rawValue
        case Units.Yards.rawValue:
            toReturn = outputInMeters * MeterConversion.ToYards.rawValue
        case Units.Miles.rawValue:
            toReturn = outputInMeters * MeterConversion.ToMiles.rawValue
        case Units.Meters.rawValue:
            toReturn = outputInMeters
        case Units.Kilometers.rawValue:
            toReturn = outputInMeters * MeterConversion.ToKilometers.rawValue
        default:
            toReturn = 0.0
        }
        return toReturn
    }

    var body: some View {
//        NavigationView {
            Form {
                Section {
                    TextField("Input", text: $inputValue)
                        .keyboardType(.decimalPad)
                    Picker("Units", selection:
                            $inputUnits) {
                        ForEach(0 ..< Units.allCases.count) {
                            Text("\(Units.allCases[$0].rawValue)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("\(output, specifier: "%.2f")")
                    Picker("Units", selection:
                            $outputUnits) {
                        ForEach(0 ..< Units.allCases.count) {
                            Text("\(Units.allCases[$0].rawValue)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
//            }
//            .navigationTitle("Distance Converter")

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
