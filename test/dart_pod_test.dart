//  dart_pod_test.dart
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
import 'package:dart_pod/dart_pod.dart';
import 'package:test/test.dart';

void main() async {
  final url = "https://rss.art19.com/not-another-d-and-d-podcast";
  final show = await Show.newFromURL(url);
  test('Show is created using initFromURL', () { 
    expect(show, isNotNull);
  });
  test('Show has episodes', () {
    expect (show.episodes, isNotEmpty);
    expect (show.episodes.length, greaterThanOrEqualTo(5));
  });
  test('All shows have a stream link', () {
    for (Episode e in show.episodes) {
      expect(e.url, isNotNull);
      expect(e.url, contains("http"));
      expect(e.url, contains(".mp3"));
    }
  });
}