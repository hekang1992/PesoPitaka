//
//  CameraPhotoManager.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/24.
//

import UIKit
import Photos

class CameraPhotoManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let shared = CameraPhotoManager()
    private var completion: ((UIImage?) -> Void)?
    
    func showImagePicker(in viewController: UIViewController, sourceType: UIImagePickerController.SourceType, type: String? = "10",completion: @escaping (UIImage?) -> Void) {
        self.completion = completion
        
        if sourceType == .camera {
            checkCameraPermission { [weak self] granted in
                DispatchQueue.main.async {
                    if granted {
                        self?.openImagePicker(in: viewController, sourceType: sourceType, type: type)
                    } else {
                        self?.showPermissionAlert(in: viewController, for: .camera)
                    }
                }
            }
        } else if sourceType == .photoLibrary {
            checkPhotoLibraryPermission { [weak self] granted in
                DispatchQueue.main.async {
                    if granted {
                        self?.openImagePicker(in: viewController, sourceType: sourceType, type: type)
                    } else {
                        self?.showPermissionAlert(in: viewController, for: .photoLibrary)
                    }
                }
            }
        }
    }
    
    private func openImagePicker(in viewController: UIViewController, sourceType: UIImagePickerController.SourceType, type: String? = "10") {
        DispatchQueue.main.async {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = sourceType
            if sourceType == .camera {
                if type == "11" {
                    imagePicker.cameraDevice = .rear
                }else {
                    imagePicker.cameraDevice = .front
                }
            }
            imagePicker.delegate = self
            viewController.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func checkCameraPermission(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                completion(granted)
            }
        default:
            completion(false)
        }
    }
    
    private func checkPhotoLibraryPermission(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                completion(status == .authorized)
            }
        default:
            completion(false)
        }
    }
    
    private func showPermissionAlert(in viewController: UIViewController, for sourceType: UIImagePickerController.SourceType) {
        let alert = UIAlertController(
            title: "Permission Denied",
            message: sourceType == .camera ? "Please enable camera access in Settings." : "Please enable photo library access in Settings.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Set Up", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            completion?(image)
        } else {
            completion?(nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        completion?(nil)
        picker.dismiss(animated: true, completion: nil)
    }
}
