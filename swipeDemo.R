#App is a simple card with some content and a little output below that represents the last swipes result.
library(shiny)

shinySwiprUI <- function(id, ...) {
  ns <- NS(id)

  #check if the user passed anything else for the card.
  if (length(list(...)) == 0) stop("You need to pass something to the card.")
  
  tagList(
    singleton(
      tags$head( #load our javascript files for this. Should probably browserify them into one.
        tags$script(src = "touchSwipe.js"),
        tags$script(src = "shinySwiper.js"),
        tags$link(rel = "stylesheet", type = "text/css", href = "swiprStyle.css")
      )
    ),
    div(id = id, class = "swiperCard", ...) 
  ) #end tag list. 
  
}

shinySwipr <- function(input, output, session) {
  
  #the id of our particular card. We send this to javascript. 
  card_id <- gsub("-", "", session$ns(""))
  
  #Send over a message to the javascript to initialize the card.
  observe({ session$sendCustomMessage(type = "initializeCard", message = card_id) })
  
  observeEvent(input$cardSwiped, {
    print(input$cardSwiped);
  })
  
  # The user's data, parsed into a data frame
  result <- reactive({
    input$cardSwiped
  })
  
  return(result)
}


ui <- fixedPage(
  shinySwiprUI( "swiper1",
    h1("Swipr Example"),
    hr(),
    p("I would greatly appreciate if you would swipe me.")
  ),
  textOutput("card_swipe")
)

server <- function(input, output, session) {
  card_swipe <- callModule(shinySwipr, "swiper1")
  output$card_swipe <- renderText({
    if(is.null(card_swipe())){
      "You didn't swipe yet. Do it!"
    } else{
      paste("You last swiped",card_swipe())
    }
  })
}

shinyApp(ui, server)