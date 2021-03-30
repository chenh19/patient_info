# Install packages
install.packages(c("RODBC", "filesstrings", "dplyr"))


# Load packages
lapply(c("RODBC", "filesstrings", "dplyr", "utils"), require, character.only = TRUE)


# Login with JHED ID
print(Sys.setenv(JHED = 'JHED_ID')) #Put your JHED here
print(Sys.setenv(JHED_PWD = rstudioapi::askForPassword("")))


# Connect to SQL database
server="Your_Server_Name" #Change this
db_name="Your_Database_Name" #Change this
pwd = Sys.getenv("JHED_PWD")
stopifnot(nzchar(pwd))
JHED = Sys.getenv("JHED")
stopifnot(nzchar(pwd))
connectionString <- paste0("Driver=freeTDS;TDS_Version=8.0;",'Server=',server,';Port=1433;Database=',
                           db_name,'; Uid=win\\',Sys.getenv("JHED"),
                           ';Pwd=',Sys.getenv("JHED_PWD"))
con <- odbcDriverConnect(connection=connectionString)


# Access the tables
tabs <- sqlTables(con) #Prints out list of tables; use tables w/ dbo schema
tabs <- filter(tabs, TABLE_TYPE == "TABLE")
tabs <- filter(tabs, TABLE_SCHEM == "dbo")
write.table(tabs, file="all_tables.csv", sep=",", row.names = FALSE)
tab_names <- read.csv("all_tables.csv")[,"TABLE_NAME"]


# Download the tables
dir.create("Tables")
for (tab_name in tab_names){
  df <- sqlFetch(con, tab_name)
  filename <- paste0(tab_name, ".csv")
  write.table(df, file=filename, sep=",", row.names = FALSE)
  file.move(filename, "./Tables", overwrite=TRUE)
  Sys.sleep(1)
}
close(con) #close the connection when done


# Compress all csv files into one zip file
files2zip <- dir('Tables', full.name=TRUE)
zip(zipfile = 'all_tables', files = files2zip)
