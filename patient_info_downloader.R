# This script downloads IRB-approved patient information for clinical studies
# Current version: v1.1.2


# Install and load required packages
install.packages(c("RODBC", "filesstrings", "dplyr", "svDialogs"))
Sys.sleep(1)
lapply(c("RODBC", "filesstrings", "dplyr", "svDialogs", "utils"), require, character.only = TRUE)
Sys.sleep(1)


# Connect to SQL database with JHED ID
print(Sys.setenv(JHED = dlgInput("Please enter your JHED ID:", Sys.info()[""])$res))
JHED = Sys.getenv("JHED")
Sys.sleep(1)
print(Sys.setenv(JHED_PWD = rstudioapi::askForPassword("")))
pwd = Sys.getenv("JHED_PWD")
stopifnot(nzchar(pwd))
Sys.sleep(1)
server = dlgInput("Please enter the Server name:", Sys.info()[""])$res
Sys.sleep(1)
db_name = dlgInput("Please enter the Database name:", Sys.info()[""])$res
Sys.sleep(1)
connectionString <- paste0("Driver=freeTDS;TDS_Version=8.0;",'Server=',server,';Port=1433;Database=',
                           db_name,'; Uid=win\\',Sys.getenv("JHED"),';Pwd=',Sys.getenv("JHED_PWD"))
con <- odbcDriverConnect(connection=connectionString)
Sys.sleep(1)


# Find all the tables
tabs <- sqlTables(con) #Prints out list of tables; use tables w/ dbo schema
tabs <- filter(tabs, TABLE_TYPE == "TABLE")
tabs <- filter(tabs, TABLE_SCHEM == "dbo")
write.table(tabs, file="all_tables.csv", sep=",", row.names = FALSE)
tab_names <- read.csv("all_tables.csv")[,"TABLE_NAME"]
Sys.sleep(1)


# Download all the tables
if (dir.exists("Tables") == FALSE){
  dir.create("Tables")
}
for (tab_name in tab_names){
  df <- sqlFetch(con, tab_name)
  filename <- paste0(tab_name, ".csv")
  write.table(df, file=filename, sep=",", row.names = FALSE)
  file.move(filename, "./Tables", overwrite=TRUE)
  Sys.sleep(1)
}
close(con) #close the connection when done
Sys.sleep(1)


# Export all the tables in a single zip file
files2zip <- dir('Tables', full.name=TRUE)
zip(zipfile = 'all_tables', files = files2zip)
Sys.sleep(1)
rm(list = ls())
Sys.unsetenv(c("JHED","JHED_PWD"))
Sys.sleep(1)
dlgMessage('All done! Click "all_tables.zip" in Files panel to download.')
