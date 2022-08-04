//
//  DCBOptionsView.swift
//  Application for DCB
//
//  Created by Matteo Burgassi on 04/08/22.
//  Copyright © 2022 Buongiorno. All rights reserved.
//

import SwiftUI

struct DCBOptionsView: View {
    @State private var toggleQA = false
    @State private var country = ""
    @State private var mccmnc = ""
    
    var body: some View {
        VStack (alignment: .leading){
            Text("DCB Options").font(.largeTitle)
            Toggle("Toggle qa environment", isOn: $toggleQA)
            HStack{
                Text("Set Country:")
                TextField("Country code", text: $country)
            }
            HStack{
                Text("Fake MCCMNC:")
                TextField("MCCMNC", text: $mccmnc)
            }
        }.padding()
    }
}

struct DCBOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        DCBOptionsView()
    }
}
