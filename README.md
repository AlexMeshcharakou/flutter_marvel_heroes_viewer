# Marvel heroes viewer

- Marvel heroes viewer is an application that introduces characters from marvel universe using marvel api.
- I used clean architecture to create the project.


<div id="built-with"></div>

## Built With

* [Flutter](https://flutter.dev/)
* [Dart](https://dart.dev/)
* [Marvel API](https://developer.marvel.com/docs)

<div id="screenshots"></div>

## Screenshots

<p align='center'>
    <img src="screenshots/Screenshot_1657137294.png" width="19%" title="Splash"/>
    <img src="screenshots/Screenshot_1657137310.png" width="19%" title="Characters"/>
    <img src="screenshots/Screenshot_1657137331.png" width="19%" title="Character Detail"/>
    <img src="screenshots/Screenshot_1657137342.png" width="19%" title="Character Detail Rus"/>
</p>

## Features of the app
 - infinite scrollable list with pagination fetched from the remote API
 - details page loaded by id from the remote API
 - state management tool - BLoC 
 - loading/error states
 - localization
 - clean architecture
 - local data base

## Packages used
 - dio
 - equatable
 - intl
 - flutter_bloc
 - get_it
 - hive
 - hive_flutter
 - json_annotation
 - retrofit
 - build_runner
 - flutter_launcher_icons
 - flutter_lints 
 - hive_generator
 - json_serializable
 - retrofit_generator
 - mocktail
 - bloc_test

## How to use

To clone and run this application, you'll need [Git](https://git-scm.com/downloads) and [Flutter](https://flutter.dev/docs/get-started/install) installed on your computer. From your command line:

```
# Clone this repository
$ git clone https://github.com/AlexMeshcharakou/flutter_marvel

# Go into the repository
$ cd flutter_marvel

# Install dependencies
$ flutter packages get

# Run the app
$ flutter run
```
