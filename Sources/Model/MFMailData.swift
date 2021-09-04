//
//  MFMailData.swift
//  MFMailComposeWrapper-iOS
//
//  Created by Pavel Moslienko on 28.08.2021.
//  Copyright © 2021 Pavel Moslienko. All rights reserved.
//

public struct MFMailData {
    var emails: [String]
    var subject: String
    var messageBody: String
    
    public init(emails: [String], subject: String = "", messageBody: String = "") {
        self.emails = emails
        self.subject = subject
        self.messageBody = messageBody
    }
}
