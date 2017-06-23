
import UIKit

class ViewController: UIViewController
{
    // MARK: - IBOutlets
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
    var subLayers = [CAShapeLayer]()
    
    var originalGirlImage: UIImage!
    
    // MARK: - IBActions
    @IBAction func applyRectangleMask(_ sender: UIButton)
    {
        resetGirlImageView()
        
        mask.path = rectanglePath.cgPath
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func applyCircleleMask(_ sender: UIButton)
    {
        resetGirlImageView()
        
        mask.path = circlePath.cgPath
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func applyRectangleReversedMask(_ sender: UIButton)
    {
        resetGirlImageView()
        
        let reversedRectangle = CGMutablePath()
        
        reversedRectangle.addRect(imageFrame)
        reversedRectangle.addPath(rectanglePath.cgPath)
        
        mask.path = reversedRectangle
        mask.fillRule = kCAFillRuleEvenOdd
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func applyCircleReversedMask(_ sender: UIButton)
    {
        resetGirlImageView()
        
        let reversedCircle = CGMutablePath()
        
        reversedCircle.addRect(imageFrame)
        reversedCircle.addPath(circlePath.cgPath)
        
        mask.path = reversedCircle
        mask.fillRule = kCAFillRuleEvenOdd
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func applyUnionMask(_ sender: UIButton)
    {
        resetGirlImageView()
        
        let unionPath = CGMutablePath()
        
        unionPath.addPath(circlePath.cgPath)
        unionPath.addPath(rectanglePath.cgPath)
        
        mask.path = unionPath
        mask.fillRule = kCAFillRuleNonZero
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func applySubtractionMask(_ sender: UIButton)
    {
        resetGirlImageView()
        
        let subRectPath = CGMutablePath()
        subRectPath.addRect(imageFrame)
        subRectPath.addPath(rectanglePath.cgPath)
        
        let subLayer1 = CAShapeLayer()
        subLayer1.path = subRectPath
        subLayer1.fillRule = kCAFillRuleEvenOdd
        subLayer1.backgroundColor = UIColor.black.cgColor
        subLayer1.opacity = 1.0
        subLayers.append(subLayer1)
        girlImageView.layer.addSublayer(subLayer1)
        
//        let subCirclePath = CGMutablePath()
//        subCirclePath.addRect(imageFrame)
//        subCirclePath.addPath(circlePath.cgPath)
        
        let subLayer2 = CAShapeLayer()
        subLayer2.path = circlePath.cgPath
        subLayer2.fillRule = kCAFillRuleEvenOdd
        subLayer2.backgroundColor = UIColor.black.cgColor
        subLayer2.opacity = 1.0
        subLayers.append(subLayer2)
        girlImageView.layer.addSublayer(subLayer2)
        
//        // method 1, using mask
//        let image = UIImage(view: girlImageView)
//        let maskingColor: [CGFloat] = [0.0]
//        let newImage = image.cgImage!.copy(maskingColorComponents: maskingColor)
//
//        resetGirlImageView()
//
//        girlImageView.image = UIImage(cgImage: newImage!)
        
        // methos 2, using pixel manipulation
        let image = UIImage(view: girlImageView)
        let newImage = processPixels(in: image)
        
        resetGirlImageView()
        
        girlImageView.image = newImage
    }
    
    @IBAction func applyIntersectionMask(_ sender: UIButton)
    {
        resetGirlImageView()
        
        let subRectPath = CGMutablePath()
        subRectPath.addRect(imageFrame)
        subRectPath.addPath(rectanglePath.cgPath)
        
        let subLayer1 = CAShapeLayer()
        subLayer1.path = subRectPath
        subLayer1.fillRule = kCAFillRuleEvenOdd
        subLayer1.backgroundColor = UIColor.black.cgColor
        subLayer1.opacity = 1.0
        subLayers.append(subLayer1)
        girlImageView.layer.addSublayer(subLayer1)
        
        let subCirclePath = CGMutablePath()
        subCirclePath.addRect(imageFrame)
        subCirclePath.addPath(circlePath.cgPath)
        
        let subLayer2 = CAShapeLayer()
        subLayer2.path = subCirclePath
        subLayer2.fillRule = kCAFillRuleEvenOdd
        subLayer2.backgroundColor = UIColor.black.cgColor
        subLayer2.opacity = 1.0
        subLayers.append(subLayer2)
        girlImageView.layer.addSublayer(subLayer2)
        
//        // method 1, using mask
//        let image = UIImage(view: girlImageView)
//        let maskingColor: [CGFloat] = [0.0]
//        let newImage = image.cgImage!.copy(maskingColorComponents: maskingColor)
//
//        resetGirlImageView()
//
//        girlImageView.image = UIImage(cgImage: newImage!)
        
        // methos 2, using pixel manipulation
        let image = UIImage(view: girlImageView)
        let newImage = processPixels(in: image)
        
        resetGirlImageView()
        
        girlImageView.image = newImage
    }
    
    @IBAction func applyXORMask(_ sender: UIButton)
    {
        resetGirlImageView()
        
        let xorPath = CGMutablePath()
        xorPath.addPath(circlePath.cgPath)
        xorPath.addPath(rectanglePath.cgPath)
        
        mask.path = xorPath
        mask.fillRule = kCAFillRuleEvenOdd
        
        girlImageView.layer.mask = mask
    }
    
    @IBAction func removeMask(_ sender: UIButton)
    {
        resetGirlImageView()
        
        girlImageView.layer.mask = nil
    }
    
    // MARK: - UIViewController Override Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        originalGirlImage = girlImageView.image!
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation)
    {
        girlImageView.layer.mask = nil
    }
    
    func resetGirlImageView()
    {
        subLayers.forEach { $0.removeFromSuperlayer() }
        subLayers = [CAShapeLayer]()
        
        girlImageView.layer.mask = nil
        
        girlImageView.image = originalGirlImage
    }
    
    // function from https://stackoverflow.com/a/31661519
    func processPixels(in image: UIImage) -> UIImage?
    {
        guard let inputCGImage = image.cgImage else { return nil }
        
        let colorSpace       = CGColorSpaceCreateDeviceRGB()
        let width            = inputCGImage.width
        let height           = inputCGImage.height
        let bytesPerPixel    = 4
        let bitsPerComponent = 8
        let bytesPerRow      = bytesPerPixel * width
        let bitmapInfo       = RGBA32.bitmapInfo
        
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
        else { return nil }
        
        context.draw(inputCGImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        guard let buffer = context.data else { return nil }
        
        let pixelBuffer = buffer.bindMemory(to: RGBA32.self, capacity: width * height)
        
        for row in 0 ..< Int(height)
        {
            for column in 0 ..< Int(width)
            {
                let offset = row * width + column
                
                if pixelBuffer[offset] == .black { pixelBuffer[offset] = .clear }
            }
        }
        
        let outputCGImage = context.makeImage()!
        let outputImage = UIImage(cgImage: outputCGImage, scale: image.scale, orientation: image.imageOrientation)
        
        return outputImage
    }
    
    // struct from https://stackoverflow.com/a/31661519
    struct RGBA32: Equatable
    {
        private var color: UInt32
        
        var redComponent: UInt8 { return UInt8((color >> 24) & 255) }
        var greenComponent: UInt8 { return UInt8((color >> 16) & 255) }
        var blueComponent: UInt8 { return UInt8((color >> 8) & 255) }
        var alphaComponent: UInt8 { return UInt8((color >> 0) & 255) }
        
        init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8)
        {
            color = (UInt32(red) << 24) | (UInt32(green) << 16) | (UInt32(blue) << 8) | (UInt32(alpha) << 0)
        }
        
        static let red     = RGBA32(red: 255, green: 0,   blue: 0,   alpha: 255)
        static let green   = RGBA32(red: 0,   green: 255, blue: 0,   alpha: 255)
        static let blue    = RGBA32(red: 0,   green: 0,   blue: 255, alpha: 255)
        static let white   = RGBA32(red: 255, green: 255, blue: 255, alpha: 255)
        static let black   = RGBA32(red: 0,   green: 0,   blue: 0,   alpha: 255)
        static let magenta = RGBA32(red: 255, green: 0,   blue: 255, alpha: 255)
        static let yellow  = RGBA32(red: 255, green: 255, blue: 0,   alpha: 255)
        static let cyan    = RGBA32(red: 0,   green: 255, blue: 255, alpha: 255)
        static let clear   = RGBA32(red: 0,   green: 0,   blue: 0,   alpha: 0)
        
        static let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
        
        static func ==(lhs: RGBA32, rhs: RGBA32) -> Bool { return lhs.color == rhs.color }
    }
}

