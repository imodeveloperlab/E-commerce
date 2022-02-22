//
//  LogInViewController.swift
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

open class LogIn1ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        showContent()
        showBottomContent()
    }
    
    /// Show content
    func showContent() {
        
        // Text
        let space1 = DSSpaceVM(type: .custom(50))
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(38), text: "Welcome to\nDSKit shop")
        composer.add(type: .body, text: "An exciting place for the whole\nfamily to shop")
        let text = composer.textViewModel()
        let space2 = DSSpaceVM(type: .custom(50))
        
        // Form
        let email = DSTextFieldVM.email(text: "john.doe@dskit.app",placeholder: "Email")
        let password = DSTextFieldVM.password(text: "qqqqqqqq", placeholder: "Password")
        
        // Buttons
        let login = DSButtonVM(title: "Login") { [unowned self] (_: DSButtonVM)  in
            self.dismiss()
        }
        
        let forgotPassword = DSButtonVM(title: "Forgot password?", type: .link, textAlignment: .left) { [unowned self] (_: DSButtonVM)  in
            self.dismiss()
        }
        
        let section = [space1, text, space2, email, password, login, forgotPassword].list()
        section.doubleMarginLeftRightInsets()
        
        // Show content
        show(content: section)
    }
    
    func showBottomContent() {
        
        var signUp = DSButtonVM(title: "Sign Up",
                                icon: DSSFSymbolConfig.buttonIcon("chevron.right"),
                                type: .secondaryView,
                                textAlignment: .left) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        signUp.imagePosition = .rightMargin
        
        // Show bottom content
        showBottom(content: [signUp].list().doubleMarginLeftRightInsets())
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct LogIn1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: LogIn1ViewController(), ShopAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
