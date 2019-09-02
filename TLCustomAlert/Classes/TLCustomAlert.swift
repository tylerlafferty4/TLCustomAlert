//
//  TLCustomAlert.swift
//  TLCustomAlert
//
//  Created by Tyler Lafferty on 8/21/19.
//  Copyright © 2019 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

// -------------------------------------------------------------------
// -------------------------------------------------------------------
// ------------------------ ALERT VIEW -----------------------------
// -------------------------------------------------------------------
// -------------------------------------------------------------------
public class TLCustomAlertView : UIView {
    
    var alertBackgroundView : UIView!
    var closeAction:(()->Void)!
    var cancelAction:(()->Void)!
    var confirm: TLCustomAlertAction!
    var cancel: TLCustomAlertAction!
    var dismissButton : UIButton!
    var cancelButton: UIButton!
    var blurView: UIVisualEffectView!
    
    // Sizing setup
    let baseHeight: CGFloat = 160.0
    let alertWidth: CGFloat = 290.0
    let buttonHeight: CGFloat = 70.0
    let padding: CGFloat = 20.0
    let viewWidth:CGFloat = UIScreen.main.bounds.width
    let viewHeight:CGFloat = UIScreen.main.bounds.height
    var yPos: CGFloat = 0.0
    var contentWidth: CGFloat!
    var buttonWidth: CGFloat!
    
    var background = UIColor.white
    var lightBackground = UIColor.groupTableViewBackground
    var textColor = UIColor.black
    
    public func showAlertView(superview: UIView, title: String, text: String, img: String?=nil, confirmAction: TLCustomAlertAction?=nil, cancelAction: TLCustomAlertAction?=nil) {
        
        // The two actions that get passed in
        confirm = confirmAction
        cancel = cancelAction
        contentWidth = alertWidth - (padding*2)
        
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        
        blurView.frame = CGRect(x: 0, y: 0, width: superview.frame.width, height: superview.frame.height)
        self.addSubview(blurView)
        self.backgroundColor = UIColor.clear
        superview.addSubview(self)
        superview.bringSubview(toFront: self)
        
        // Background view
        // Every subview gets add to the alertBackgroundView which then
        // gets added to the superview
        alertBackgroundView = UIView()
        alertBackgroundView.backgroundColor = background
        alertBackgroundView.layer.cornerRadius = 4
        alertBackgroundView.clipsToBounds = true
        self.addSubview(alertBackgroundView)
        // Icon
        if img != nil {
            setupImageView(img: img!)
        }
        // Title
        setupTitleLabel(title: title)
        // Message Text
        setupMessageText(text: text)
        // Add to padding
        yPos += padding
        buttonWidth = alertWidth
        // Second cancel button
        if cancel != nil {
            setupCancelButton()
        }
        // Confirm Button
        setupConfirmButton()
        yPos += buttonHeight
        alertBackgroundView.frame = CGRect(x: (viewWidth-alertWidth)/2, y: (superview.frame.height-yPos)/2, width: alertWidth, height: yPos)
        self.frame = CGRect(x: 0, y: 0, width: superview.frame.width, height: superview.frame.height)
        alertBackgroundView.center.x = superview.center.x
        alertBackgroundView.center.y = -500
        blurView.alpha = 0
        UIView.animate(withDuration: 0.6, delay: 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: { () -> Void in
            self.blurView.alpha = 1
            self.alertBackgroundView.center = CGPoint(x: self.alertBackgroundView.center.x, y: superview.frame.height/2)
        }) { (Bool) -> Void in
            
        }
    }
    
    // ------------------------------------------------------------
    // -- Button taps call the handler that is setup up when making
    // -- the alert view. If no actions are passed in, the button will
    // -- just dismiss the alert.
    // ------------------------------------------------------------
    @objc func buttonTap() {
        if confirm != nil {
            confirm.handler()
        }
        closeAlert()
    }
    @objc func cancelButtonTap() {
        if cancel != nil {
            cancel.handler()
        }
        closeAlert()
    }
    
    // Used to close the alert view
    func closeAlert() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: { () -> Void in
            self.blurView.alpha = 0
            self.alertBackgroundView.center.y += 500
        }, completion: { (Bool) -> Void in
            self.removeFromSuperview()
        })
    }
}

// MARK: Setup Functions
extension TLCustomAlertView {
    // Setup the image view
    private func setupImageView(img : String) {
        let iconImageView : UIImageView! = UIImageView()
        let image = UIImage(named: img)?.withRenderingMode(.alwaysTemplate)
        iconImageView.image = image
        iconImageView.tintColor = textColor
        let centerX = (alertWidth-iconImageView.frame.width)/2
        iconImageView.frame = CGRect(x: centerX, y: padding, width: (image?.size.width)!, height: (image?.size.height)!)
        iconImageView.center = CGPoint(x: alertWidth/2, y: iconImageView.center.y)
        iconImageView.contentMode = .center
        yPos += iconImageView.frame.height
        alertBackgroundView.addSubview(iconImageView)
        yPos += padding
    }
    
