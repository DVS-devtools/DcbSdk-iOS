//
//  ViewController.swift
//  DCBExternalApplication
//
//  Created by Pierre Jonny Cau on 12/03/2020.
//  Copyright © 2020 Buongiorno. All rights reserved.
//

import DCBApiExt
import Newton
import UIKit

class ViewController: UIViewController {
    @IBOutlet var logTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLogging()

        DCBUserManager(client: Credential.dcbClient, loggingIsEnabled: Credential.logging).checkFlowDCB(isActive: false) { date in
            if let _ = DCBUserManager.dcbUser {
                print("User Docomo Digital")
                if let date = date {
                    print("User is subscribed in date \(date)")
                } else {
                    print("User expired, not subscribed. User must pay again to access the product")
                }
            } else {
                print("Normal user discover the app from AppStore")
            }
        }
    }
}

extension Notification.Name {
    static let dcbLogging = Notification.Name(rawValue: "DCBAPI_LOGGING")
}

extension ViewController {
    func setupLogging() {
        NotificationCenter.default.addObserver(self, selector: #selector(loggingData(_:)), name: .dcbLogging, object: nil)

        logTextView.insertText("DCB FLOW\n")

        let _: DCBUserManagerCheckCompletion = { date in
            guard let date = date else {
                self.logTextView.insertText("\n\nDCB FLOW FINISHED WITHOUT EXPIRATION TIME")
                return
            }
            self.logTextView.insertText("DCB FLOW FINISHED WITHOUT EXPIRATION TIME WITH DATE: \(date)")
        }
    }

    @objc func loggingData(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let message = userInfo["message"] as? String
        else { return }

        DispatchQueue.main.async {
            self.logTextView.insertText(message)
        }
    }
}
