import UIKit

@IBDesignable
class ViewCheckRound: UIView {
    
    
    @IBInspectable var color: UIColor = #colorLiteral(red: 0.337254902, green: 0.7529411765, blue: 0.9921568627, alpha: 1)
    @IBInspectable var isActive: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var recognizerAdded = false
    
    
    private var radiusBig: CGFloat {
        let smallSide = min(bounds.height, bounds.width)
        return smallSide / 2
    }
    
    private var  radiusSmall: CGFloat {
        return radiusBig - circleLineWidth * 2
    }
    
    private var circleLineWidth: CGFloat = 2
    
    
    override func draw(_ rect: CGRect) {
        
        drawEmptyCircle()
        if isActive {
            drawFilledCircle()
        }
        if !recognizerAdded {
            addRecognizer()
        }
    }
    
    
    private func drawEmptyCircle() {
        
        let circleRect = CGRect(x: bounds.width / 2 - radiusBig + circleLineWidth / 2,
                                y: bounds.height / 2 - radiusBig + circleLineWidth / 2,
                                width: radiusBig * 2 - circleLineWidth,
                                height: radiusBig * 2 - circleLineWidth)
        let circle = UIBezierPath(ovalIn: circleRect)
        circle.lineWidth = circleLineWidth
        color.setStroke()
        circle.stroke()
    }
    
    private func drawFilledCircle() {
        
        let circleRect = CGRect(x: bounds.width / 2 - radiusSmall,
                                y: bounds.height / 2 - radiusSmall,
                                width: radiusSmall * 2,
                                height: radiusSmall * 2)
        let circle = UIBezierPath(ovalIn: circleRect)
        color.setFill()
        circle.fill()
    }
    
    private func addRecognizer() {
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(turnOnOff))
        addGestureRecognizer(recognizer)
        recognizerAdded = true
    }
    
    @objc private func turnOnOff() {
        isActive = !isActive
    }
    
    
}
