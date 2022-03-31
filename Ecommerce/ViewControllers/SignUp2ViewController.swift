//
//  SignUp2ViewController.swift
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

open class SignUp2ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        showContent()
        showBottomContent()
    }
    
    /// Show content
    func showContent() {
        
        // Text
        let composer = DSTextComposer(alignment: .center)
        composer.add(type: .headline, text: "Sign Up")
        let text = composer.textViewModel()
        
        // Space
        let space1 = DSSpaceVM(type: .custom(30))
        
        // Image
        var image = DSImageVM(imageUrl: URL.profileUrl(), height: .absolute(100), displayStyle: .circle)
        
        // Change picture button
        var button = DSButtonVM(sfSymbol: "camera.fill") { [unowned self] _ in
            self.dismiss()
        }
        button.width = .absolute(40)
        button.height = .absolute(40)
        button.type = .linkBlack
        
        // Image supplementary item
        image.supplementaryItems = [button.asSupplementary(position: .center,
                                                           background: .lightBlur,
                                                           insets: .insets(.zero),
                                                           offset: .custom(.init(x: -35, y: -35)),
                                                           cornerRadius: .custom(20))]
        let space2 = DSSpaceVM(type: .custom(30))
        
        // Section
        let section = [text, space1, image, space2].list()
        section.doubleMarginLeftRightInsets()
        
        // Show text section
        show(content: section, getFormSection(), termsAndPrivacySection())
    }
    
    // Show bottom content
    func showBottomContent() {
        
        let continueAsUser = DSButtonVM(title: "I have an account",
                                        type: .link) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        // Show bottom button
        showBottom(content: [continueAsUser].list().doubleMarginLeftRightInsets())
    }
    
    // Shoe powered by
    func showPoweredBy() {
        
        // Text
        let powerByText = DSTextComposer(alignment: .center)
        powerByText.add(type: .subheadline, text: "Powered by ")
        powerByText.add(type: .headline, text: "DSKit", icon: UIImage(named: "dskitIcon") , newLine: false)
        
        // Action
        var poweredByAction = DSActionVM(composer: powerByText)
        poweredByAction.style.displayStyle = .default
        
        // Show bottom
        showBottom(content: poweredByAction)
    }
}

// MARK: - Form section

extension SignUp2ViewController {
    
    func getFormSection() -> DSSection {
        
        // Text fields
        let fullName = DSTextFieldVM.name(text: "John Doe", placeholder: "Full Name")
        let email = DSTextFieldVM.email(text: "john.doe@dskit.app", placeholder: "Email")
        let password = DSTextFieldVM.password(text: "qqqqqqqq", placeholder: "Password")
        
        // Button
        let continueButton = DSButtonVM(title: "Create an Account") { [unowned self] (_: DSButtonVM)  in 
            self.dismiss()
        }
        
        let section = [fullName, email, password,  continueButton].list()
        section.doubleMarginLeftRightInsets()
        
        return section
    }
}

// MARK: - Terms and Privacy Section

extension SignUp2ViewController {
    
    /// Terms and conditions and privacy policy
    /// - Returns: DSSection
    func termsAndPrivacySection() -> DSSection {
        
        // Text
        var text = DSActiveTextVM(.subheadline, text: "By signing up, you agree to our\nTerms and Privacy", alignment: .center)
        text.links = ["Terms": "http://dskit.app", "Privacy": "http://dskit.app"]
        
        // Handle did tap on url
        text.didTapOnUrl = { [unowned self] url in
            self.dismiss()
        }
        
        return text.list()
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct SignUp2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: SignUp2ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
