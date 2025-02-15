//
//  ContactManager.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/25.
//

import Contacts
import UIKit

class ContactManager {
    
    static func checkContactsPermission(completion: @escaping (Bool) -> Void) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined:
            CNContactStore().requestAccess(for: .contacts) { granted, error in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .denied, .restricted:
            completion(false)
        case .limited:
            completion(false)
        @unknown default:
            completion(false)
        }
    }
    
    static func fetchContacts(completion: @escaping ([CNContact]?, Error?) -> Void) {
        checkContactsPermission { granted in
            guard granted else {
                showPermissionDeniedAlert {
                    let error = NSError(domain: "ContactsPermission", code: -1, userInfo: [NSLocalizedDescriptionKey: "Contacts permission denied"])
                    completion(nil, error)
                }
                return
            }
            
            let store = CNContactStore()
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
            let request = CNContactFetchRequest(keysToFetch: keys)
            
            var contacts = [CNContact]()
            DispatchQueue.main.async {
                do {
                    try store.enumerateContacts(with: request) { contact, stop in
                        contacts.append(contact)
                    }
                    
                    if contacts.isEmpty {
                        showPermissionDeniedAlert {
                            let error = NSError(domain: "ContactsPermission", code: -1, userInfo: [NSLocalizedDescriptionKey: "Contacts permission denied"])
                            completion(nil, error)
                        }
                    }else {
                        completion(contacts, nil)
                    }
                    
                } catch {
                    completion(nil, error)
                }
            }
        }
    }
    
    private static func showPermissionDeniedAlert(completion: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: "Permission Denied",
            message: "Please enable contacts access in Settings.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            completion?()
        }))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            completion?()
        }))
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
    
}

