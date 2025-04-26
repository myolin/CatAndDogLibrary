import Foundation
import AVFoundation
import UIKit

@MainActor
class CatIdentifierViewModel: ObservableObject {
    @Published var isCameraPermission:Bool = false
    @Published var breedResult: String = "Unknown"
    @Published var confidence: String = "0"
    @Published var state: Bool = false
    
    let roboflowApiKey = "hhrTBxJ8VXQ3qGHewE4j"
    
    // URL endpoint for breed identifier
    let catPredictionEndpoint = "https://detect.roboflow.com/cat-breeds-2n7zk/2?api_key="
    
    // Analzye a photo and get result
    func analyze(uiImage: UIImage) async {
        let image = uiImage
        let imageData = image.jpegData(compressionQuality: 1)
        let fileContent = imageData?.base64EncodedString()
        let postData = fileContent!.data(using: .utf8)
        var request = URLRequest(url: URL(string: "\(catPredictionEndpoint)\(roboflowApiKey)")!, timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.state = false
        }
        
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let data = try JSONDecoder().decode(Predictions.self, from: data)
                let predictions = data.predictions
                if let prediction = predictions.first {
                    DispatchQueue.main.async {
                        self.breedResult = prediction.breed
                        self.confidence = String(round(prediction.confidence*100))
                    }
                }
            } catch {
                print("Failed to get predictions")
            }
        }.resume()
    }
    
    // Camera permission
    func getCameraPermission() async {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch(status) {
        case .authorized:
            isCameraPermission = true
        case .notDetermined:
            await AVCaptureDevice.requestAccess(for: .video)
            isCameraPermission = true
        case .denied:
            isCameraPermission = false
        case .restricted:
            isCameraPermission = false
            
        @unknown default:
            isCameraPermission = false
        }
    }
    
    
    
}
