//
//  Categories3ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Categories6ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        update()
    }
    
    func update() {
        show(content: categoriesSection())
    }
}

// MARK: - Categories

extension Categories6ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func categoriesSection() -> DSSection {
        
        // 1
        let shoes = category(title: "Shoes",
                             description: "812 items",
                             image:  URL.sneakersNeon, badge: "Sales")
        
        // 2
        let shirts = category(title: "Shirts",
                              description: "1.4K items",
                              image: URL.personOnNeonRegBg,
                              badge: "30% OFF")
        
        // 3
        let jeans = category(title: "Jeans",
                             description: "345 items",
                             image: URL.personOnMarineBg)
        
        // 4
        let watches = category(title: "Watches",
                               description: "20K items",
                               image: URL.watchesOnYellowBg)
        
        // 5
        let shorts = category(title: "Shorts",
                              description: "2.5k items",
                              image: URL.personInWhite,
                              badge: "50% OFF")
        
        // 6
        let trackPants = category(title: "Track Pants",
                                  description: "600 items",
                                  image: URL.pantsTrack)
        
        // 7
        let jackets = category(title: "Jackets",
                               description: "20K items",
                               image: URL.personOnOrangeBg)
        
        // 8
        let blazers = category(title: "Blazers",
                               description: "915 items",
                               image: URL.personOnPurpleNeonBg,
                               badge: "70% OFF")
        
        let section = [shoes, shirts, watches, jackets, jeans, shorts, trackPants, blazers].grid()
        
        section.headlineHeader("Categories", size: 30)
        
        return section
    }
    
    func category(title: String, description: String, image: URL? = nil, badge: String? = nil) -> DSViewModel {
        
        let composer = DSTextComposer(alignment: .center)
        composer.add(type: .headline, text: title)
        composer.add(type: .subheadline, text: description)
        
        var action = composer.actionViewModel()
        action.topImage(url: image)
        action.height = .absolute(226)
        
        // Like button
        action.supplementaryItems = [likeButton()]
        
        // Label
        if let badge = badge {
            action.supplementaryItems?.append(label(title: badge))
        }
        
        action.didTap { [unowned self] (_ :DSActionVM) in
            self.dismiss()
        }
        
        return action
    }
    
    /// Label supplementary view
    /// - Parameter title: String
    /// - Returns: DSSupplementaryView
    func label(title: String) -> DSSupplementaryView {
        
        let label = DSLabelVM(.text(font: .headlineWithSize(12), color: .white),
                              text: title)
        
        let supView = DSSupplementaryView(view: label,
                                          position: .leftTop,
                                          background: .lightBlur,
                                          insets: .small)
        return supView
    }
    
    /// Like button
    /// - Returns: DSSupplementaryView
    func likeButton() -> DSSupplementaryView {
        
        var button = DSButtonVM(icon: UIImage(systemName: "heart.fill"),
                                type: .blur(effect: .light, color: .white)) { [unowned self] button in
            self.dismiss()
        }
        
        button.width = .absolute(30)
        button.height = .absolute(30)
        
        let supView = DSSupplementaryView(view: button,
                                          position: .rightTop,
                                          background: .clear)
        
        return supView
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Categories6ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Categories6ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
