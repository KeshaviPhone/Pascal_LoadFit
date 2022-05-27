//
//  SubClass.swift
//  PASCAL
//
//  Created by My Mac on 07/10/21.
//

import Foundation
import UIKit
import CoreData

class Main: UIViewController,UITextFieldDelegate {
    
    var orientationLock = UIInterfaceOrientationMask.portrait
    var logHistoryFile = String()
    var RecordArr: [NSManagedObject] = []
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override var shouldAutorotate : Bool {
        let landscapeValue = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(landscapeValue, forKey: "orientation")
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    func createHistoryFile() {
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let strTemp = dateformatter.string(from: date)
        logHistoryFile = "History " + strTemp.replacingOccurrences(of: ":", with: "_") + ".txt"
        let file = logHistoryFile
        let text = "\n"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            print(dir)
            let fileURL = dir.appendingPathComponent(file)
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                self.writeHistory()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func writeHistory() {
        for i in 0 ..< RecordArr.count {
            let createdDate = RecordArr[i].value(forKeyPath: "created_date") as! String
            let dateARray = createdDate.components(separatedBy: " ")
            "\nDate : \(dateARray[0])".ToFile(fileName: logHistoryFile)
            "\nTime : \(dateARray[1])".ToFile(fileName: logHistoryFile)
            "\nDevice Name : \(RecordArr[i].value(forKeyPath: "device_name")! as! String)".ToFile(fileName: logHistoryFile)
            "\nUnit : \(RecordArr[i].value(forKeyPath: "unit_type")! as! String)".ToFile(fileName: logHistoryFile)
            "\nA : \(RecordArr[i].value(forKeyPath: "chanel_A") as! String)".ToFile(fileName: logHistoryFile)
            "\nB : \(RecordArr[i].value(forKeyPath: "chanel_B") as! String)".ToFile(fileName: logHistoryFile)
            "\nTotal : \(RecordArr[i].value(forKeyPath: "total") as! String)".ToFile(fileName: logHistoryFile)
            "\n\n".ToFile(fileName: logHistoryFile)
        }
    }
    
    func DropDownOption(view:UIViewController) {
        shareDialog(view: view)
    }
    
    func shareDialog(view:UIViewController) {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileUrl = dir!.appendingPathComponent(logHistoryFile)
        var filesToShare = [Any]()
        filesToShare.append(fileUrl)
                let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                
                // exclude some activity types from the list (optional)
                activityViewController.excludedActivityTypes = [.airDrop,
                                                                .postToFacebook,
                                                                .mail,
                                                                .postToTwitter,
                                                                .postToVimeo,
                                                                .postToFlickr,
                                                                .postToWeibo]
                // present the view controller
                view.present(activityViewController, animated: true, completion: nil)
    }
}

public class CommonFunctions: NSObject  {
    
    static let shared: CommonFunctions = {
        CommonFunctions()
    }()
    func showLoader() {
    }
    
    func hideLoader() {
    }
    
}

class buttonProperties: UIButton {
   
    
    @IBInspectable var Radius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = Radius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var Border: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = Border
        }
    }
    
    @IBInspectable var BorderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    
    @IBInspectable
        var shadowRadius: CGFloat {
            get {
                return layer.shadowRadius
            }
            set {
                layer.masksToBounds = false
                layer.shadowRadius = newValue
            }
        }

        @IBInspectable
        var shadowOpacity: Float {
            get {
                return layer.shadowOpacity
            }
            set {
                layer.masksToBounds = false
                layer.shadowOpacity = newValue
            }
        }

        @IBInspectable
        var shadowOffset: CGSize {
            get {
                return layer.shadowOffset
            }
            set {
                layer.masksToBounds = false
                layer.shadowOffset = newValue
            }
        }

        @IBInspectable
        var shadowColor: UIColor? {
            get {
                if let color = layer.shadowColor {
                    return UIColor(cgColor: color)
                }
                return nil
            }
            set {
                if let color = newValue {
                    layer.shadowColor = color.cgColor
                } else {
                    layer.shadowColor = nil
                }
            }
        }
}

class labelProperties : UILabel {

    @IBInspectable var Radius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = Radius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable open var characterSpacing:CGFloat = 1 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: self.characterSpacing, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }
    }
    
    @IBInspectable var Border: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = Border
        }
    }
    
    @IBInspectable var BorderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    
}


class imageProperties : UIImageView {
    @IBInspectable var Radius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = Radius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var Border: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = Border
        }
    }
    
    @IBInspectable var BorderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    
}
@IBDesignable

class viewProperties2: UIView {
    
    @IBInspectable var dropShadow: Bool = false {
            didSet {
                layer.masksToBounds = false
                layer.cornerRadius = frame.size.height / 2
                layer.backgroundColor = UIColor.white.cgColor
                layer.borderWidth = 0.25
                layer.borderColor = UIColor.clear.cgColor
                layer.shadowColor = UIColor.gray.cgColor
                layer.shadowOffset = CGSize.zero
                layer.shadowOpacity = 1
                layer.shadowRadius = 3.0
            }
    }
    
