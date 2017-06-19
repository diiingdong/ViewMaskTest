
import UIKit

class ViewController: UIViewController
{
    // MARK: - IBOutlets
    @IBOutlet weak var ccontainerView: UIView!
    @IBOutlet weak var girlImageView: UIImageView!
    
    // MARK: - Computed Varibles
    var imageCenter: CGPoint!
    {
        return CGPoint(x: girlImageView.center.x - girlImageView.frame.origin.x, y: girlImageView.center.y - girlImageView.frame.origin.y)
    }
    
    var imageFrame: CGRect
    {
        return CGRect(x: 0, y: 0, width: girlImageView.frame.size.width, height: girlImageView.frame.size.height)
    }
    
    var rectanglePath: UIBezierPath!
    {
        return UIBezierPath(roundedRect: CGRect(x: imageCenter.x, y: imageCenter.y, width: 100, height: 100).offsetBy(dx: -50, dy: -80), cornerRadius: 10)
    }
    
    var circlePath: UIBezierPath!
    {
        return UIBezierPath(ovalIn: CGRect(x: imageCenter.x, y: imageCenter.y, width: 100, height: 100).offsetBy(dx: -50, dy: -20))
    }
    
    // MARK: - Constant
    let mask = CAShapeLayer()
    
    // MARK: - IBActions
    @IBAction func applyRectangleMask(_ sender: UIButton)
    {
        mask.path = rectanglePath.cgPath
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func applyCircleleMask(_ sender: UIButton)
    {
        mask.path = circlePath.cgPath
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func applyRectangleReversedMask(_ sender: UIButton)
    {
        let reversedRectangle = CGMutablePath()
        
        CGPathAddPath(reversedRectangle, nil, rectanglePath.cgPath)
        CGPathAddRect(reversedRectangle, nil, imageFrame)
        
        mask.path = reversedRectangle
        mask.fillRule = kCAFillRuleEvenOdd
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func applyCircleReversedMask(_ sender: UIButton)
    {
        let reversedCircle = CGMutablePath()
        
        CGPathAddPath(reversedCircle, nil, circlePath.cgPath)
        CGPathAddRect(reversedCircle, nil, imageFrame)
        
        mask.path = reversedCircle
        mask.fillRule = kCAFillRuleEvenOdd
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func applyUnionMask(_ sender: UIButton)
    {
        let unionPath = CGMutablePath()
        CGPathAddPath(unionPath, nil, circlePath.cgPath)
        CGPathAddPath(unionPath, nil, rectanglePath.cgPath)
        
        mask.path = unionPath
        mask.fillRule = kCAFillRuleNonZero
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func applySubtractionMask(_ sender: UIButton)
    {
        print("subtraction mask to be implemented")
    }
    
    @IBAction func applyIntersectionMask(_ sender: UIButton)
    {
        print("intersection mask to be implemented")
    }
    
    @IBAction func applyXORMask(_ sender: UIButton)
    {
        let xorPath = CGMutablePath()
        CGPathAddPath(xorPath, nil, circlePath.cgPath)
        CGPathAddPath(xorPath, nil, rectanglePath.cgPath)
        
        mask.path = xorPath
        mask.fillRule = kCAFillRuleEvenOdd
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func removeMask(_ sender: UIButton)
    {
        girlImageView.layer.mask = nil
    }
    
    // MARK: - UIViewController Override Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation)
    {
        girlImageView.layer.mask = nil
    }
}

