//
//  MFMailComposeWrapper.swift
//  MFMailComposeWrapper
//
//  Created by moslienko on 28 авг. 2021 г..
//  Copyright © 2021 Pavel Moslienko. All rights reserved.
//

@_exported import Foundation
import MessageUI
import UIKit

public class MFMailComposeWrapper: UIViewController, MFMailComposeViewControllerDelegate {
    
    public var mailComposeControllerFinished: ((_: Error?) -> Void)?
    
    public func presentMailController(
        from parent: UIViewController,
        data: MFMailData,
        presented: ((_ isMFMailCompose: Bool) -> Void)?,
        failedPresent: (() -> Void)?
    ) {
        if MFMailComposeViewController.canSendMail() {
            self.sendEmailViaDefaultApp(data: data, parent: parent)
            presented?(true)
        } else {
            let apps = MailApp.allCases
            apps.enumerated().forEach({
                if $0.element.tryOpenApp(with: data) {
                    presented?(false)
                    return
                }
                if $0.offset == apps.count - 1 {
                    failedPresent?()
                }
            })
        }
    }
    
    //MARK: - Module methods
    
    private func sendEmailViaDefaultApp(data: MFMailData, parent: UIViewController) {
        let mail = MFMailComposeViewController()
        
        mail.mailComposeDelegate = self
        mail.setToRecipients(data.emails)
        mail.setSubject(data.subject)
        mail.setMessageBody(data.messageBody, isHTML: false)
        
        parent.present(mail, animated: true)
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        self.mailComposeControllerFinished?(error)
    }
}
