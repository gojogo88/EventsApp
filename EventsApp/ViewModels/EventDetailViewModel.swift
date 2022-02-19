//
//  EventDetailViewModel.swift
//  EventsApp
//
//  Created by Jonathan Go on 18.02.22.
//

import UIKit
import CoreData

final class EventDetailViewModel {
    
    private let eventId: NSManagedObjectID
    private let eventService: EventServicing
    private var event: Event?
    private let date = Date()
    var onUpdate = {}
    weak var coordinator: EventDetailCoordinator?
    
    var image: UIImage? {
        guard let imageData = event?.image else { return nil }
        return UIImage(data: imageData)
    }
    
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let eventDate = event?.date,
                let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",")
        else {
            return nil
        }
        return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .detail)
    }
    
    init(eventId: NSManagedObjectID, eventService: EventServicing = EventService()) {
        self.eventId = eventId
        self.eventService = eventService
    }
    
    func viewDidLoad() {
        reload()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func reload() {
        event = eventService.getEvent(eventId)
        onUpdate()
    }
    
    @objc func tappedEditButton() {
        guard let event = event else { return }
        coordinator?.onEditEvent(event)
    }
}
