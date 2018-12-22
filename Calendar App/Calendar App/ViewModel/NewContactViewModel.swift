//
//  NewContactViewModel.swift
//  Calendar App
//
//  Created by Anderson Gralha on 19/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

class NewContactViewModel: NSObject {

//    let coreDataStack = CoreDataStack()
    
    func texte() {
        let contact = Contact(context: CoreDataStack.shared.managedContext)
//        let email = Email(context: CoreDataStack.shared.managedContext)
//        email.email = "teste.teste"
//        
//        let phone = Phone(context: CoreDataStack.shared.managedContext)
//        phone.phone = "tedsasjd"
//
//        contact.addToEmails(email)
//        contact.addToPhones(phone)
        
        do {
            try CoreDataStack.shared.managedContext.save()
        } catch {
            print(error)
        }
    }
    
}
