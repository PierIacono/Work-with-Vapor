//
//  File.swift
//  
//
//  Created by Pierluigi Iacono on 01/04/22.
//

import Vapor
import Fluent
import Queues


struct WelcomeEmail: Codable {
  let to: String
  let name: String
}

struct RecipientWelcomeEmailJob: AsyncJob {
  typealias Payload = WelcomeEmail

  func dequeue(_ context: QueueContext, _ payload: WelcomeEmail) -> EventLoopFuture<Void> {
    print("Send welcome email to \(payload.to). Greet the user as \(payload.name).")
    return context.eventLoop.future()
  }

  func error(_ context: QueueContext, _ error: Error, _ payload: WelcomeEmail) -> EventLoopFuture<Void> {
    return context.eventLoop.future()
  }
}





/*
import SwiftUI

struct Provider: TimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {

        SimpleEntry(date: Date(), coin: Coin.previewData)

    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {

        let entry = SimpleEntry(date: Date(), coin: Coin.previewData)

        completion(entry)

    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        Task {

            let coin = try? await NetworkManager.getCoin(coinName: "bitcoin")

            let entry = (SimpleEntry(date: .now, coin: coin ?? Coin.previewData))

            let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 3600)))

            completion(timeline)

        }

    }

}

struct SimpleEntry: TimelineEntry {

    let date: Date

    let coin: Coin

}

struct MoonWidgetEntryView : View {

    var entry: Provider.Entry

    var body: some View {

        CoinDetailView(coin: entry.coin)

    }
}

@main

struct MoonWidget: Widget {

    let kind: String = "MoonWidget"

    var body: some WidgetConfiguration {

        StaticConfiguration(kind: kind, provider: Provider()) { entry in

            MoonWidgetEntryView(entry: entry)

        }

        .configurationDisplayName("Bitcoin Tracker")

        .description("Track the price of Bitcoin.")

        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])

    }
}

//
//struct MoonWidget_Previews: PreviewProvider {
//
//    static var previews: some View {
//
//        MoonWidgetEntryView(entry: SimpleEntry(date: Date(), coin: Coin.previewData))
//
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//
//        MoonWidgetEntryView(entry: SimpleEntry(date: Date(), coin: Coin.previewData))
//
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//
//        MoonWidgetEntryView(entry: SimpleEntry(date: Date(), coin: Coin.previewData))
//
//            .previewContext(WidgetPreviewContext(family: .systemLarge))
//
//    }
//
//}
*/
