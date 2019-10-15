library(shiny)
shinyApp(
  ui = fluidPage(
    numericInput(inputId = "eval_input", label = "Quando, na sua opinião, vale sua empresa?", value = 1000000000),
    #sliderInput("slider", "Slider", 1, 100, 50),
    downloadButton("report", "Generate report")
  ),
  server = function(input, output) {
    output$report <- downloadHandler(
      filename = "report.pdf",
      content = function(file) {
        tempReport <- file.path(tempdir(), "report.Rmd")
        file.copy("report.Rmd", tempReport, overwrite = TRUE)
        
        params <- list(n = input$eval_input)
        
        rmarkdown::render(tempReport, output_file = file,
                          encoding = "UTF-8",
                          params = params,
                          envir = new.env(parent = globalenv())
        )
      }
    )
  }
)
