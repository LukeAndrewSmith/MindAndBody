//
//  MindBodyService.swift
//  MindAndBody
//
//  Created by Luke Smith on 16.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

private let itcAccountSecret = "a255263277c14664afb897c5de689810"

import Foundation

public enum Result<T> {
    case failure(SelfieServiceError)
    case success(T)
}

public typealias UploadReceiptCompletion = (_ result: Result<(sessionId: String, currentSubscription: PaidSubscription?)>) -> Void

public typealias SessionId = String

public enum SelfieServiceError: Error {
    case missingAccountSecret
    case invalidSession
    case noActiveSubscription
    case other(Error)
}

public class SelfieService {
    
    public static let shared = SelfieService()
//    let simulatedStartDate: Date
    
    private var sessions = [SessionId: Session]()
    
    init() {
//        let persistedDateKey = "RWSSimulatedStartDate"
//        if let persistedDate = UserDefaults.standard.object(forKey: persistedDateKey) as? Date {
//            simulatedStartDate = persistedDate
//        } else {
//            let date = Date().addingTimeInterval(-30) // 30 second difference to account for server/client drift.
//            UserDefaults.standard.set(date, forKey: "RWSSimulatedStartDate")
//
//            simulatedStartDate = date
//        }
    }
    
    /// Trade receipt for session id
    public func upload(receipt data: Data, completion: @escaping UploadReceiptCompletion) {
        let body = [
            "receipt-data": data.base64EncodedString(),
            "password": itcAccountSecret
        ]
        let bodyData = try! JSONSerialization.data(withJSONObject: body, options: [])
        
        let url = URL(string: "https://sandbox.itunes.apple.com/verifyReceipt")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) { (responseData, response, error) in
            if let error = error {
                completion(.failure(.other(error)))
            } else if let responseData = responseData {
                let json = try! JSONSerialization.jsonObject(with: responseData, options: []) as! Dictionary<String, Any>
                print(json)
                let session = Session(receiptData: data, parsedReceipt: json)
                self.sessions[session.id] = session
                let result = (sessionId: session.id, currentSubscription: session.currentSubscription)
                completion(.success(result))
            }
        }
        
        task.resume()
    }
 
    private func paidSubcriptions(since date: Date, for sessionId: SessionId) -> [PaidSubscription] {
        if let session = sessions[sessionId] {
            let subscriptions = session.paidSubscriptions.filter { $0.purchaseDate >= date }
            return subscriptions.sorted { $0.purchaseDate < $1.purchaseDate }
        } else {
            return []
        }
    }
}

