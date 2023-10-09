//
//  ContentView.swift
//  WeSplit
//
//  Created by Pratik Ranjan Sau on 07/10/23.
//

import SwiftUI

struct ContentView: View {
    /*
     SwiftUI uses the @State property wrapper to allow us to modify values inside a struct, which would normally not be allowed because structs are value types.
     
     When we put @State before a property, we effectively move its storage out from our struct and into shared storage managed by SwiftUI. This means SwiftUI can destroy and recreate our struct whenever needed (and this can happen a lot!), without losing the state it was storing.
     */
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson: Double {
        //calculate total person
        let peopleCount = Double (numberOfPeople + 2)
        let tipSelection = Double (tipPercentage)
        let tipValue = checkAmount/100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount",value: $checkAmount, format: .currency(code:
                                                                                Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                
                    Picker("Number of People",selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section("How much do you want to tip?"){
                    Picker("Tip Percentage",selection: $tipPercentage){
                        ForEach(tipPercentages,id: \.self){
                            Text($0,format:.percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD") )
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                if amountIsFocused{
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
        
        
        
    }
}

#Preview {
    ContentView()
}

