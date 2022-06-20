# Patient info downloader
**An internal patient information downloader for clinical studies (for Gloria)**.  
*Current version: v1.1.0*

## How to use
1. Open **JHU SAFE desktop** (VM)
2. Go to **Crunchr** website, then go to **Compute**
3. Create a new container: **PMAP RStudio**
4. Click the name of the container to open RStudio
5. Create a new R script in RStudio, paste in the [**raw script**](https://raw.githubusercontent.com/chenh19/patient_info/main/patient_info_downloader.R)
6. Click **Source** to the execute the entire script
7. Enter your **JHED_ID**, **JHED_ID password**, **server_name**, and **db_name** following the prompts
8. Click on "**all_tables.zip**" in the **Files** panel (bottom right) to download
