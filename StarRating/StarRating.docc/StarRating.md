# ``StarRating``

A star rating UI component, similar to the one you can see on the the App Store, when rating an app or on IMDB, when you rate a movie.

## Usage

```swift
let starView = StarRating(frame: frame, totalStars: 5, selectedStars: 1)
starView.addTarget(self, action: #selector(starRatingValueChanged(_:)), for: .valueChanged)
view.addSubview(starView)
```

```swift
@objc func starRatingValueChanged(_ sender: StarRating) {
    print("Selected \(sender.selectedStars), out of \(sender.totalStars)")
}
```

## License

StarRating is released under the [MIT License](../../LICENSE).

## Author

⭐️ [Tarun Jain](https://www.linkedin.com/in/tarun885/) ⭐️
