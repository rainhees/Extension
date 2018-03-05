//
//  JamExtension.swift
//  JAM
//
//  Created by Dukhee Kang on 2017. 6. 7..
//  Copyright © 2017년 JAM. All rights reserved.
//

import Foundation

extension UILabel
{
    /**
     
     uilabel 에 이미지 입력
     이미지 | 라벨 텍스트
     @param image name :String
     @returns uilabel : UILabel
     @exception <#throws#>
     */
    func addImage(_ imageName: String)
    {
        
        //image NSTextAttachment설정
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        
        let centerY = -(attachment.image?.size.height)!/2 - self.font.descender
        
        attachment.bounds = CGRect(x: 0, y: centerY, width: (attachment.image?.size.width)!, height: (attachment.image?.size.height)!)
        
        //NSTextAttachment NSAttributedString설정
        let attachmentString = NSAttributedString(attachment: attachment)
        
        //기존 라벨의 문자열
        let lableString = NSAttributedString(string: " \(self.text!)")
        
        //mutableatrributestring 생성
        let fullString = NSMutableAttributedString()
        fullString.append(attachmentString)
        fullString.append(lableString)
        
        self.attributedText = fullString
    }
    
    /**
     
     uilabel의 텍스트이 행간 간격 조절
     @param 행간 간격 : CGFloat
     @returns uilabel:UILabel
     @exception <#throws#>
     */

    func addLineSpacing(_ space:CGFloat) {
        if let textString = text {
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = space
            
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}

extension UITextField{
    /**
     
     텍스트 필드 placeholad 컬러 변경
     @param <#parameter#>
     @returns <#retval#>
     @exception <#throws#>
     */
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
}

extension UITextView{
    /**
     
     UITextView placeHolder 입력
     @param image name :String
     @returns <#retval#>
     @exception <#throws#>
     */
    func setPlaceholder(_ placeString : String) {
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeString
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (self.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 999
        placeholderLabel.frame.origin = CGPoint(x: 11, y: 15)
        placeholderLabel.textColor = UIColor(rgb:0x888888)
        placeholderLabel.isHidden = !self.text.isEmpty
        
        self.addSubview(placeholderLabel)
    }
    
    /**
     
     UITextView placeHolder 숨김처리
     @param <#parameter#>
     @returns <#retval#>
     @exception <#throws#>
     */
    func checkPlaceholder() {
        let placeholderLabel = self.viewWithTag(999) as! UILabel
        placeholderLabel.isHidden = !self.text.isEmpty
    }
    
}

extension UIColor {
    
    /**
     
     rgb 값을 uicolor 으로 변경
     @param rgb 값 : UInt
     @returns uicolor : UIColor
     @exception <#throws#>
     */
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
}



extension UIView {

    //전체 화면 사이즈로 dash line 그림
    func addDashedLine(_ strokeColor: UIColor, _ lineWidth: CGFloat) {
        
        backgroundColor = .clear
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "DashedLine"
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [4, 4]
        
        let path = CGMutablePath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
        shapeLayer.path = path
        
        layer.addSublayer(shapeLayer)
    }
}

extension UITableView {
    /**
     
     테이블뷰에서 맨밑으로
     @param Animation Bool
     @returns <#retval#>
     @exception <#throws#>
     */
    func scrollToBottom(animated: Bool) {
        let y = contentSize.height - frame.size.height
        setContentOffset(CGPoint(x: 0, y: (y<0) ? 0 : y), animated: animated)
    }
    
    /**
     
     테이블뷰에서 맨위로
     @param Animation Bool
     @returns <#retval#>
     @exception <#throws#>
     */
    func scrollToTop(animated: Bool){
        let fristIndex = IndexPath(row: 0, section: 0)
        scrollToRow(at: fristIndex, at: .top, animated: animated)
    }
}

extension CALayer {
    
    /**
     Layer 에 Border 추가
     @param UIRectEdge, UIColor, CGFloat
     @returns <#retval#>
     @exception <#throws#>
     */
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: thickness, height: frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect.init(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            break
        default:
            borderWidth = thickness
            borderColor = color.cgColor
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
    var borderWidthIB: NSNumber {
        get {
            return NSNumber(value: Float(borderWidth))
        }
        set {
            borderWidth = CGFloat(newValue.floatValue)
        }
    }
    var borderColorIB: UIColor? {
        get {
            return borderColor != nil ? UIColor(cgColor: borderColor!) : nil
        }
        set {
            borderColor = newValue?.cgColor
        }
    }
    var cornerRadiusIB: NSNumber {
        get {
            return NSNumber(value: Float(cornerRadius))
        }
        set {
            cornerRadius = CGFloat(newValue.floatValue)
        }
    }
}


extension UIImageView {
    /**
    Http Image Download
     @param URL, UIViewContentModeloat
     @returns <#retval#>
     @exception <#throws#>
     */
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == JamTag.RES_SUCCES,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    Swift.debugPrint(error?.localizedDescription ?? "")
                    return
            }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}


extension UILabel {
    /**
    Html code 를 UILabel 로 처리
     @param String
     @returns <#retval#>
     @exception <#throws#>
     */
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(self.font!.pointSize)\">%@</span>" as NSString, htmlText) as String
        
        
        //process collection values
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        
        self.attributedText = attrStr
    }
}

extension String{
    
