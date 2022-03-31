//
//  Categories2ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Categories2ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        update()
    }
    
    func update() {
        show(content: categoriesSection())
    }
}

// MARK: - Categories

extension Categories2ViewController {
    
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
        
        let blazers = category(title: "Blazers",
                               description: "915 items",
                               image: URL.blazers)
                
        let section = [jackets, blazers, shirts, jeans, shorts, trackPants,shoes, watches].grid()
        section.headlineHeader("Categories", size: 30)
        
        return section
    }
    
    func category(title: String, description: String, image: URL? = nil) -> DSViewModel {
        
        let composer = DSTextComposer(alignment: .center)
        composer.add(type: .text(font: .headline, color: .white), text: title)
        composer.add(type: .text(font: .subheadline, color: .white), text: description)
        var card = DSCardVM(composer: composer, textPosition: .bottom, backgroundImage: .imageURL(url: image))
        card.gradientTopPosition = 0.6
        card.gradientBottomPosition = 1.0
        
        card.gradientTopColor = UIColor.black.withAlphaComponent(0.1)
        card.gradientBottomColor = UIColor.black.withAlphaComponent(0.9)
        card.didTap { [unowned self] (_:DSCardVM) in
            self.dismiss()
        }
        
        return card
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Categories2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Categories2ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
