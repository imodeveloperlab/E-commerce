//
//  SubscriptionPlan1ViewController.swift
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

open class SubscriptionPlan1ViewController: DSViewController {
    
    var selectedPlanIndex = 0
    var selectedPlanTitle = "Start - Free"
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Decoration icon
        decorationIcon = DSDecorationIcon(name: "bookmark.fill",
                                          position: .topRight,
                                          size: CGSize(width: 60, height: 80),
                                          offset: CGPoint(x: -25, y: 80),
                                          alpha: 1.0,
                                          color: appearance.secondaryView.background)
        update()
        updateBottomButton()
    }
    
    func update() {
        
        // Spaces
        let space = DSSpaceVM(type: .custom(70))
        let space2 = DSSpaceVM(type: .custom(20))
        
        // Text
        let composer = DSTextComposer(alignment: .natural)
        composer.add(type: .headlineWithSize(36), text: "Subscription\nPlan")
        composer.add(type: .body, text: "Biggest collection\nof news, article & news")
        let text = composer.textViewModel()
        
        let descriptionSection = [space, text, space2].list()
        descriptionSection.doubleMarginLeftRightInsets()
        
        let planDescription = DSLabelVM(.subheadline, text: "Choose a plan to access various content for defined time period")
        
        // Sections
        let sections = [descriptionSection,
                        getPlansSection(),
                        planDescription.list().doubleMarginLeftRightInsets()]
        
        // Show sections
        show(content: sections, animated: false)
    }
    
    // Bottom buttons
    func updateBottomButton() {
        
        let skip = DSButtonVM(title: selectedPlanTitle, type: .default) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        showBottom(content: [skip].list().doubleMarginLeftRightInsets())
    }
}

// MARK: - Form section

extension SubscriptionPlan1ViewController {
    
    /// Plans sections
    /// - Returns: DSSection
    func getPlansSection() -> DSSection {
        
        let startCheckBox = checkboxViewModel(title: "Start - Free", subtitle: "Learn, explore, and create", index: 0)
        let professionalCheckBox = checkboxViewModel(title: "Professional - $19/m", subtitle: "A good fit for landing pages", index: 1)
        let teamCheckBox = checkboxViewModel(title: "Team - $48/mo", subtitle:"For more complex projects", index: 2)
        
        return [startCheckBox, professionalCheckBox, teamCheckBox].list().doubleMarginLeftRightInsets()
    }
    
    /// Get checkbox view model
    /// - Parameters:
    ///   - title: String
    ///   - subtitle: String
    ///   - index: Int
    /// - Returns: DSActionVM
    func checkboxViewModel(title: String, subtitle: String, index: Int) -> DSActionVM {
        
        let text = DSTextComposer()
        text.add(type: .headline, text: title)
        text.add(type: .subheadline, text: subtitle)
        var checkBox = text.checkboxActionViewModel(selected: selectedPlanIndex == index)
        
        if selectedPlanIndex == index {
            selectedPlanTitle = title
        }
        
        checkBox.didTap { [unowned self] (_: DSActionVM) in
            self.selectedPlanIndex = index
            self.update()
            self.updateBottomButton()
        }
        
        return checkBox
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct SubscriptionPlan1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: SubscriptionPlan1ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
