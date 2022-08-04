//
//  DCBOptionsHostingController.swift
//  Application for DCB
//
//  Created by Matteo Burgassi on 04/08/22.
//  Copyright © 2022 Buongiorno. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class DCBOptionsHostingController: UIHostingController<DCBOptionsView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: DCBOptionsView())
    }
}

