//
//  Categories3ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Categories3ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        update()
    }
    
    func update() {
        show(content: categoriesSection())
    }
}

// MARK: - Categories

extension Categories3ViewController {
    
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
                
        let section = [blazers, jeans, trackPants, watches, jackets, shirts, shorts, shoes].list()
        section.headlineHeader("Categories", size: 30)
        
        return section
    }
    
    func category(title: String, description: String, image: URL? = nil) -> DSViewModel {
        
        let composer = DSTextComposer(alignment: .center)
        
        composer.add(type: .text(font: .headlineWithSize(25), color: .white), text: title)
        composer.add(type: .text(font: .subheadline, color: .white), text: description)
        var card = DSCardVM(composer: composer, textPosition: .center, backgroundImage: .imageURL(url: image))
        card.height = .absolute(200)
        card.gradientTopColor = UIColor.black.withAlphaComponent(0.2)
        card.gradientBottomColor = UIColor.black.withAlphaComponent(0.5)
        card.didTap { [unowned self] (_:DSCardVM) in
            self.dismiss()
        }
        
        return card
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Categories3ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Categories3ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
