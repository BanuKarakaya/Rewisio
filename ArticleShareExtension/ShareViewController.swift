//
//  ShareViewController.swift
//  ArticleShareExtension
//
//  Created by Banu Karakaya on 12.01.2026.
//

import UIKit
import Social
import UniformTypeIdentifiers

final class ShareViewController: SLComposeServiceViewController {
    
    override func viewDidLoad() {
            super.viewDidLoad()
            extractURL()
        }

        private func extractURL() {
            guard
                let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
                let providers = extensionItem.attachments
            else {
                closeExtension()
                return
            }

            for provider in providers {
                if provider.hasItemConformingToTypeIdentifier("public.url") {
                    provider.loadItem(forTypeIdentifier: "public.url", options: nil) { [weak self] item, error in
                        guard let self = self else { return }

                        if let url = item as? URL {
                            print("📎 Shared URL:", url.absoluteString)

                            let defaults = UserDefaults(suiteName: "group.com.banu.rewisio")
                            defaults?.set(url.absoluteString, forKey: "sharedURL")
                            defaults?.synchronize()
                        }
                        self.closeExtension()
                    }
                    return
                }
            }
        }

        private func closeExtension() {
            DispatchQueue.main.async {
                self.extensionContext?.completeRequest(returningItems: nil)
            }
        }
    
}
