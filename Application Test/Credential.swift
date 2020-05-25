//
//  Credential.swift
//  DCBExternalApplication
//
//  Created by Pierre Jonny Cau on 12/03/2020.
//  Copyright © 2020 Buongiorno. All rights reserved.
//

import DCBApiExt
import Foundation

struct Credential {
    static let dcbClient: DCBApiClient = {
        let fingerPrintDomain = URL(string: "http://www.kidzinmind.com")!
        let baseDomain = URL(string: "http://www.kidzinmind.com")!

        return DCBApiClient(baseDomain: fingerPrintDomain,
                            confInfoDomain: baseDomain,
                            apikey: "556a42415047494483",
                            catalog: "ww-kidzinmind",
                            country: "ww",
                            namespace: "news")
    }()

    static let logging = true
}
