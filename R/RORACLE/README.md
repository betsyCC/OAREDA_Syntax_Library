# ROracle Installation Tips

From MS Teams Data AID / RUsers Channel:  [10-11-2023 6:52 PM] Betsy Rosalen

I got  Oracle Client v.19.3, R version 4.3.1, and RStudio 2023.09.0 to play nicely together.  

Assuming you already installed the Oracle Client using Mark Cassazza's instructions here:  
<https://cuny907.sharepoint.com/:w:/r/sites/OAREDA/Shared%20Documents/General/Onboarding/Oracle_2_Install_Oracle_Client_19.3.docx?d=w04938ebf85b048ba874ed94f02501ddc&csf=1&web=1&e=dAncUS>

Per StackOverflow: 

<https://stackoverflow.com/questions/57681040/in-r-and-when-installing-roracle-package-how-do-i-set-oci-lib64>

I had to set these environment variables to get R/RStudio to find my client folders...

```
Sys.setenv(OCI_INC="C:/app/oracle/product/19.3.0/client_1/oci/include")
Sys.setenv(OCI_LIB64="C:/app/oracle/product/19.3.0/client_1/bin")
Sys.setenv(OCI_HOME="C:/app/oracle/product/19.3.0/client_1")
install.packages("ROracle")
```

Once that error was solved per StackOverflow: 

<https://stackoverflow.com/questions/52215350/roracle-package-installation-failure>

MANUALLY COPY contents of ORACLE include folder here: 

- C:\app\oracle\product\19.3.0\product\19.3.0\client_1\oci\include

to R include folder here: 

- C:\Program Files\R\R-4.3.1\include

