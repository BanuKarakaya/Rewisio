//
//  ShareViewController.swift
//  ArticleShareExtension
//
//  Created by Banu Karakaya on 12.01.2026.
//

import UIKit
import Social
import UniformTypeIdentifiers
import SharedCore
import LinkPresentation

final class ShareViewController: SLComposeServiceViewController {
    
    let sharedDate = Date()
    
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
                            
                            let context = CoreDataStack.shared.context
                            
                            let article = ArticlesDemoEntity(context: context)
                            
                            fetchTitle(from: url) { title in
                                print("Makale başlığı:", title ?? "bulunamadı")
                                article.articleName = title
                            }
                            
                            article.articleUrl = url.absoluteString
                            article.articleDate = sharedDate
                            
                            do {
                                try context.save()
                                print("Article saved successfully!")
                            } catch {
                                print("Failed to save Article: \(error.localizedDescription)")
                            }
                        }
                        self.closeExtension()
                    }
                    return
                }
            }
        }
    
    func fetchTitle(from url: URL, completion: @escaping (String?) -> Void) {
        let provider = LPMetadataProvider()
        
        provider.startFetchingMetadata(for: url) { metadata, error in
            if let title = metadata?.title {
                completion(title)
            } else {
                completion(nil)
            }
        }
    }
    
    private func closeExtension() {
        DispatchQueue.main.async {
            self.extensionContext?.completeRequest(returningItems: nil)
        }
    }
    
}