    @IBInspectable public var fillColor: UIColor = .blue { didSet { setNeedsLayout() } }
    @IBInspectable var cut: Bool = false
    
    @IBInspectable var Radius: CGFloat = 0.0 {
        didSet {
            self.layer.masksToBounds = true

            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: Radius, height: self.Radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    @IBInspectable var bottomBorder: CGFloat = 0.0 {
        didSet {
            DispatchQueue.main.async {
                let border = CALayer()
                let width = self.bottomBorder
                border.borderColor = UIColor.darkGray.cgColor
                border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
                border.borderWidth = width
                self.layer.addSublayer(border)
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable var Border: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = Border
        }
    }
    
    @IBInspectable var BorderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    
    @IBInspectable
      var shadowRadius: CGFloat {
          get {
              return layer.shadowRadius
          }
          set {

            self.layer.shadowRadius = newValue
                let path = UIBezierPath()

                   // Start at the Top Left Corner
                   path.move(to: CGPoint(x: 0.0, y: 0.0))

                   // Move to the Top Right Corner
                   path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))

                   // Move to the Bottom Right Corner
                   path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))

                   // This is the extra point in the middle :) Its the secret sauce.
                   path.addLine(to: CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height/2.0))

                   // Move to the Bottom Left Corner
                   path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))

                   path.close()

                   self.layer.shadowPath = path.cgPath
          }
        
      }
      @IBInspectable
      var shadowOffset : CGSize{

          get{
              return layer.shadowOffset
          }set{

              layer.shadowOffset = newValue
          }
      }

      @IBInspectable
      var shadowColor : UIColor{
          get{
              return UIColor.init(cgColor: layer.shadowColor!)
          }
          set {
              layer.shadowColor = newValue.cgColor
          }
      }
      @IBInspectable
      var shadowOpacity : Float {

          get{
              return layer.shadowOpacity
          }
          set {

              layer.shadowOpacity = newValue

          }
      }
    
    
}

@IBDesignable
class viewProperties: UIView {
    @IBInspectable var dropShadow: Bool = false {
            didSet {
                layer.masksToBounds = false
                layer.cornerRadius = 50
                layer.backgroundColor = UIColor.white.cgColor
                layer.borderWidth = 0.3
                layer.borderColor = UIColor.clear.cgColor
                layer.shadowColor = UIColor.gray.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 3)
                layer.shadowOpacity = 1
                layer.shadowRadius = 5.0
            }
    }
    
    
    @IBInspectable public var fillColor: UIColor = .blue { didSet { setNeedsLayout() } }
    @IBInspectable var cut: Bool = false
    
    
    @IBInspectable var Radius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = Radius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var bottomBorder: CGFloat = 0.0 {
        didSet {
            DispatchQueue.main.async {
                let border = CALayer()
                let width = self.bottomBorder
                border.borderColor = UIColor.darkGray.cgColor
                border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
                border.borderWidth = width
                self.layer.addSublayer(border)
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable var Border: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = Border
        }
    }
    
    @IBInspectable var BorderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    
    @IBInspectable
      var shadowRadius: CGFloat {
          get {
              return layer.shadowRadius
          }
          set {

            layer.shadowRadius = newValue
          }
      }
      @IBInspectable
      var shadowOffset : CGSize{

          get{
              return layer.shadowOffset
          }set{

              layer.shadowOffset = newValue
          }
      }

      @IBInspectable
      var shadowColor : UIColor{
          get{
              return UIColor.init(cgColor: layer.shadowColor!)
          }
          set {
              layer.shadowColor = newValue.cgColor
          }
      }
      @IBInspectable
      var shadowOpacity : Float {

          get{
              return layer.shadowOpacity
          }
          set {

              layer.shadowOpacity = newValue

          }
      }
    
    
}

class textFieldProperties2: UITextField {
    @IBInspectable var dropShadow: Bool = false {
            didSet {
                borderStyle = UITextField.BorderStyle.none
                layer.masksToBounds = false
                layer.cornerRadius = 20
                layer.backgroundColor = UIColor.white.cgColor
                layer.borderWidth = 0.25
                layer.borderColor = UIColor.clear.cgColor
                layer.shadowColor = UIColor.gray.cgColor
                layer.shadowOffset = CGSize.zero
                layer.shadowOpacity = 1
                layer.shadowRadius = 3.0
            }
    }
}

class textFieldProperties: UITextField {
    @IBInspectable var dropShadow: Bool = false {
            didSet {
                borderStyle = UITextField.BorderStyle.none
                layer.masksToBounds = false
                layer.cornerRadius = frame.size.height / 2
                layer.backgroundColor = UIColor.white.cgColor
                layer.borderWidth = 0.25
                layer.borderColor = UIColor.clear.cgColor
                layer.shadowColor = UIColor.gray.cgColor
                layer.shadowOffset = CGSize.zero
                layer.shadowOpacity = 1
                layer.shadowRadius = 3.0
            }
    }
    
    
//    @IBInspectable var key:String? // KEY
//    override func awakeFromNib() {
//
//        if let  text = self.key?.localize {
//            self.placeholder = text
//        }
//    }
    
