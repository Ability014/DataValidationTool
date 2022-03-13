


library(shiny)
library(shinyjs)
library(bslib)

# Define UI for application that draws a histogram
shinyUI(

  navbarPage("ValidateR",
             
             shinyjs::useShinyjs(),
             
             id = "nav_bar",
             
             theme = bs_theme(version = 5,
                              fg = "rgb(103, 89, 117)",
                              font_scale = NULL, 
                              `enable-shadows` = FALSE,
                              bootswatch = "zephyr", 
                              bg = "#fff"),
             
             
             tabPanel("Connection", icon = icon("home"),
                      
                      fluidRow(
                        
                        column(6,
                               
                               div(id = "source_section",
                                   
                                   
                                   radioButtons("source", 
                                                h2("Source"),
                                                c("Server Auth" = "s_type_server",
                                                  "Windows" = "s_type_windows"),
                                                inline = TRUE),
                                   
                                   conditionalPanel(
                                     
                                     condition = "input.source == 's_type_server'",
                                     
                                     textInput("ss_server_name",
                                               "Server Name",
                                               "",
                                               width = '100%',
                                               placeholder = "Enter server name"),
                                     
                                     textInput("ss_database_name",
                                               "Database Name",
                                               "",
                                               width = '100%',
                                               placeholder = "Enter database name"),
                                     
                                     textInput("ss_user_name",
                                               "User Name", 
                                               "",
                                               width = '100%',
                                               placeholder = "Enter User name"),
                                     
                                     passwordInput("ss_password",
                                                   "Password",
                                                   width = '100%')
                                   ),
                                   
                                   
                                   conditionalPanel(
                                     
                                     condition = "input.source == 's_type_windows'",
                                     
                                     textInput("sw_server_name",
                                               "Server Name",
                                               "",
                                               width = '100%',
                                               placeholder = "Enter server name"),
                                     
                                     textInput("sw_database_name",
                                               "Database Name",
                                               "",
                                               width = '100%',
                                               placeholder = "Enter Database name")
                                   ),
                                   
                                   
                                   actionButton("source_connect",
                                                "Connect"),
                                   
                                   
                                   
                                   style = "border-style: dotted;
                                            text-align: center;
                                            justify-content: center; 
                                            align-items: center;
                                            padding-left: 40px;
                                            padding-right: 40px;
                                            padding-bottom: 20px;
                                            #string { height: 50px;
                                                      width: 100%;
                                                      text-align:center;
                                                      font-size: 30px;
                                                      display: block;}")
                              ),
                        
                        column(6,
                               
                               div(id = "dest_section",
                                   
                                   radioButtons("destination", 
                                                h2("Destination"),
                                                c("Server Auth" = "d_type_server",
                                                  "Windows" = "d_type_windows"),
                                                width = '100%',
                                                inline = TRUE),
                                   
                                   conditionalPanel(
                                     
                                     condition = "input.destination == 'd_type_server'",
                                     
                                     textInput("ds_server_name",
                                               "Server Name",
                                               "",
                                               width = '100%',
                                               placeholder = "Enter server name"),
                                     
                                     textInput("ds_database_name",
                                               "Database Name",
                                               "",
                                               width = '100%',
                                               placeholder = "Enter Database name"),
                                     
                                     textInput("ds_user_name",
                                               "User Name", 
                                               "",
                                               width = '100%',
                                               placeholder = "Enter User name"),
                                     
                                     passwordInput("ds_password",
                                                   "Password",
                                                   width = '100%')
                                              
                                   ),
                                   
                                   conditionalPanel(
                                     
                                     condition = "input.destination == 'd_type_windows'",
                                     
                                     textInput("dw_server_name",
                                               "Server Name",
                                               "",
                                               width = '100%',
                                               placeholder = "Enter server name"),
                                   
                                     textInput("dw_database_name",
                                               "Database Name",
                                               "",
                                               width = '100%',
                                               placeholder = "Enter Database name")
                                     
                                   ),
                                   
                                   
                                   actionButton("destination_connect",
                                                "Connect"),
                                   
                                   
                                   style = "border-style: dotted;
                                            text-align: center;
                                            justify-content: center; 
                                            align-items: center;
                                            padding-left: 40px;
                                            padding-right: 40px;
                                            padding-bottom: 20px;
                                            #string { height: 50px;
                                                      width: 100%;
                                                      text-align:center;
                                                      font-size: 30px;
                                                      display: block;}")
                        
                      ),
                      
                      singleton(
                        tags$head(tags$script(src = "MessageHandler.js"))
                      )
                      
                      )),
             
             tabPanel("Source/Dest",
                      
                      fluidRow(
                        
                        column(6,
                               
                               div(id = "sourceField",
                                   
                                   
                                   radioButtons("source_field", 
                                                h2("Source"),
                                                c("Select Table" = "s_type_table",
                                                  "Import Query" = "s_type_query"),
                                                inline = TRUE),
                                   
                                   conditionalPanel(
                                     
                                     condition = "input.source_field == 's_type_table'",
                                     
                                     selectizeInput("st_table",
                                                    label = NULL,
                                                    c("Cylinders" = "cyl",
                                                      "Transmission" = "am",
                                                      "Gears" = "gear"),
                                                    width = '100%')
                                   ),
                                   
                                   
                                   conditionalPanel(
                                     
                                     condition = "input.source_field == 's_type_query'",
                                     
                                     textAreaInput("sq_query",
                                                   label = NULL,
                                                   "",
                                                   width = '100%',
                                                   height = '250px',
                                                   placeholder = "Enter SQL Query")
                                   ),
                                   
                                   
                                   actionButton("source_go",
                                                "Go!"),
                                   
                                   
                                   style = "border-style: dotted;
                                            text-align: center;
                                            justify-content: center; 
                                            align-items: center;
                                            padding-left: 40px;
                                            padding-right: 40px;
                                            padding-bottom: 20px;
                                            #string { height: 50px;
                                                      width: 100%;
                                                      text-align:center;
                                                      font-size: 30px;
                                                      display: block;}"),
                               reactableOutput("data")
                        ),
                        
                        column(6,
                               
                               div(id = "destField",
                                   
                                   radioButtons("dest_field", 
                                                h2("Destination"),
                                                c("Select Table" = "d_type_table",
                                                  "Import Query" = "d_type_query"),
                                                inline = TRUE),
                                   
                                   conditionalPanel(
                                     
                                     condition = "input.dest_field == 'd_type_table'",
                                     
                                     selectizeInput("dt_table",
                                                    label = NULL,
                                                    c("Cylinders" = "cyl",
                                                      "Transmission" = "am",
                                                      "Gears" = "gear"),
                                                    width = '100%')
                                   ),
                                   
                                   
                                   conditionalPanel(
                                     
                                     condition = "input.dest_field == 'd_type_query'",
                                     
                                     textAreaInput("dq_query",
                                                   label = NULL,
                                                   "",
                                                   width = '100%',
                                                   height = '250px',
                                                   placeholder = "Enter SQL Query")
                                   ),
                                   
                                   
                                   actionButton("dest_go",
                                                "Go!"),
                                   
                                   
                                   style = "border-style: dotted;
                                            text-align: center;
                                            justify-content: center; 
                                            align-items: center;
                                            padding-left: 40px;
                                            padding-right: 40px;
                                            padding-bottom: 20px;
                                            #string { height: 50px;
                                                      width: 100%;
                                                      text-align:center;
                                                      font-size: 30px;
                                                      display: block;}"),
                               reactableOutput("data2")
                               
                        )
                        
                      )),
             
             tabPanel("Expectation"),
             
             tabPanel("Results"),
             
             tabPanel("Action"),
             
             tabPanel("Schedule")
             
             
  )
    
)
