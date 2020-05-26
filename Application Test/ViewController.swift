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
    internal var dcbCompletion: DCBUserManagerCheckCompletion?
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLogging()

        guard let dcbCompletion = dcbCompletion else {
            print("the callback is nil. Please, assign it")
            return
        }

        DCBUserManager(client: Credential.dcbClient, loggingIsEnabled: Credential.logging).checkFlowDCB(isActive: false, completion: dcbCompletion)
    }
}

extension Notification.Name {
    static let dcbLogging = Notification.Name(rawValue: "DCBAPI_LOGGING")
}

extension ViewController {
    func setupLogging() {
        NotificationCenter.default.addObserver(self, selector: #selector(loggingData(_:)), name: .dcbLogging, object: nil)

        logTextView.insertText("DCB FLOW\n")

        dcbCompletion = { date in

            if let _ = DCBUserManager.dcbUser {
                self.logTextView.insertText("\n● User Docomo Digital \n")

                if let date = date {
                    self.logTextView.insertText("\n● DCB FLOW FINISHED WITHOUT EXPIRATION TIME WITH DATE: \(date) \n")
                } else {
                    self.logTextView.insertText("\n● User expired, not subscribed. User must pay again to access the product \n")
                }
            } else {
                self.logTextView.insertText("\n● Normal user discover the app from AppStore \n")
            }
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
