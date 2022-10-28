# Flutter-Wordle

A wordle game written with flutter

## How to play

Thanks to the feature of Flutter, the game is available on all platforms

### Play on Web

Visit [Wordle on my server](http://wordle.linloir.cn) to play the online version

### Play on Android

Download `.apk` file in the release page, install & enjoy.

### Deploy a web version

- clone this repository
- `flutter clean`
- `flutter pub get`
- `flutter build web --release --web-renderer html`

## What dictionary am I using

The hidden word is selected from one of the wordlists from [English wordlists for Chinese](https://github.com/mahavivo/english-wordlists)

The verification wordlist currently is an addup of all the wordlists available.

> Note that I'm changing the verification wordlist to [Letterpress wordlist](https://github.com/lorenbrichter/Words) lately.

## Screenshots


<p float="left">
<img src="https://pic.linloir.cn/images/2022/03/08/IMG_20220308_220301.jpg" width="200">
<img src="https://pic.linloir.cn/images/2022/03/08/IMG_20220308_220322.jpg" width="200">
<img src="https://pic.linloir.cn/images/2022/03/08/IMG_20220308_220237.jpg" width="200">
<img src="https://pic.linloir.cn/images/2022/03/08/IMG_20220308_220353.jpg" width="200">
</p>

## Support Me

This will be a longterm project and there will be awsome features coming up (include history page, online version, ranking, sharing, versus mode etc)

P.S. Several new Projects are currently occupying the develop time of this app, so further development might be delayed. One of them is a [component repository](https://github.com/Linloir/LUI-Flutter_Gui_Kit) I used for my own flutter apps and you might want to have a look~

you can support me by simply **starring** this project
