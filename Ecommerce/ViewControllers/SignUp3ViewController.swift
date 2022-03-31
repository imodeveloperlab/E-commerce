//
//  SignUp3ViewController.swift
//  DSKit
//
//  Docs https://dskit.app/components
//  Get started: https://dskit.app/get-started
//  Layout: https://dskit.app/layout
//  Appearance: https://dskit.app/appearance
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class SignUp3ViewController: DSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notifications"
        
        // Decoration icon
        decorationIcon = DSDecorationIcon(name: "phone.fill",
                                          position: .topRight,
                                          size: .init(width: 60, height: 60),
                                          offset: .init(x: -30, y: 120),
                                          alpha: 1.0,
                                          color: appearance.secondaryView.background)
        update()
    }
    
    /// Update current content on the screen
    func update() {
        show(content: headerSection(), formSection())
    }
    
    /// Turn on notifications section
    /// - Returns: DSSection
    func formSection() -> DSSection {
        
        // Text field
        let textField = DSTextFieldVM.phone(text: "+41007933309",
                                            placeholder: "Phone number")
        textField.height = .absolute(60)
        
        // Bottom label
        let bottomLabel = DSLabelVM(.caption1,
                                    text: "You will receive an sms with code, which you should insert in the next step")

        let button = DSButtonVM(title: "Subbmit") { [unowned self] _ in
            self.dismiss()
        }
        
        return [DSSpaceVM(type: .custom(100)),
                descriptionModel(),
                DSSpaceVM(type: .custom(50)),
                textField,
                bottomLabel,
                button].list().doubleMarginLeftRightInsets()
    }
    
    /// Description
    /// - Returns: DSViewModel
    func descriptionModel() -> DSViewModel {
        
        let composer = DSTextComposer(alignment: .natural)
        composer.add(type: .headlineWithSize(36),
                     text: "Start with\nphone number",
                     spacing: 10,
                     maximumLineHeight: 36)
        
        composer.add(type: .body,
                     text: "Please enter your mobile number to get sms to activate your account")
        
       return composer.textViewModel()
    }
    
    /// Header section
    /// - Returns: DSSection
    func headerSection() -> DSSection {
        
        // Logo
        let composer = DSTextComposer(alignment: .center)
        composer.add(type: .headline, text: "Sign Up")
        var header = composer.textViewModel()
        
        // Button
        var button = DSButtonVM(sfSymbol: "xmark",
                                style: .large,
                                type: .link) { [unowned self] _ in
            self.dismiss()
        }
        
        // Set button as supplementary view
        button.width = .absolute(50)
        button.height = .absolute(50)
        header.supplementaryItems = [button.asSupplementary(position: .rightCenter,
                                                            offset: .custom(.init(x: -5, y: 0)))]
        return header.list()
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct SignUp3ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: SignUp3ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
