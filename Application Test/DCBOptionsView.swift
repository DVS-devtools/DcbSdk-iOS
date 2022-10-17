//
//  DCBOptionsView.swift
//  Application for DCB
//
//  Created by Matteo Burgassi on 04/08/22.
//  Copyright © 2022 Buongiorno. All rights reserved.
//

import SwiftUI

struct DCBOptionsView: View {
    @EnvironmentObject var dcbOptions: DcbOptions
    
    var body: some View {
        VStack (alignment: .leading){
            Text("DCB Options").font(.largeTitle)
            Toggle("Toggle qa environment", isOn: $dcbOptions.toggleQA)
            HStack{
                Text("Set Country:")
                TextField("Country code", text: $dcbOptions.country)
            }
            HStack{
                Text("Fake MCCMNC:")
                TextField("MCCMNC", text: $dcbOptions.mccmnc)
            }
            Spacer()
        }.padding()
    }
}

struct DCBOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        DCBOptionsView()
    }
}
