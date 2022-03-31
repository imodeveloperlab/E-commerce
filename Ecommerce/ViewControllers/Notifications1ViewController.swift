//
//  Notifications1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class Notifications1ViewController: DSViewController {
    
    // Random data generator, an wrapper around https://github.com/vadymmarkov/Fakery
    let person = DSFaker().person
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notifications"
        
        // Decoration icon
        decorationIcon = DSDecorationIcon(name: "bell.fill",
                                          position: .topRight,
                                          size: .init(width: 60, height: 60),
                                          offset: .init(x: -30, y: 120),
                                          alpha: 1.0,
                                          color: appearance.secondaryView.background)
        update()
    }
    
    /// Update current content on the screen
    func update() {
        show(content: turnOnNotificationSection())
        showBottom(content: [shipButton().list().doubleMarginLeftRightInsets()])
    }
    
    /// Turn on notifications section
    /// - Returns: DSSection
    func turnOnNotificationSection() -> DSSection {
        
        // Spaces
        let space = DSSpaceVM(type: .custom(150))
        let space2 = DSSpaceVM(type: .custom(50))
        
        // Text
        let composer = DSTextComposer(alignment: .natural)
        composer.add(type: .headlineWithSize(36),
                     text: "Turn on\nnotifications",
                     spacing: 10,
                     maximumLineHeight: 36)
        
        composer.add(type: .body,
                     text: "Meet new people, create posts, find friends and more.")
        
        let text = composer.textViewModel()
        
        // Bottom label
        let bottomLabel = DSLabelVM(.caption1, text: "Enable notifications to make sure you don't miss out the post from your friends")
        
        return [space,
                text,
                space2,
                switchNotifications(),
                bottomLabel].list().doubleMarginLeftRightInsets()
    }
    
    /// Notifications switch
    /// - Returns: DSViewModel
    func switchNotifications() -> DSViewModel {
        
        // Title
        let composer = DSTextComposer()
        composer.add(type: .headline, text: "Notifications")
        var model = composer.actionViewModel()
        model.height = .absolute(50)
        
        // Switch
        var switchModel = DSSwitchVM(isOn: true)
        switchModel.didUpdate = { isOn in
            print(isOn)
        }
        
        // Set switch as right side view
        model.rightSideView = DSSideView(view: switchModel)
        
        return model
    }
    
    func shipButton() -> DSViewModel {
        
        let button = DSButtonVM(title: "Another time", type: .primaryViewWithBorder) { [unowned self] _ in
            self.dismiss()
        }
        
        return button
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Notifications1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Notifications1ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
