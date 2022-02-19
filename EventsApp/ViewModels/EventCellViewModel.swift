//
//  EventCellViewModel.swift
//  EventsApp
//
//  Created by Jonathan Go on 17.02.22.
//

import UIKit
import CoreData

struct EventCellViewModel {
    
    let date = Date()
    static let imageCache = NSCache<NSString, UIImage>()
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    private let event: Event
    var onSelect: (NSManagedObjectID) -> Void = { _ in }
    
    var cacheKey: String {
        event.objectID.description
    }
    
    var timeRemainingStrings: [String] {
        guard let eventDete = event.date else { return [] }
        // 1 year, 1 month, 2 weeks, 1 day
        return date.timeRemaining(until: eventDete)?.components(separatedBy: ",") ?? []
    }
    
    var dateText: String? {
        guard let eventDate = event.date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: eventDate)
    }
    
    var eventName: String? {
        event.name
    }
    
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let eventDate = event.date,
                let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",")
        else {
            return nil
        }
        return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .cell)
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        // check image cache for the value of the cache key and complete with this image value
        // else load new image
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        } else {
            imageQueue.async {
                guard let imageData = self.event.image, let image = UIImage(data: imageData)
                else {
                    completion(nil)
                    return
                }
                Self.imageCache.setObject(image, forKey: self.cacheKey as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    func didSelect() {
        onSelect(event.objectID)
    }
    
    init(_ event: Event) {
        self.event = event
    }
}