    @IBInspectable var MasksToBounds: Bool = false {
        didSet {
            self.layer.masksToBounds = false
        }
    }
    
    @IBInspectable var Radius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = Radius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var Border: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = Border
        }
    }
    
    @IBInspectable var BorderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    
    @IBInspectable var LeftSpace: CGFloat = 0 {
        didSet {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: LeftSpace, height: self.frame.size.height))
            view.backgroundColor = UIColor.clear
            self.leftView = view
            self.leftViewMode = .always
        }
    }
    
    @IBInspectable var leftImage : UIImage? {
         didSet {
             if let image = leftImage{
                 leftViewMode = .always
                 let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 18, height: 18))
                 imageView.image = image
                 imageView.tintColor = tintColor
                 imageView .contentMode = .scaleAspectFit
                 let view = UIView(frame : CGRect(x: 0, y: 0, width: 35, height: 20))
                 view.addSubview(imageView)
                 leftView = view
             }else {
                 leftViewMode = .never
             }

         }
     }
    
    @IBInspectable var RightSpace: CGFloat = 0 {
        didSet {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: RightSpace, height: self.frame.size.height))
            view.backgroundColor = UIColor.clear
            self.rightView = view
            self.rightViewMode = .always
        }
    }
    
    @IBInspectable var RightImage: UIImage? {
        didSet {
            let vw = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
            let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            iv.image = RightImage
            iv.contentMode = .center
            vw.addSubview(iv)
            self.rightView = vw
            self.rightViewMode = .always
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: placeHolderColor!])
        }
    }
    
    @IBInspectable var bottomBorder:CGFloat = 0 {
        didSet {
            DispatchQueue.main.async {
                let border = CALayer()
                let width = self.bottomBorder
                border.borderColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0).cgColor
                border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
                border.borderWidth = width
                self.layer.addSublayer(border)
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable
      var shadowRadius: CGFloat {
          get {
              return layer.shadowRadius
          }
          set {

            self.layer.shadowRadius = newValue
                let path = UIBezierPath()

                   // Start at the Top Left Corner
                   path.move(to: CGPoint(x: 0.0, y: 0.0))

                   // Move to the Top Right Corner
                   path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))

                   // Move to the Bottom Right Corner
                   path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))

                   // This is the extra point in the middle :) Its the secret sauce.
                   path.addLine(to: CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height/2.0))

                   // Move to the Bottom Left Corner
                   path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))

                   path.close()

                   self.layer.shadowPath = path.cgPath
          }
        
      }
      @IBInspectable
      var shadowOffset : CGSize{

          get{
              return layer.shadowOffset
          }set{

              layer.shadowOffset = newValue
          }
      }

      @IBInspectable
      var shadowColor : UIColor{
          get{
              return UIColor.init(cgColor: layer.shadowColor!)
          }
          set {
              layer.shadowColor = newValue.cgColor
          }
      }
      @IBInspectable
      var shadowOpacity : Float {

          get{
              return layer.shadowOpacity
          }
          set {

              layer.shadowOpacity = newValue

          }
      }
}

class textViewProperties: UITextView {
    
     @IBInspectable open var leftImage:UIImage? {
             didSet {
                if (leftImage != nil) {
                   self.leftImage(leftImage!)
                }
            }
        }

    fileprivate func leftImage(_ image: UIImage) {
        let icn : UIImage = image
        let imageView = UIImageView(image: icn)
        imageView.frame = CGRect(x: 0, y: 2.0, width: 30, height: 30)
        imageView.contentMode = UIView.ContentMode.center

    }
    
    
    @IBInspectable var dropShadow: Bool = false {
        didSet {
            let shadowPath = UIBezierPath(rect: bounds)
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
            layer.shadowOpacity = 0.5
            layer.shadowPath = shadowPath.cgPath
        }
    }
    
    
//    @IBInspectable var key:String? // KEY
//    override func awakeFromNib() {
//
//        if let  text = self.key?.localize {
//            self.placeholder = text
//        }
//    }
    
    @IBInspectable var Radius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = Radius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var Border: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = Border
        }
    }
    
    @IBInspectable var BorderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    

    @IBInspectable var bottomBorder:CGFloat = 0 {
        didSet {
            DispatchQueue.main.async {
                let border = CALayer()
                let width = self.bottomBorder
                border.borderColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0).cgColor
                border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
                border.borderWidth = width
                self.layer.addSublayer(border)
                self.layer.masksToBounds = true
            }
        }
    }
}

extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.lightGray, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

extension UILabel {
    func underlineMyText(range1:String) {
        if let textString = self.text {
            let str = NSString(string: textString)
            let firstRange = str.range(of: range1)
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: firstRange)
            attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.lightGray, range: NSRange(location: 0, length: range1.count))
            attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: range1.count))
            attributedText = attributedString
        }
    }
}

