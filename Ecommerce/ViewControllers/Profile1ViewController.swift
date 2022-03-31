//
//  Profile1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class Profile1ViewController: DSViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        update()
    }
    
    /// Update current content on the screen
    func update() {
        
        // Show authorized user sections
        self.show(content: [getProfileDescription(),
                            getProfileSettingsSection(),
                            getGeographySection(),
                            getMemberShipSection()])
        
        self.showBottom(content: getLogOutSection())
    }
}

// MARK: - Loged In User
extension Profile1ViewController {
    
    /// Get profile geography sections
    /// - Returns: DSSection
    func getGeographySection() -> DSSection {
        
        let header = DSLabelVM(.subheadline, text: "Geography")
        
        var changeLocation = action(title: "Change location", leftSymbol: "location.fill")
        changeLocation.didTap { [unowned self] (_ : DSActionVM) in
            self.pop()
        }
        
        var changeLanguage = action(title: "Change language", leftSymbol: "textformat.alt")
        changeLanguage.didTap { [unowned self] (_ : DSActionVM) in
            self.pop()
        }
        
        return [header, changeLocation, changeLanguage].list()
    }
    
    /// Get membership section
    /// - Returns: DSSection
    func getMemberShipSection() -> DSSection {
        
        let header = DSLabelVM(.subheadline, text: "Membership")
        
        var loyaltyCards = action(title: "Loyalty Cards", leftSymbol: "giftcard.fill")
        loyaltyCards.didTap { [unowned self] (_ : DSActionVM) in
            self.pop()
        }
        
        var membership = action(title: "Membership", leftSymbol: "person.2.fill")
        membership.didTap { [unowned self] (_ : DSActionVM) in
            self.pop()
        }
        
        var certificates = action(title: "Certificates", leftSymbol: "rectangle.fill")
        certificates.didTap { [unowned self] (_ : DSActionVM) in
            self.pop()
        }
        
        return [header, loyaltyCards, membership, certificates].list()
    }
    
    /// Profile settings section
    /// - Returns: DSSection
    func getProfileSettingsSection() -> DSSection {
        
        var notifications = action(title: "Notifications", leftSymbol: "bell.fill")
        notifications.didTap { [unowned self] (_ : DSActionVM) in
            self.pop()
        }
        
        notifications.supplementaryItems = [badgeView(count: 3)]

        var passwordUpdate = action(title: "Password Update", leftSymbol: "lock.fill")
        passwordUpdate.didTap { [unowned self] (_ : DSActionVM) in
            self.pop()
        }
        
        return [notifications, passwordUpdate].list()
    }
    
    /// Badge View
    /// - Parameter count: Badge count
    /// - Returns: DSSupplementaryView
    func badgeView(count: Int) -> DSSupplementaryView {
        
        var label = DSLabelVM(.text(font: .headlineWithSize(12), color: .white),
                              text: count.string(), alignment: .center)
        
        label.width = .absolute(25)
        label.height = .absolute(25)
        
        return label.asSupplementary(position: .rightCenter,
                                     background: .custom(UIColor.systemRed),
                                     insets: .insets(.zero),
                                     offset: .custom(CGPoint(x: 30, y: 0)),
                                     cornerRadius: .custom(10))
    }
    
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
    
    /// Log out section
    /// - Returns: DSSection
    func getLogOutSection() -> DSSection {
        
        var button = DSButtonVM(title: "Log out")

        button.didTap { [unowned self] (_: DSButtonVM) in
            
            self.show(message: "Log out", timeOut: 2) {
                self.pop()
            }
        }
        
        return [button].list()
    }
}

// MARK: - Guest User
extension Profile1ViewController {
    
    /// Guest user profile section
    /// - Returns: DSSection
    func getGuestUserProfileSection() -> DSSection {
        
        var certificates = action(title: "Certificates", leftSymbol: "rectangle.stack.fill.badge.person.crop")
        
        certificates.didTap { [unowned self] (_ : DSActionVM) in
            self.pop()
        }
        
        var changeLocation = action(title: "Change location", leftSymbol: "location.fill.viewfinder")
        changeLocation.didTap { [unowned self] (_ : DSActionVM) in
            self.pop()
        }
        
        var changeLanguage = action(title: "Change language", leftSymbol: "doc.richtext.fill")
        changeLanguage.didTap { [unowned self] (_ : DSActionVM) in
            self.pop()
        }
        
        let section = [certificates, changeLocation, changeLanguage].list()
        section.subheadlineHeader("Settings")
        
        return section
    }
}

// MARK: - Helpers
extension Profile1ViewController {
    
    /// Get action view model
    /// - Parameters:
    ///   - title: String
    ///   - subtitle: String?
    ///   - leftSymbol: leftSymbol
    /// - Returns: DSActionVM
    func action(title: String, subtitle: String? = nil, leftSymbol: String? = nil) -> DSActionVM {
        return DSActionVM(title: title, subtitle: subtitle, leftSFSymbol: leftSymbol)
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Profile1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Profile1ViewController())
            PreviewContainer(VC: nav, BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
