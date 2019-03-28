//  show.dart
//
//  This file is a part of the dart_pod project.
//
//  dart_pod is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This porogram is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.
//
//  Created by Joe Diragi on 3/19/19.
//  Copyright © 2019 TheNightmanCodeth. All rights reserved.
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import 'episode.dart';

/// This class holds data about a podcast.
/// 
/// Don't use the constructor. Instead, use [newFromURL].
class Show {  
  XmlDocument doc;

  /// Creates a new [Show] from an RSS url.
  /// 
  /// Gathers information from the XML response and creates
  /// handy getters to make it simple to interact with.
  static Future<Show> newFromURL(String uri) async {
    if (uri == null) throw Exception("URL cannot be null");
    final rssResponse = await http.get(uri);
    try {
      var document = parse(rssResponse.body);
      var show = Show();
      show.doc = document;
      return show;
    } catch (e) {
      print("ERROR: Could not parse response body. Here's the deets: \n${e.message}");
    }
    return null;
  }

  /// The author of this podcast
  String get author {
    if (doc.findAllElements("author").length < 1)
      return doc.findAllElements("author").first.text;
    else return doc.findAllElements("itunes:author").first.text;
  }

  /// The copyright for this show
  String get copyright {
    return doc.findAllElements("copyright").first.text;
  }

  /// This shows description
  String get description {
    return doc.findAllElements("description").first.text;
  }

  /// Returns a list of [Episode]s.
  /// 
  /// The episodes are stored as a list of items in the document.
  /// The relevant information is extracted and stored inside of
  /// a new [Episode]
  List<Episode> get episodes {
    var eps = List<Episode>();
    for (XmlElement e in doc.findAllElements("item")) {
      eps.add(Episode(
        e.findElements("title").first.text,
        e.findElements("description").first.text,
        e.findElements("pubDate").first.text,
        e.findElements("enclosure").first.getAttribute("url")
      ));
    }
    return eps;
  }

  /// The shows homepage url
  String get homepage {
    return doc.findAllElements("link").first.text;
  }

  /// The url to the shows logo/album art image
  String get logoUrl {
    return doc.findAllElements("image").first.findElements("url").first.text;
  }

  /// The title of the show
  String get title {
    return doc.findAllElements("title").first.text;
  }
}