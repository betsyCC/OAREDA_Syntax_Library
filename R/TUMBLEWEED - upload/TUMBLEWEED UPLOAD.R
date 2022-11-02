library(tidyverse)
library(curl)


########################## UPLOAD TO TUMBLEWEED ################################
#------------------------------------------------------------------------------#

# ---------- UPLOAD TO IR FOLDERS ---------- #

tw_url <- "sftp://st-edge.cuny.edu/"

tw_folder_names <- read_csv("O:/!Projects/OAREDA_Syntax_Library/DATA/College Lookup Table to Tumbleweed.csv")

# Creates a function for uploading files. 
# The filenames must start with either the COLLEGE_NAME_SHORT or INSTITUTION ID
# edit the folder location in the next line to the place where the files for upload are saved
upload_function <- function(file_location = 'O:/!Projects/PUT_FOLDER_LOCATION_HERE') {
  
  # prompts you to enter your username and password
  user <- rstudioapi::askForPassword("Tumbleweed User ID:")
  pw <- rstudioapi::askForPassword("Tumbleweed password:")
  
  # creates a list of the files in the file_location folder
  file_list <- list.files(file_location) %>%
    tibble() %>%
    # next line of code creates a common field to use for joining with tw_folder_names by extracting the COLLEGE_NAME_SHORT from the file names 
    # change COLLEGE_NAME_SHORT to INSTITUTION if the file starts with the institution ID
    mutate(COLLEGE_NAME_SHORT = str_replace_all(., 'put_part_of_filename_to_replace_here', '')) %>%
    inner_join(tw_folder_names)
  
  # loops through all the files in the file_list and uploads them to Tumbleweed
  for (i in 1:nrow(file_list)) {
    tw_path = paste0(tw_url, "IR/", file_list[i,"TW_FOLDER_IR"], "/", file_list[i,1])
    curl_upload(paste0(file_location, "/", file_list[i,1]), # path to file to upload
                tw_path,
                username = user,
                password = pw)
    cat("\nUploaded: ", tw_path)
  }
  
  # # ---------- UPLOAD TO REG FOLDERS ---------- #
  # 
  # for (i in 1:nrow(file_list)) {
  #   tw_path = paste0(tw_url, "Reg/", file_list[i,"TW_FOLDER_REG"], "/", file_list[i,1])
  #   curl_upload(paste0(file_location, "/", file_list[i,1]), # path to file to upload
  #               tw_path,
  #               username = user,
  #               password = pw)
  #   cat("\nUploaded: ", tw_path)
  # }
  
}

# run this line to run the upload_function
upload_function()
