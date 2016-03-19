
import UIKit

class ViewController: UIViewController
{
    // MARK: - IBOutlets
    @IBOutlet weak var ccontainerView: UIView!
    @IBOutlet weak var girlImageView: UIImageView!
    
    // MARK: - Computed Varibles
    var imageCenter: CGPoint!
    {
        return CGPointMake(girlImageView.center.x - girlImageView.frame.origin.x, girlImageView.center.y - girlImageView.frame.origin.y)
    }
    
    var imageFrame: CGRect
    {
        return CGRectMake(0, 0, girlImageView.frame.size.width, girlImageView.frame.size.height)
    }
    
    var rectanglePath: UIBezierPath!
    {
        return UIBezierPath(roundedRect: CGRectOffset(CGRectMake(imageCenter.x, imageCenter.y, 100, 100), -50, -80), cornerRadius: 10)
    }
    
    var circlePath: UIBezierPath!
    {
        return UIBezierPath(ovalInRect: CGRectOffset(CGRectMake(imageCenter.x, imageCenter.y, 100, 100), -50, -20))
    }
    
    // MARK: - Constant
    let mask = CAShapeLayer()
    
    // MARK: - IBActions
    @IBAction func applyRectangleMask(sender: UIButton)
    {
        mask.path = rectanglePath.CGPath
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func applyCircleleMask(sender: UIButton)
    {
        mask.path = circlePath.CGPath
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func applyRectangleReversedMask(sender: UIButton)
    {
        let reversedRectangle = CGPathCreateMutable()
        
        CGPathAddPath(reversedRectangle, nil, rectanglePath.CGPath)
        CGPathAddRect(reversedRectangle, nil, imageFrame)
        
        mask.path = reversedRectangle
        mask.fillRule = kCAFillRuleEvenOdd
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func applyCircleReversedMask(sender: UIButton)
    {
        let reversedCircle = CGPathCreateMutable()
        
        CGPathAddPath(reversedCircle, nil, circlePath.CGPath)
        CGPathAddRect(reversedCircle, nil, imageFrame)
        
        mask.path = reversedCircle
        mask.fillRule = kCAFillRuleEvenOdd
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func applyUnionMask(sender: UIButton)
    {
        let unionPath = CGPathCreateMutable()
        CGPathAddPath(unionPath, nil, circlePath.CGPath)
        CGPathAddPath(unionPath, nil, rectanglePath.CGPath)
        
        mask.path = unionPath
        mask.fillRule = kCAFillRuleNonZero
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func applySubstractionMask(sender: UIButton)
    {
        print("substraction mask to be implemented")
    }
    
    @IBAction func applyIntersectionMask(sender: UIButton)
    {
        print("intersection mask to be implemented")
    }
    
    @IBAction func applyXORMask(sender: UIButton)
    {
        let xorPath = CGPathCreateMutable()
        CGPathAddPath(xorPath, nil, circlePath.CGPath)
        CGPathAddPath(xorPath, nil, rectanglePath.CGPath)
        
        mask.path = xorPath
        mask.fillRule = kCAFillRuleEvenOdd
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func removeMask(sender: UIButton)
    {
        girlImageView.layer.mask = nil
    }
    
    // MARK: - UIViewController Override Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation)
    {
        girlImageView.layer.mask = nil
    }
}

