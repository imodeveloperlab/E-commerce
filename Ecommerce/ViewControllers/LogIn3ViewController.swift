//
//  LogIn3ViewController.swift
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
import UIKit

open class LogIn3ViewController: DSViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        showContent()
        showBottomContent()
    }
    
    // Show content
    func showContent() {
        
        // Text
        let space1 = DSSpaceVM(type: .custom(50))
        let composer = DSTextComposer(alignment: .center)
        
        composer.add(sfSymbol: "square.stack.3d.down.right.fill",
                     style: .custom(size: 60, weight: .medium),
                     tint: .headline,
                     spacing: 50)
        
        composer.add(type: .body, text: "Meet new people from over millions of users. Create posts, find friends and more.")
        let text = composer.textViewModel()
        
        // Text section
        let section = [space1, text].list()
        section.doubleMarginLeftRightInsets()
        
        // Show text section
        show(content: section)
    }
    
    // Show bottom content
    func showBottomContent() {
        
        let socialNetworksLabel = DSLabelVM(.subheadline,
                                            text: "Login with social networks",
                                            alignment: .center)
        
        let emailLabel = DSLabelVM(.subheadline,
                                   text: "or sign up with Email",
                                   alignment: .center)
        
        // Facebook
        var facebook = DSButtonVM(title: "Facebook",
                                  icon: UIImage.named("facebook"),
                                  type: .facebook,
                                  textAlignment: .left) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        facebook.imagePosition = .rightMargin
        
        // Twitter
        var twitter = DSButtonVM(title: "Twitter",
                                 icon: UIImage.named("twitter"),
                                 type: .twitter,
                                 textAlignment: .left) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        twitter.imagePosition = .rightMargin
        
        // Sign up
        var signUpEmail = DSButtonVM(title: "Sign Up",
                                     icon: UIImage(systemName: "envelope.fill"),
                                     type: .secondaryView,
                                     textAlignment: .left) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        // Log in with email
        let logInWithEmail = DSButtonVM(title: "Log in with Email",
                                        type: .link,
                                        textAlignment: .center) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        signUpEmail.imagePosition = .rightMargin
        
        // Show bottom button
        showBottom(content: [[socialNetworksLabel].list(),
                             [facebook, twitter].grid().doubleMarginLeftRightInsets(),
                             [emailLabel].list(),
                             [signUpEmail].list().doubleMarginLeftRightInsets(),
                             [logInWithEmail].list()])
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct LogIn3ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: LogIn3ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
