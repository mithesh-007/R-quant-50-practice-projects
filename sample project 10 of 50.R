install.packages("shiny")
install.packages("shinydashboard")

library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "this is a static dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard",tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Reports", tabName = "reports",icon = icon("file" ))
    )
  ),
  dashboardBody(
    tabItems(
    tabItem(tabName = "dashboard",
            h2("dashboard overview"),
            fluidRow(
            box(title = "box 1", status = "primary", solidHeader = TRUE, width = 6,
            "this is the static content"),
            box(title = "box 2", status = "warning", solidHeader = TRUE, width = 6,
            "this is another box of static content")
            
            
            )
  ),
  tabItem(tabName = "reports",
          h2("report Overview"),
          p("static content for reports")
          )
)
)
)

server <- function(input,output) {
  
}

shinyApp(ui, server)