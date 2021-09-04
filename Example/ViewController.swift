//
//  ViewController.swift
//  Example
//
//  Created by moslienko on 28 авг. 2021 г..
//  Copyright © 2021 Pavel Moslienko. All rights reserved.
//

import UIKit
import MFMailComposeWrapper

// MARK: - ViewController

/// The ViewController
class ViewController: UIViewController {
    
    @IBOutlet private weak var sendMailButton: UIButton!
    
    public class var fromXib: ViewController {
        ViewController(nibName: "ViewController", bundle: nil)
    }
    
    // MARK: View-Lifecycle
    
    /// View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.sendMailButton.setTitle("Send email", for: .normal)
        self.sendMailButton.addTarget(self, action: #selector(self.mailButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc
    private func mailButtonTapped(_ sender: UIButton) {
        let data = MFMailData(emails: ["test@gmail.com"], subject: "My subject", messageBody: "Hello world! 😀")
        let mailWrapped = MFMailComposeWrapper()
        
        mailWrapped.presentMailController(
            from: self,
            data: data,
            presented: { isMFMailCompose in
                print("Mail presented - \(isMFMailCompose)")
            }, failedPresent: {
                print("Failed present mail")
            }
        )
        
        mailWrapped.mailComposeControllerFinished = { error in
            print("MailComposeController finished with error - \(String(describing: error))")
        }
    }
}
