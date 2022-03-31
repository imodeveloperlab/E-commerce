//
//  Profile3ViewController.swift
//  Barber Shop
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class Profile3ViewController: DSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Update Password"
        update()
    }
    
    /// Update current content on the screen
    func update() {
        self.show(content: [getFormSection()])
    }
}

// MARK: - Form section
extension Profile3ViewController {
    
    func getFormSection() -> DSSection {
        
        // Subtitle
        var description = DSLabelVM(.subheadline, text: "Changing your password regularly reduces your risk of exposure and avoids a number of dangers.")
        description.style.displayStyle = .grouped(inSection: false)
        
        var icon = DSImageVM(imageValue: .sfSymbol(name: "exclamationmark.shield.fill", style: .large), contentMode: .scaleAspectFit)
        icon.width = .absolute(30)
        icon.height = .absolute(30)
        
        icon.tintColor = .custom(UIColor.systemYellow)
        description.leftSideView = DSSideView(view: icon)
        
        // Password
        let currentPassword = DSTextFieldVM.password(placeholder: "Current Password")
        currentPassword.errorPlaceHolderText = "Minimum 8 characters maximum 14"
        
        // Password
        let password = DSTextFieldVM.newPassword(placeholder: "Password")
        password.errorPlaceHolderText = "Minimum 8 characters maximum 14"
        
        // Password
        let repeatPassword = DSTextFieldVM.newPassword(placeholder: "Repeat password")
        repeatPassword.errorPlaceHolderText = "Should match password"
        repeatPassword.handleValidation = { text in
            return text == password.text
        }
        
        // Update
        var updateButton = DSButtonVM(title: "Update")
        
        // Handle did tap on button
        updateButton.didTap = { [unowned self] model in
            
            self.isCurrentFormValid { isValid in
                if isValid {
                    self.show(message: "Your password was successfully updated",
                              type: .success,
                              timeOut: 1) {
                        self.update()
                    }
                }
            }
        }
        
        return [description,
                currentPassword,
                password,
                repeatPassword,
                updateButton].list()
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Profile3ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Profile3ViewController())
            PreviewContainer(VC: nav, BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
