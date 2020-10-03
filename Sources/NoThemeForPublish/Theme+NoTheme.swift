/**
*  NoThemeForPublish
*  Theme+NoTheme.swift
*  Copyright (c) 2020 Peter Cammeraat (https://l1ghthouse.net)
*  MIT license, see LICENSE file for details
*/

import Publish
import Plot

// MARK: - Theme
public extension Theme {
    static var notheme: Self {
        Theme(
            htmlFactory: NoThemeHTMLFactory(),
            resourcePaths: []
        )
    }
}

// MARK: - HTMLFactory
private struct NoThemeHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(
                .h1(.text(context.site.name)),
                .p(.text(context.site.description))
            )
        )
    }

    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                .h1(.text(section.title)),
                .itemList(for: section.items, on: context.site)
            )
        )
    }

    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .article(
                    .div(
                        .contentBody(item.body)
                    ),
                    .span("Tagged with: "),
                    .tagList(for: item, on: context.site)
                )
            )
        )
    }

    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .contentBody(page.body)
            )
        )
    }

    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .h1("Browse all tags"),
                .ul(
                    .forEach(page.tags.sorted()) { tag in
                        .li(
                            .a(
                                .href(context.site.path(for: tag)),
                                .text(tag.string)
                            )
                        )
                    }
                )
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .h1(
                    "Tagged with ",
                    .span(
                        .text(page.tag.string)
                    )
                ),
                .a(
                    .text("Browse all tags"),
                    .href(context.site.tagListPath)
                ),
                .itemList(
                    for: context.items(
                        taggedWith: page.tag,
                        sortedBy: \.date,
                        order: .descending
                    ),
                    on: context.site
                )
            )
        )
    }
}

// MARK: - Nodes
private extension Node where Context == HTML.BodyContext {
    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(.forEach(items) { item in
                        .li(.article(
                            .h1(.a(
                                .href(item.path),
                                .text(item.title)
                            )),
                            .tagList(for: item, on: site),
                            .p(.text(item.description))
                        ))
                    }
                )
    }

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.forEach(item.tags) { tag in
                    .li(.a(
                        .href(site.path(for: tag)),
                        .text(tag.string)
                    ))
                })
    }
}