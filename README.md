# Patient info downloader
**An internal patient information downloader for clinical studies (for Gloria)**.  
*Current version: v1.0.1*

## How to use the script
1. Open **JHU SAFE desktop** (VM)
2. Go to **Crunchr** website, then go to **Compute**
3. Create a new container: **PMAP RStudio**
4. Click the name of the container to open RStudio
5. Create a new R script in RStudio, paste the [**raw script**](https://raw.githubusercontent.com/chenh19/patient_info/main/patient_info_downloader.R) into it
6. change the **JHED_ID** ([line 10](https://github.com/chenh19/patient_info/blob/36743fd48741e99f60b5913bf88ffc35951e4057/patient_info_downloader.R#L10)), **server_name** ([line 15](https://github.com/chenh19/patient_info/blob/36743fd48741e99f60b5913bf88ffc35951e4057/patient_info_downloader.R#L15)), **db_name** ([line 16](https://github.com/chenh19/patient_info/blob/36743fd48741e99f60b5913bf88ffc35951e4057/patient_info_downloader.R#L16))
7. Run the script
8. Click the "**all_tables.zip**" in the **Files** panel (bottom right) to download
