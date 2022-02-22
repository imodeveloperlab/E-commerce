//
//  SignUp1ViewController.swift
//  DSKit
//
//  Docs https://dskit.app/components
//  Get started: https://dskit.app/get-started
//  Layout: https://dskit.app/layout
//  Appearance: https://dskit.app/appearance
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit

open class SignUp1ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        showContent()
        showPoweredBy()
    }
    
    // Show content
    func showContent() {
        
        // Text
        let composer = DSTextComposer(alignment: .center)
        
        composer.add(sfSymbol: "square.stack.3d.down.right.fill",
                     style: .custom(size: 40, weight: .medium),
                     tint: .headline,
                     spacing: 30)
        
        let text = composer.textViewModel()
        
        // Bottom button
        let icon = UIImage.named("facebook")
        
        var signUp = DSButtonVM(title: "Login with Facebook",
                                icon: icon,
                                type: .facebook,
                                textAlignment: .left) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        signUp.imagePosition = .rightMargin
        
        let emailLabel = DSLabelVM(.subheadline, text: "or sign up with Email", alignment: .center)
        
        let section = [text, signUp, emailLabel].list()
        section.doubleMarginLeftRightInsets()
        
        // Show text section
        show(content: section, getFormSection(), termsAndPrivacySection())
    }
    
    // Show bottom content
    func showBottomContent() {
        
        // Continue
        let continueAsUser = DSButtonVM(title: "Continue as John",
                                        type: .default) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        // Another account
        let chooseAnotherAccount = DSButtonVM(title: "Choose another account",
                                              type: .link,
                                              textAlignment: .center) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        let sections = [[continueAsUser, chooseAnotherAccount].list().doubleMarginLeftRightInsets()]
        
        // Show bottom button
        showBottom(content: sections)
    }
    
    // Show powered by
    func showPoweredBy() {
        
        let powerByText = DSTextComposer(alignment: .center)
        powerByText.add(type: .subheadline, text: "Powered by ")
        powerByText.add(type: .headline, text: "DSKit", icon: UIImage(named: "dskitIcon") , newLine: false)
        
        var poweredByAction = DSActionVM(composer: powerByText)
        poweredByAction.style.displayStyle = .default
        showBottom(content: poweredByAction)
    }
}

// MARK: - Form section

extension SignUp1ViewController {
    
    // Get form section
    func getFormSection() -> DSSection {
        
        let name = DSTextFieldVM.name(text: "John Doe", placeholder: "Full Name")
        let email = DSTextFieldVM.email(text: "john.doe@dskit.app", placeholder: "Email")
        let password = DSTextFieldVM.password(text: "qqqqqqqq", placeholder: "Password")
        let repeatPassword = DSTextFieldVM.password(text: "qqqqqqqq", placeholder: "Repeat password")
        
        let continueButton = DSButtonVM(title: "Continue") { [unowned self] (_: DSButtonVM)  in 
            self.dismiss()
        }
        
        let section = [name, email, password, repeatPassword, continueButton].list()
        section.doubleMarginLeftRightInsets()
        
        return section
    }
}

// MARK: - Terms and Privacy Section

extension SignUp1ViewController {
    
    func termsAndPrivacySection() -> DSSection {
        
        var text = DSActiveTextVM(.subheadline, text: "By signing up, you agree to our\nTerms and Privacy", alignment: .center)
        
        text.links = ["Terms": "http://dskit.app", "Privacy": "http://dskit.app"]
        
        return text.list()
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct SignUp1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: SignUp1ViewController(), ShopAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
