//
//  Profile2ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class Profile2ViewController: DSViewController {
    
    // Random data generator, an wrapper around https://github.com/vadymmarkov/Fakery
    let person = DSFaker().person
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Personal Data"
        update()
    }
    
    /// Update current content on the screen
    func update() {
        self.show(content: [getProfileDescription(), getPersonalDetailsSection()])
    }
}

// MARK: - Personal details form
extension Profile2ViewController {
    
    /// Get profile description
    /// - Returns: DSSection
    func getProfileDescription() -> DSSection {
        
        // Profile picture
        let picture = DSImageVM(imageUrl: URL.personOnMarineBg, height: .absolute(100), displayStyle: .circle)
        
        // Profile text
        let text = DSTextComposer(alignment: .center)
        text.add(type: .title1, text: "Jane Doe")
        text.add(type: .subheadline, text: "9 May 1988")
        
        // Description
        var description = DSActionVM(composer: text)
        description.style.displayStyle = .default
        
        return [picture, description].list()
    }
    
}

// MARK: - Personal details form
extension Profile2ViewController {
    
    /// Personal details form
    /// - Returns: DSSection
    func getPersonalDetailsSection() -> DSSection {
        
        // Full name
        let fullName = DSTextFieldVM.name(placeholder: "Full Name")
        fullName.errorPlaceHolderText = "Min 3 chars Max 35"
        fullName.text = "Jane Doe"
        fullName.didUpdate = { text in
            print(text.text ?? "No value found")
        }
        
        // Email
        let email = DSTextFieldVM.email(placeholder: "Email")
        email.text = person.email
        email.errorPlaceHolderText = "Example: email@example.com"
        
        // Phone
        let phone = DSTextFieldVM.phone(placeholder: "Phone Number")
        phone.text = person.phone
        phone.errorPlaceHolderText = "Example: 0x xxx xx xx"
        
        // City
        let city = DSTextFieldVM.addressCity(placeholder: "City")
        city.text = "Chisinau"
        
        // Adress
        let address = DSTextFieldVM.address(placeholder: "Address")
        address.text = "Sarmizegetusa"
        
        // State
        let state = DSTextFieldVM.addressState(placeholder: "State")
        state.text = "Moldova"
        
        // State
        let street = DSTextFieldVM.streetAddressLine1(placeholder: "Street")
        street.text = "Sarmizegetusa 1"
        
        // Update
        var updateButton = DSButtonVM(title: "Update")
        
        // Handle did tap on update button
        updateButton.didTap = { [unowned self] model in
            
            // Check if current from present on the screen is valid
            self.isCurrentFormValid { isValid in
                if isValid {
                    self.showSuccessMessage()
                }
            }
        }
        
        return [DSSpaceVM(type: .custom(30)), fullName, email, phone, city, address, state, street, updateButton].list()
    }
    
    /// Show success message
    func showSuccessMessage() {
        self.show(message: "Your profile was successfully updated", type: .success, timeOut: 2) {
            self.popToRoot()
        }
    }
}


// MARK: - SwiftUI Preview

import SwiftUI

struct Profile2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Profile2ViewController())
            PreviewContainer(VC: nav, BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
