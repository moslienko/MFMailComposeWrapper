//
//  MailApp.swift
//  MFMailComposeWrapper
//
//  Created by Pavel Moslienko on 04.09.2021.
//  Copyright © 2021 Pavel Moslienko. All rights reserved.
//

import Foundation
import UIKit

public enum MailApp: CaseIterable {
    case gmail, outlook, yahoo, spark, `default`
    
    func createEmailUrlPatch(_ data: MFMailData) -> URL? {
        let emails = data.emails.joined(separator: ",")
        let subjectEncoded = data.subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let messageEncoded = data.messageBody.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        switch self {
        case .gmail:
            return URL(string: "googlegmail://co?to=\(emails)&subject=\(subjectEncoded)&body=\(messageEncoded)")
        case .outlook:
            return URL(string: "ms-outlook://compose?to=\(emails)&subject=\(subjectEncoded)")
        case .yahoo:
            return URL(string: "ymail://mail/compose?to=\(emails)&subject=\(subjectEncoded)&body=\(messageEncoded)")
        case .spark:
            return URL(string: "readdle-spark://compose?recipient=\(emails)&subject=\(subjectEncoded)&body=\(messageEncoded)")
        case .default:
            return URL(string: "mailto:\(emails)?subject=\(subjectEncoded)&body=\(messageEncoded)")
        }
    }
    
    func tryOpenApp(with data: MFMailData) -> Bool {
        guard let url = self.createEmailUrlPatch(data),
              UIApplication.shared.canOpenURL(url) else {
            return false
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
        
        return true
    }
}
