//
//  WebViewViewController.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 21.12.25.
//

import UIKit
import WebKit

final class WebViewViewController: UIViewController, WebViewViewControllerProtocol {
    // MARK: - IB Outlets
    @IBOutlet var webView: WKWebView!
    @IBOutlet var progressView: UIProgressView!
    
    // MARK: - Public Properties
    var presenter: WebViewPresenterProtocol?
    weak var delegate: WebViewViewControllerDelegate?
    
    // MARK: - Private Properties
    private var estimatedProgressObservation: NSKeyValueObservation?
    
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.accessibilityIdentifier = "authWebView"
        webView.navigationDelegate = self
        
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        estimatedProgressObservation = webView.observe(
            \.estimatedProgress,
             options: [],
             changeHandler: { [weak self] _, _ in
                 guard let self = self else { return }
                 presenter?.didUpdateProgressValue(webView.estimatedProgress)
             })
        presenter?.didUpdateProgressValue(webView.estimatedProgress)
    }
    
    // MARK: - Public Methods
    func load(request: URLRequest) {
        webView.load(request)
    }
    
    // MARK: - Private Methods
    func setProgressValue(_ newValue: Float) {
        progressView.progress = newValue
    }
    
    func setProgressHidden(_ isHidden: Bool) {
        progressView.isHidden = isHidden
    }
}

extension WebViewViewController: WKNavigationDelegate {
    // MARK: - Public Methods
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        if let code = code(from: navigationAction) {
            delegate?.webViewViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    // MARK: - Private Methods
    private func code(from navigationAction: WKNavigationAction) -> String? {
        if let url = navigationAction.request.url {
            return presenter?.code(from: url)
        }
        return nil
    }
}
