//
//  Mailer.swift
//  The Anti Printer
//
//  Created by Jacobo Koenig on 6/30/16.
//  Copyright © 2016 Jacobo Koenig. All rights reserved.
//

import Foundation
import MessageUI

class Mailer {
    
    func setupMail(attachment: Data, body: String, mailComposer: MFMailComposeViewController) {
        mailComposer.setToRecipients(["jacobo360@gmail.com"])
        mailComposer.setSubject("Has recibido un nuevo Reporte Ciudadano")
        mailComposer.setMessageBody("<p class=\"p1\">\(body)</span></p>", isHTML: true)
        
        mailComposer.addAttachmentData(attachment as Data, mimeType: "image/png", fileName: "Foto")
    }
    
}
