library(tidyverse)
setwd("C:/Users/erosalen/OneDrive - CUNY")

# ---------------------------------------------------------------------------- #
# Copies over all files and replaces them if they already exist keeping the same subfolder structure
# still need to add code to look for deleted files that are in the destination but not the source
# ---------------------------------------------------------------------------- #

SourceFolder <- "OAREDA_Syntax_Library"
DestinationFolder <- "OAREDA Syntax Library - for Copilot"

SourceFolder <- "Data Documentation Repository (OAREDA) - Syntax Library"
DestinationFolder <- "Data Documentation Repository - for Copilot - Documents/Syntax Library"


# First create the subdirectory structure
# ---------------------------------------------------------------------------- #
OrigFolders <- list.dirs(path = SourceFolder, # list.dirs does not have an option to remove hidden directories
                         full.names = FALSE, # by selecting FALSE here you can just append this list to the destination folder
                         recursive = TRUE) %>% # TRUE includes all subdirectories
  as.data.frame() %>%
  filter(!str_detect(., ".git")) # gets rid of hidden .git directory but should be made more generic to get rid of all hidden directories

for (folder in OrigFolders$.) {
  if (!dir.exists(paste0(DestinationFolder, "/", folder))) {
    dir.create(paste0(DestinationFolder, "/", folder), recursive = TRUE) # recursive = TRUE creates parent directories if needed
  }
}

# Second copy over files while simultaneously changing file extensions
# ---------------------------------------------------------------------------- #
OrigFiles <- list.files(path = SourceFolder, 
                        pattern = NULL, # Regex pattern to match
                        all.files = FALSE, # TRUE returns hidden files too
                        full.names = TRUE, # TRUE the directory path is prepended
                        recursive = TRUE, # TRUE includes files in subdirectories
                        ignore.case = FALSE, # for pattern matching
                        include.dirs = FALSE, # Should subdirectory names be included in list
                        no.. = FALSE) %>% as.data.frame() %>%
  filter(!str_detect(., ".ini")) # gets rid of hidden desktop.ini files but should be made more generic to get rid of all hidden directories


for (source_file_path in OrigFiles$.) {
  # Extract extension
  file_ext <- tools::file_ext(source_file_path)
  # replace source folder path with destination folder path
  destination_file_path <- str_replace(source_file_path, 
                                       fixed(SourceFolder), # fixed fixes the regex problem caused by parentheses in the folder name
                                       DestinationFolder)
  
  # Define condition for extension change and replace with .txt
  if (file_ext %in% c("r", "R", "rmd", "Rmd", "sql", "py")) { 
    destination_file_path <- str_replace(destination_file_path, "\\.r$|\\.R$|\\.rmd$|\\.Rmd$|\\.sql$|\\.py$", ".txt")
  } 
  
  # Copy the file
  file.copy(from = source_file_path, to = destination_file_path, overwrite = TRUE)
}

# ---------------------------------------------------------------------------- #
# still need to add code here to look for deleted files that are in the destination 
# but not the source and remove them
# ---------------------------------------------------------------------------- #