    // Setup the title Label
    private func setupTitleLabel(title : String) {
        let titleLbl = UILabel()
        titleLbl.textColor = textColor
        titleLbl.numberOfLines = 0
        titleLbl.textAlignment = .center
        titleLbl.font = UIFont(name: "HelveticaNeue-Light", size: 24)
        titleLbl.text = title
        let titleString = titleLbl.text! as NSString
        let titleAttr = [NSAttributedString.Key.font:titleLbl.font]
        let titleSize = CGSize(width: contentWidth, height: 90)
        let titleRect = titleString.boundingRect(with: titleSize, options: .usesLineFragmentOrigin, attributes: titleAttr as [NSAttributedStringKey : Any], context: nil)
        yPos += padding
        titleLbl.frame = CGRect(x: padding, y: yPos, width: alertWidth-(padding*2), height: ceil(titleRect.size
            .height))
        yPos += ceil(titleRect.size.height)
        alertBackgroundView.addSubview(titleLbl)
    }
    
    // Setup message text
    private func setupMessageText(text : String) {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.isEditable = false
        textView.textColor = textColor
        textView.textAlignment = .center
        textView.font = UIFont(name: "HelveticaNeue", size: 16)
        textView.backgroundColor = UIColor.clear
        textView.text = text
        let textString = textView.text! as NSString
        let textAttr = [NSAttributedString.Key.font:textView.font as AnyObject]
        let realSize = textView.sizeThatFits(CGSize(width: contentWidth, height: CGFloat.greatestFiniteMagnitude))//CGSizeMake(contentWidth, CGFloat.max))
        let textSize = CGSize(width: contentWidth, height: CGFloat(fmaxf(Float(90.0), Float(realSize.height))))
        let textRect = textString.boundingRect(with: textSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: textAttr, context: nil)
        textView.frame = CGRect(x: padding, y: yPos, width: alertWidth - (padding*2), height: ceil(textRect.size.height)*2)
        yPos += ceil(textRect.size.height) + padding/2
        alertBackgroundView.addSubview(textView)
    }
    
    // Setup Cancel Button
    private func setupCancelButton() {
        buttonWidth = alertWidth/2
        cancelButton = UIButton()
        cancelButton.backgroundColor = lightBackground
        
        cancelButton.addTarget(self, action: #selector(TLCustomAlertView.cancelButtonTap), for: .touchUpInside)
        cancelButton.frame = CGRect(x: 0, y: yPos, width: buttonWidth-1, height: buttonHeight)
        alertBackgroundView.addSubview(cancelButton)
        // Button text
        let cancelButtonLabel = UILabel()
        cancelButtonLabel.alpha = 0.7
        cancelButtonLabel.textColor = textColor
        cancelButtonLabel.numberOfLines = 1
        cancelButtonLabel.textAlignment = .center
        cancelButtonLabel.text = cancel.title
        cancelButtonLabel.frame = CGRect(x: padding, y: (buttonHeight/2)-15, width: buttonWidth-(padding*2), height: 30)
        cancelButton.addSubview(cancelButtonLabel)
    }
    
    // Setup Confirm Button
    private func setupConfirmButton() {
        dismissButton = UIButton()
        dismissButton.backgroundColor = lightBackground
        //dismissButton.addTarget(self, action: "buttonTap", forControlEvents: .TouchUpInside)
        dismissButton.addTarget(self, action: #selector(TLCustomAlertView.buttonTap), for: .touchUpInside)
        let buttonX = buttonWidth == alertWidth ? 0 : buttonWidth
        dismissButton.frame = CGRect(x: buttonX!, y: yPos, width: buttonWidth, height: buttonHeight)
        alertBackgroundView.addSubview(dismissButton)
        // Button text
        let buttonLabel = UILabel()
        buttonLabel.textColor = textColor
        buttonLabel.numberOfLines = 1
        buttonLabel.textAlignment = .center
        if confirm != nil {
            buttonLabel.text = confirm.title
        } else {
            buttonLabel.text = "OK"
        }
        buttonLabel.frame = CGRect(x: padding, y: (buttonHeight/2)-15, width: buttonWidth-(padding*2), height: 30)
        dismissButton.addSubview(buttonLabel)
    }
}

// MARK: TLCustomAlertView Helpers
extension TLCustomAlertView {
    private func adjustBrightness(color:UIColor, amount:CGFloat) -> UIColor {
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha:CGFloat = 0
        if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            brightness += (amount-1.0)
            brightness = max(min(brightness, 1.0), 0.0)
            return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        }
        return color
    }
}

// MARK: TLCustomAlertAction
// -------------------------------------------------
// -- These are used to call functions in the parent
// -- class when a button on the alert view is clicked
// -------------------------------------------------
public class TLCustomAlertAction : NSObject {
    
    public var handler : () -> Void
    public var title : String
    
    public init(title: String, handler: (() -> Void)?) {
        self.title = title
        self.handler = handler!
    }
}

