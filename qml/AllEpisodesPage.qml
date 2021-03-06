
/**
 *
 * gPodder QML UI Reference Implementation
 * Copyright (c) 2013, Thomas Perl <m@thp.io>
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
 * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
 * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
 * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
 * OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 * PERFORMANCE OF THIS SOFTWARE.
 *
 */

import QtQuick 2.0
import Sailfish.Silica 1.0

import 'common'
import 'common/util.js' as Util

Page {
    id: freshEpisodes

    onStatusChanged: pgst.handlePageStatusChange(status)

    Component.onCompleted: {
        episodesListModel.setQuery(episodesListModel.queries.Fresh);
        episodesListModel.reload();
    }

    BusyIndicator {
        visible: !episodesListModel.ready
        running: visible
        anchors.centerIn: parent
    }

    SilicaListView {
        id: freshEpisodesList
        anchors.fill: parent

        PullDownMenu {
            EpisodeListFilterItem { id: filterItem; model: episodesListModel }
        }

        VerticalScrollDecorator { flickable: freshEpisodesList }

        header: PageHeader {
            title: 'Episodes: ' + filterItem.currentFilter
        }

        model: GPodderEpisodeListModel { id: episodesListModel }

        section.property: 'section'
        section.delegate: SectionHeader {
            text: section
            horizontalAlignment: Text.AlignHCenter
        }

        delegate: EpisodeItem {}

        ViewPlaceholder {
            enabled: freshEpisodesList.count == 0 && episodesListModel.ready
            text: 'No episodes found'
        }
    }
}
