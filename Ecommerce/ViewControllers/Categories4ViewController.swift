//
//  Categories3ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Categories4ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        update()
    }
    
    func update() {
        show(content: categoriesSection())
    }
}

// MARK: - Categories

extension Categories4ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func categoriesSection() -> DSSection {
        
        let shoes = category(title: "Shoes",
                             description: "812 items",
                             image:  URL.shoesThreePairs)
        
        let shirts = category(title: "Shirts",
                              description: "1.4K items",
                              image: URL.shirtsThreePairs)
        
        let jeans = category(title: "Jeans",
                             description: "345 items",
                             image: URL.jeansOnBlackBg)
        
        let watches = category(title: "Watches",
                               description: "20K items",
                               image: URL.watchesOnYellowBg)
        
        let shorts = category(title: "Shorts",
                              description: "2.5k items",
                              image: URL.personInWhite)
        
        let trackPants = category(title: "Track Pants",
                                  description: "600 items",
                                  image: URL.pantsTrack)
        
        let jackets = category(title: "Jackets",
                               description: "20K items",
                               image: URL.personOnOrangeBg)
        
        let blazers = category(title: "Blazers", description: "915 items", image: URL.blazers)
                
        // Grid section
        let section = [shoes, watches, jackets, blazers, shirts, jeans, shorts, trackPants].grid()
        
        // Header
        section.headlineHeader("Categories", size: 30)
        
        return section
    }
    
    /// Category
    /// - Parameters:
    ///   - title: String
    ///   - description: String
    ///   - image: URL?
    /// - Returns: DSViewModel
    func category(title: String, description: String, image: URL? = nil) -> DSViewModel {
        
        let composer = DSTextComposer(alignment: .center)
        composer.add(type: .headline, text: title)
        composer.add(type: .subheadline, text: description)
        
        var action = composer.actionViewModel()
        action.topImage(url: image)
        action.height = .absolute(180)
        action.didTap { [unowned self] (_ :DSActionVM) in
            self.dismiss()
        }
     
        return action
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Categories4ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Categories4ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
