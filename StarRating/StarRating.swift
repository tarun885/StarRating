//
//  StarRating.swift
//  StarRating
//
//  Created by Tarun Jain on 29/07/22.
//

import UIKit

@IBDesignable
public class StarRating: UIControl {
    
    /// Number of total stars
    @IBInspectable lazy public var totalStars: Int = 3
    
    /// Number of selected stars
    @IBInspectable lazy public var selectedStars: Int = 1 {
        didSet {
            showStarRating() // Update stars as the value gets set
        }
    }
    
    /// A layout container view to hold and layout stars
    lazy private var starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    /// Initialize StarRating view with default values of Total Stars and Selected Stars
    /// - Parameter frame: frame of the view
    public convenience override init(frame: CGRect) {
        self.init(frame: frame, totalStars: 3, selectedStars: 1)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // Loading Star View when initialized from Storyboard
        loadStarRating()
    }
    
    /// Initialize StarRating view with custom values of Total Stars and Selected Stars
    /// - Parameters:
    ///   - frame: frame of the view
    ///   - totalStars: Number of total stars
    ///   - selectedStars: Number of selected stars
    public init(frame: CGRect, totalStars: Int, selectedStars: Int) {
        guard (3...10).contains(totalStars) else {
            fatalError("Please specify total stars value within the range of 3 to 10")
        }
        super.init(frame: frame)
        loadStarRating()
        self.totalStars = totalStars
        self.selectedStars = selectedStars
    }
    
}

// MARK: - UI Methods
extension StarRating {
    
    /// Load and layout Star View
    private func loadStarRating() {
        // Add and layout starStackView
        addSubview(starStackView, anchors: [.top(0), .bottom(0), .leading(0), .trailing(0)])
        // Making this element Accessible
        isAccessibilityElement = true
    }
    
    /// Show and update Stars
    private func showStarRating() {
        for i in 0..<totalStars {
            let starImageName: String = i < selectedStars ? .Symbols.starFill : .Symbols.star
            let starImage = UIImage(systemName: starImageName)
            if i < starStackView.arrangedSubviews.count, let starImageView = starStackView.arrangedSubviews[i] as? UIImageView {
                // Update star image
                starImageView.image = starImage
            } else {
                // Add star image
                let starImageView = UIImageView(image: starImage)
                starImageView.contentMode = .scaleAspectFit
                starStackView.addArrangedSubview(starImageView)
            }
        }
        
        // Setting Accessibility description for VoiceOver
        accessibilityLabel = "\(selectedStars) stars selected out of \(totalStars)"
        
        // Set value change event action
        sendActions(for: .valueChanged)
    }
    
}

// MARK: - Selector methods for touch gesture handler
extension StarRating {
    
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        /// `X` Position of user touch within the Star View's bounds
        let xPosition = touch.location(in: self).x
        /// Calculate new selected stars based on the xPosition
        calculateNewStars(basedOn: xPosition)
        return true
    }
    
    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        var xPosition:CGFloat = 0
        
        xPosition += touch.location(in: self).x
        
        if xPosition < 0 {
            /// Maintaining lowest possible value
            xPosition = 0
        }
        
        if xPosition > bounds.maxX {
            /// Maintaining highest possible value
            xPosition = bounds.maxX
        }
        
        calculateNewStars(basedOn: xPosition)
        return true
    }
    
    private func calculateNewStars(basedOn position: CGFloat) {
        /// Based on the position to width ratio calculating selected stars from total stars.
        /// Example: User taps on 2/3 part of the star view which gives us 2/3 of the total stars. Rounding it to whole number gives us Selected Stars.
        /// `2/3 * 5(total stars) = 3.33 =~ 4(selected stars)`
        let newSelectedStars = Int(ceil(position / bounds.width * CGFloat(totalStars)))
        
        // Update selected stars only when newly selected is different than the old value
        if newSelectedStars != selectedStars {
            selectedStars = newSelectedStars
        }
    }
    
}
