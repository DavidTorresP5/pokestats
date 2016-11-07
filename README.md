# pokestats
A simple shiny app to explore some data from the popular videogame *Pokemon*. 

:star: New update soon! :star:

![Pokestats](pokest.png)

To run the app, run the following lines of code in **R**:

```{r}
# Use these lines to download the required packages
install.packages("shiny")
install.packages("ggplot2")
install.packages("shiny")
install.packages("shinythemes")
install.packages("dplyr")

# Run the app:
library(shiny)
runGitHub("pokestats", "DavidTorresP5")
```
Use this [script](requirements.R) to install the packages faster.
You can download the data following this [link](https://www.kaggle.com/abcsds/pokemon).
