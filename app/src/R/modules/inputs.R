file_input <- fileInput("file1", "Faça o upload do dataset",
    multiple = FALSE, accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv"))

header = checkboxInput("header", "Header", TRUE)

sep <- radioButtons("sep", "Separator",
    choices = c(Comma = ",", Semicolon = ";", Tab = "\t"), selected = ",")

quote <- radioButtons("quote", "Quote",
    choices = c(None = "", "Double Quote" = '"', "Single Quote" = "'"),selected = '"')

disp <- radioButtons("disp", "Display",  
    choices = c(Head = "head", All = "all"), selected = "head")