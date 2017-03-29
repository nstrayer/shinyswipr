## Note:

This particular repo is no longer maintained and has been merged into the larger R package for data-collection with shiny, [shinysense](https://github.com/nstrayer/shinysense). Nothing has changed other than the library called in the begining of your app.

---

# shinyswipr

A simple Shiny module for putting swipe based interfaces into shiny apps. Ever felt like Shiny wasn't "tinder-y" enough? Well here you go. 

---

### Installation 

This package is currently not on CRAN so the only way to install it is using github.

```r
devtools::install_github("nstrayer/shinyswipr")
```

---

### Usage

Two functions are exported by this package: `shinySwiprUI` and `shinySwipr`. These two must be used in conjunction with each other in both the `ui` and `server` of your shiny app respectively. 

`shinySwiprUI` allows you to pass any other UI elements to it, it will then wrap those UI elements in a card interface that can be swiped. 

A simple app that displays a card and prints to the R console your swipe result would go as follows. 

```r
library(shinyswipr)
ui <- fixedPage(
  shinySwiprUI( "my_swiper",
                h4("Swipe Me!"),
                hr(),
                p("This is some content that would warrent a good swipe")
  )
)

server <- function(input, output, session) {
  card_swipe <- callModule(shinySwipr, "my_swiper")

  observeEvent( card_swipe(),{
    print(card_swipe) #show last swipe result. 
  }) 
}
```
