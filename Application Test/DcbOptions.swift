//
//  DcbOptions.swift
//  Application for DCB
//
//  Created by Matteo Burgassi on 04/08/22.
//  Copyright © 2022 Buongiorno. All rights reserved.
//

import Foundation

class DcbOptions: ObservableObject {
    @Published var toggleQA = false
    @Published var country = ""
    @Published var mccmnc = ""
}
