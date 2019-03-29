# A podcasts library for Dart

[![Build Status](https://travis-ci.org/TheNightmanCodeth/dart_pod.svg?branch=master)](https://travis-ci.org/TheNightmanCodeth/dart_pod)
[![Coverage Status](https://coveralls.io/repos/github/TheNightmanCodeth/dart_pod/badge.svg)](https://coveralls.io/github/TheNightmanCodeth/dart_pod)
[![Pub](https://img.shields.io/pub/vpre/dart_pod.svg)](https://pub.dartlang.org/packages/dart_pod)

## Introduction
**dart_pod** makes it easy to get information for a podcast from its feed URL.
With just a *single* URL, **dart_pod** gives you access to:

* A list of episodes with details **and** stream urls
* Details about the show and its creators

all wrapped up in a drop-dead simple API for use in your Flutter or web projects.

## Example
See `example/example.dart`

```dart
import 'package:dart_pod/dart_pod.dart';

void main() async {
    var feed_url = "https://rss.art19.com/not-another-d-and-d-podcast"
    var naddpod = await Podcast.initFromURL(feed_url);

    List<Episode> episodes = naddpod.episodes;
    for (Episode e in episodes) {
        print("Episode: ${e.title} \n
               Description: ${e.description} \n
               Released: ${e.pubDate} \n
               Stream link: ${e.url} \n");
    }
}

```