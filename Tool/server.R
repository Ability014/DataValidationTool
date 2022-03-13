#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(bslib)
library(reactable)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  shinyEnv <- environment() 
  
  observeEvent(input$source_connect, {
    
    if(input$source == "s_type_server"){
      
      session$sendCustomMessage(type = 'testmessage',
                                message = list(Server = input$ss_server_name,
                                               db = input$ss_database_name,
                                               Username = input$ss_user_name,
                                               Password = input$ss_password))
      
    } else {
      
      session$sendCustomMessage(type = 'testmessage',
                                message = list(Server = input$sw_server_name,
                                               db = input$sw_database_name))
    }
 })
  
  observeEvent(input$destination_connect, {
    
    if(input$destination == "d_type_server"){
      
      session$sendCustomMessage(type = 'testmessage',
                                message = list(Server = input$ds_server_name,
                                               db = input$ds_database_name,
                                               Username = input$ds_user_name,
                                               Password = input$ds_password))
      
    } else {
      
      session$sendCustomMessage(type = 'testmessage',
                                message = list(Server = input$dw_server_name,
                                               db = input$dw_database_name))
    }
  })
  
  codeInput <- reactive({ input$sq_query })
  
  get_source_preview <- eventReactive(input$source_go, {
    
    if (input$source_field == "s_type_table"){
       mtcars[, c("mpg", input$st_table), drop = FALSE]
    } else {
      eval(parse(text=codeInput()), envir=shinyEnv)
    }
    
  })
  
  
  output$data <- renderReactable({
    reactable( data = get_source_preview(),
               rownames = TRUE,
               compact = TRUE)
  })
  
  codeInput2 <- reactive({ input$dq_query })
  
  get_destination_preview <- eventReactive(input$dest_go, {
    
    if (input$dest_field == "d_type_table"){
      mtcars[, c("mpg", input$dt_table), drop = FALSE]
    } else {
      eval(parse(text=codeInput2()), envir=shinyEnv)
    }
    
  })
  
  
  output$data2 <- renderReactable({
    reactable( data = get_destination_preview(),
               rownames = TRUE,
               compact = TRUE)
  })


})
