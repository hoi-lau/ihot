import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    //     transparent
    // Transparent view
    self.isOpaque = false
    self.backgroundColor = .clear
    self.hasShadow = false
    // Add the blur layer
//     let blurView = NSVisualEffectView()
//     let view = contentViewController?.view.superview;
//     blurView.frame = CGRect(x: 0, y: 0, width: 2000, height: 2000)
//     view?.addSubview(blurView, positioned: NSWindow.OrderingMode.below, relativeTo: nil)
    //     end
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
