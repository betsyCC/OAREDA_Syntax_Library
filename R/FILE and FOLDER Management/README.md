# FILE and FOLDER Management

## Copilot Agent Development

Copilot agents as of 10-2-2025 do not support adding manmy types of code files, like .r, .rmd, .py, and .sql files into sharepoint or document knowledge sources.  In order to get around this limitatipon the file extensions need to be changed to .txt or .md or soe other supported file type.  For infor on what types of files are supported see: 

- https://learn.microsoft.com/en-us/microsoft-copilot-studio/knowledge-add-unstructured-data#add-sharepoint-files-and-folders for SharePoint 

and here: 

- https://learn.microsoft.com/en-us/microsoft-copilot-studio/knowledge-add-unstructured-data#add-sharepoint-files-and-folders for Documents.

As a result I wrote the r script in this folder to copy over the syntax library and change file extensions in a separate folder that I can use as the knowledge source for our copilot agents.