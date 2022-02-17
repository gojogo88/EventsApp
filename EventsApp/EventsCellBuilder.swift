//
//  EventsCellBuilder.swift
//  EventsApp
//
//  Created by Jonathan Go on 17.02.22.
//

import UIKit

struct EventsCellBuilder {
    func makeTitleSubtitleCellViewModel(
        _ type: TitleSubtitleCellViewModel.CellType,
        onCellUpdate: (() -> Void)? = nil
    ) -> TitleSubtitleCellViewModel {
        switch type {
        case .text:
            return TitleSubtitleCellViewModel(
                title: "Name",
                subtitle: "",
                placeHolder: "Add a name",
                type: .text,
                onCellUpdate: onCellUpdate
            )
        case .date:
            return TitleSubtitleCellViewModel(
                title: "Date",
                subtitle: "",
                placeHolder: "Select a date",
                type: .date,
                onCellUpdate: onCellUpdate
            )
        case .image:
            return TitleSubtitleCellViewModel(
                title: "Background",
                subtitle: "",
                placeHolder: "",
                type: .image,
                onCellUpdate: onCellUpdate
            )
        }
    }
}
