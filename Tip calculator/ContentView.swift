import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    @State private var selectedCurrency = 0
    @State private var buttonShowCost = false
    let tipPercentages: [Int] = [0, 5, 10, 15, 20, 25]
    let currencies = ["$", "€", "£", "₹", "¥", "₽","kr"]

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }

                Section(header: Text("How much tip would you like to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section(header: Text("Currency")) {
                    Picker("Select currency", selection: $selectedCurrency) {
                        ForEach(0..<currencies.count, id: \.self) {
                            Text(currencies[$0])
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            buttonShowCost.toggle()
                        }) {
                            Text("Show cost")
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                        }
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .alert("Du behöver betala", isPresented: $buttonShowCost) {
                            Button("OK") { }
                        } message: {
                            Text("\(totalPerPerson, specifier: "%.2f") \(currencies[selectedCurrency])")
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Tip Calculator")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
