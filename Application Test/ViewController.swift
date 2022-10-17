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
import SwiftUI

class ViewController: UIViewController {
    var dcbOptions = DcbOptions()
    
    @IBOutlet var logTextView: UITextView!
    @IBOutlet var resetButtonItem: UIBarButtonItem!
    
    fileprivate func resetOptions() {
        dcbOptions.country = ""
        dcbOptions.mccmnc = ""
        dcbOptions.toggleQA = false
    }
    
    @IBAction func resetAction(_ sender: Any) {
        reset()
        
        resetOptions()
        
        logTextView.text = nil
        logTextView.insertText("DCB Account Reset\n")
    }
    
    @IBAction func showOptionsPanel(_ sender: Any) {
        let optionsPanel = DCBOptionsView().environmentObject(dcbOptions)
        let controller = UIHostingController(rootView: optionsPanel)
                self.present(controller, animated: true)
    }
    
    @IBAction func startTestAction(_ sender: Any) {
        
        logTextView.insertText("DCB Options are:\nstaging Environment: \(dcbOptions.toggleQA), fake country: \(dcbOptions.country), fake mccmnc: \(dcbOptions.mccmnc)\n")
        
        saveOptionsToUserDefaults()
        
        guard let dcbCompletion = dcbCompletion else {
            print("the callback is nil. Please, assign it")
            return
        }

        DCBUserManager(client: Credential.dcbClientKidjo, loggingIsEnabled: Credential.logging).checkFlowDCB(isActive: false, completion: dcbCompletion)
    }
    
    fileprivate func saveOptionsToUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(dcbOptions.toggleQA, forKey: "qa.trackIsEnable")
        defaults.set(dcbOptions.mccmnc, forKey: "dcb.fakeMCCMNC")
        defaults.set(dcbOptions.country, forKey: "dcb.fakeCountry")
    }
    
    internal var dcbCompletion: DCBUserManagerCheckCompletion?
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLogging()
    }
    
}



extension Notification.Name {
    static let dcbLogging = Notification.Name(rawValue: "DCBAPI_LOGGING")
}

extension ViewController {
    private func reset() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        NSUbiquitousKeyValueStore.default.dictionaryRepresentation.forEach { key, value in
            logTextView.insertText("NSUbiquitousKeyValueStore -> key is :\(key) and value is \(value)\n")
            NSUbiquitousKeyValueStore.default.removeObject(forKey: key)
            logTextView.insertText("UserDefaults reset completed")
        }
    }

    func setupLogging() {
        NotificationCenter.default.addObserver(self, selector: #selector(loggingData(_:)), name: .dcbLogging, object: nil)

        logTextView.insertText("DCB FLOW\n")

        dcbCompletion = { date, _ in

            if let _ = DCBUserManager.dcbUser {
                self.logTextView.insertText("\n● User Digital Virgo \n")

                if let date = date {
                    self.logTextView.insertText("\n● DCB FLOW FINISHED WITH EXPIRATION TIME WITH DATE: \(date) \n")
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
