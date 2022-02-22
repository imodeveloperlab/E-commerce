//
//  LogIn4ViewController.swift
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

open class LogIn4ViewController: DSViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        showContent()
        showBottomContent()
    }
    
    // Show content
    func showContent() {
        
        // Text
        let space1 = DSSpaceVM(type: .custom(50))
        
        // Space
        let space2 = DSSpaceVM(type: .custom(20))
        
        // Image
        let image = DSImageVM(imageUrl: URL.profileUrl(),
                              height: .absolute(100),
                              displayStyle: .circle)
        
        // Text
        let composer = DSTextComposer(alignment: .center)
        composer.add(type: .headlineWithSize(30), text: "John Doe")
        composer.add(type: .body, text: "john.doe@gmail.com")
        let text = composer.textViewModel()
        
        // Text section
        let section = [space1, image, space2, text].list()
        section.doubleMarginLeftRightInsets()
        
        // Show text section
        show(content: section)
    }
    
    // Show bottom content
    func showBottomContent() {
        
        let continueAsUser = DSButtonVM(title: "Continue as John",
                                        type: .default) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        let chooseAnotherAccount = DSButtonVM(title: "Choose another account",
                                              type: .link,
                                              textAlignment: .center) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        let sections = [[continueAsUser, chooseAnotherAccount].list().doubleMarginLeftRightInsets()]
        
        // Show bottom button
        showBottom(content: sections)
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct LogIn4ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: LogIn4ViewController(), DSKitAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