    /**
    String 에서 Html 코드 삭제
     @param String
     @returns String
     @exception <#throws#>
     */
    func removeHtmlFromString(inPutString: String) -> String{
        
        var returnString = inPutString.replacingOccurrences(of: "<br>", with: "\n")
        
        returnString = returnString.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        returnString = returnString.replacingOccurrences(of: "&nbsp;", with: " ")
        returnString = returnString.replacingOccurrences(of: "&lt;", with: "<")
        returnString = returnString.replacingOccurrences(of: "&gt;", with: ">")
        returnString = returnString.replacingOccurrences(of: "&amp;", with: "&")
        returnString = returnString.replacingOccurrences(of: "&quot;", with: "\"")
        return returnString
    }
    
    /**
    String 에서 Html 코드 변환
     @param String
     @returns String
     @exception <#throws#>
     */
    func changeHtmlFromString(inPutString: String) -> String{
        
        var returnString = inPutString.replacingOccurrences(of: "&nbsp;", with: " ")
        returnString = returnString.replacingOccurrences(of: "&lt;", with: "<")
        returnString = returnString.replacingOccurrences(of: "&gt;", with: ">")
        returnString = returnString.replacingOccurrences(of: "&amp;", with: "&")
        returnString = returnString.replacingOccurrences(of: "&quot;", with: "\"")
        return returnString
    }
    
    /**
    String 문자열 자르기
     @param 시작 끝 포인트
     @returns String
     @exception <#throws#>
     */
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }
        
        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }
        
        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        
        return self[startIndex ..< endIndex]
    }
    
    func substring(from: Int) -> String {
        return self.substring(from: from, to: nil)
    }
    
    func substring(to: Int) -> String {
        return self.substring(from: nil, to: to)
    }
    
    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }
        
        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }
        
        return self.substring(from: from, to: end)
    }
    
    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }
        
        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }
        
        return self.substring(from: start, to: to)
    }
    
    /**
     문자열 공백 제거 후 글자수 체크
     @param 뷰컨트롤 순서 변경
     @returns 글자여부 bool
     @exception <#throws#>
     */
    func boolStringLength() -> Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0 ? true : false
    }
}

extension UINavigationController {
    /**
    UINavigationController
     @param 뷰컨트롤 순서 변경
     @returns <#retval#>
     @exception <#throws#>
     */
    func replaceTopViewController(with viewController: UIViewController, animated: Bool) {
        var vcs = viewControllers
        vcs[vcs.count - 1] = viewController
        setViewControllers(vcs, animated: animated)
    }
}
