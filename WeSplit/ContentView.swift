//
//  ContentView.swift
//  WeSplit
//
//  Created by whyourelated on 11.04.2025.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool //фокус на клавиатуре
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0] //выбор размера процента чаевых
    var totalPerPerson: Double { //вычисляемое св-во
        let peopleCount = Double(numberOfPeople + 2)//тк цикл от 2
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        
                    Picker("Number of people:", selection: $numberOfPeople){
                        ForEach(2..<100) { //цикл от 2 до 99
                            Text("\($0) people")
                        }
                    }
                        .pickerStyle(.navigationLink)
                }
                Section("How much tip do you want to leave?"){
                    Picker("Tip amount", selection: $tipPercentage){
                        ForEach(tipPercentages,id:\.self){
                            Text(($0),format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                .navigationTitle("WeSplit")
                .toolbar {
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
            }
        }
    }
}

#Preview { //отображает предварительный просмотр
    ContentView()
}

