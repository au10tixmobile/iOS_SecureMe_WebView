//
//  ViewController.swift
//  SecureMe
//
//  Created by Elkana Orbach on 03/01/2021.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    // MARK: - Properties
    weak var webView: WKWebView!
    private var secureMeFinishedMessage: String { "webview" }

    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var textField: UITextField!

    // MARK: - Actions
    @IBAction func startButtonClicked(_ sender: UIButton) {
        if let text = textField.text, let url = URL(string: text) {
            load(url: url)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter correct URL", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    // MARK: - Methods
	override func viewDidLoad() {
		super.viewDidLoad()
        textField.text = ""
        createWebView()
	}
    
    func openExternalLink(url: URL) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.textField.text = url.absoluteString
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
                guard let self = self else { return }
                self.load(url: url)
            }
        }
    }
}

// MARK: - Private API
private extension ViewController {
    
    func createWebView() {
        let configs = WKWebViewConfiguration()
        
        // MARK: - Allows to play video. Essential setting.
        configs.allowsInlineMediaPlayback = true
        configs.userContentController.add(self, name: secureMeFinishedMessage)
        
        // MARK: - Script forces a camera popup to show at the flow start.
        let userScript = WKUserScript(source: "navigator.mediaDevices.getUserMedia({ video: true })", injectionTime: .atDocumentStart, forMainFrameOnly: true)
        configs.userContentController.addUserScript(userScript)
        
        let webView = WKWebView(frame: view.bounds, configuration: configs)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - Implement this delegate to handle a Media Capture Permission request
        webView.uiDelegate = self
        
        containerView.addSubview(webView)
        [
            webView.topAnchor.constraint(equalTo: containerView.topAnchor),
            webView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ].forEach { $0.isActive = true }
        self.webView = webView
    }
    
    func load(url: URL) {
        textField.resignFirstResponder()
        startView.isHidden = true
        webView.load(URLRequest(url: url))
    }
}

// MARK: - WKNavigationDelegate
extension ViewController: WKNavigationDelegate {
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
}

// MARK: - WKScriptMessageHandler
extension ViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == self.secureMeFinishedMessage {
            //handle the finish event
            let payload = JSEventObj(body: message.body)
            switch payload?.event {
            case .success, .error:
                let alert = UIAlertController(title: payload?.event == .success ? "Success" : "Error", message: payload?.payload?.value, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Restart", style: .default) { [weak self] _ in
                    self?.webView.evaluateJavaScript("document.body.remove()")
                    self?.webView.load(URLRequest(url: URL(string: "about:blank")!))
                    self?.textField.text = nil
                    self?.startView.isHidden = false
                })
                present(alert, animated: true)
            default: break
            }
        }
    }
}

extension ViewController: WKUIDelegate {
    
    // Prevents showing a camera permission
    
    // Implement this delegate for iOS version started from iOS 15.
    @available(iOS 15.0, *)
    func webView(_ webView: WKWebView, requestMediaCapturePermissionFor origin: WKSecurityOrigin, initiatedByFrame frame: WKFrameInfo, type: WKMediaCaptureType, decisionHandler: @escaping (WKPermissionDecision) -> Void) {
        
        decisionHandler(.grant)
    }
}
