# [XLConnect](https://cran.r-project.org/web/packages/XLConnect/index.html)

[XLConnect](https://cran.r-project.org/web/packages/XLConnect/index.html) is a really useful package for filling in excel templates where you have no control over the template and have to use what's given to you and don't want to mess up the formatting...


Some tips if you want to use it that should save you a lot of time:
	
1. You need to install Java first and then restart your computer before installing the XLConnect package.

2. If you want to fill in the template without changing any formatting you need to add this line of code... ```setStyleAction(wb, XLC$"STYLE_ACTION.NONE") # this line keeps the formatting the same!!!```

3. Basic steps are to load the workbook:

	1. set the style using the code line above (if you don't want to change the formatting),
	2. create a named region with the sheet name and upper left corner cell location where you want to write the data,
	3. write your data to that named region (and probably you want header=FALSE to just write the data without your dataframe header),
	3. save your workbook and remove it from R to release the named region for use in the next template. 

4. Here's some sample code that I used for AAUP to fill in the templates for all the schools using a loop and filtering the data by school business unit... There were 5 tabs in the excel template that needed to be completed named "Form 1", "Form 2", "Form 3", "Form 4", "Form 6", and I prepped the data in dataframes one for each form in the right structure first...
  
  
```
f1_data <- data.frame(val = c('Betsy Rosalen', '646-664-8275', 'elizabeth.rosalen@cuny.edu'),
                      row.names = c('Name', 'Phone', 'Email'))
                      
for (bu in unique(form2$BUSINESS_UNIT)){​
  wb <- loadWorkbook(paste0("../College Files/Templates Completed/", 
                            bu, "_AAUP_FCS_data-export_2023.xlsx"), create = FALSE)
                            
  setStyleAction(wb, XLC$"STYLE_ACTION.NONE") # this line keeps the formatting the same!!!
  
  createName(wb, name = "f_one", formula = "'Form 1'!$C$5", overwrite=TRUE)
  writeNamedRegion(wb, f1_data, name = "f_one", header = FALSE)
  
  createName(wb, name = "f_two", formula = "'Form 2'!$B$7", overwrite=TRUE)
  f2_data <- form2 %>% filter(BUSINESS_UNIT==bu) %>% select(Mtot:F5)
  writeNamedRegion(wb, f2_data, name = "f_two", header = FALSE)
  
  createName(wb, name = "f_three", formula = "'Form 3'!$B$6", overwrite=TRUE)
  f3_data <- form3 %>% filter(BUSINESS_UNIT==bu) %>% 
    select(expense:count)
  writeNamedRegion(wb, f3_data, name = "f_three", header = FALSE)
  
  createName(wb, name = "f_four", formula = "'Form 4'!$B$6", overwrite=TRUE)
  f4_data <- form4 %>% filter(BUSINESS_UNIT==bu) %>% 
    select(count:total_ly)
  writeNamedRegion(wb, f4_data, name = "f_four", header = FALSE)
  
  createName(wb, name = "f_six", formula = "'Form 6'!$B$6", overwrite=TRUE)
  f6_data <- form6 %>% filter(BUSINESS_UNIT==bu) %>% 
    select(frequency:Medical_Benefits)
  writeNamedRegion(wb, f6_data, name = "f_six", header = FALSE)
  
  saveWorkbook(wb)
  rm(wb)
}​
```