library(RDCOMClient)

# https://github.com/omegahat/RDCOMClient

# If you want formatting (bold, italics, different fonts, etc), 
# you can compose the  email in Word, then save it as Web Page, filtered .htm
# not .html Then, if you want to insert any numbersstats, I would put tags 
# in the message body where you want to insert them and do something like str_replace(). 
# Otherwise, you can build the message body in R, with paste() or glue() to add the dynamic content. 
# You could probably put html tags into your message text for formatting if you build it this way
# You should also be able to use RMarkdown to compose the html message

# to read in a pre-composed html message
email_body - paste0(read_lines(__YOUR_FILE__, collapse = 'n') %% iconv(WINDOWS-1252, UTF-8)

# create the outlook object
Outlook - COMCreate(Outlook.Application)

#create the email
Email = Outlook$CreateItem(0)

# I haven't tested this myself, but supposedly if you want your signature, you can pull it
# from Outlook first, then add it to your message
outMail$GetInspector()
Signature - outMail[[HTMLbody]]
email_body - paste(email_body, Signature)                     


# add the fields, there are many more available than this
Email[[to]] = some.person@cuny.edu
Email[[cc]] = someone.else@cuny.edu
Email[[bcc]] = etc@etc.edu 
Email[[Subject]] = Hello World!
  
# attach your message
Email[[htmlbody]] = email_body

# if you want to add an attachment, you need to be very specific with the path
# format, including the actual network machine name, not drive letter
# (drive letter might work with C drive)
Email[[Attachments]]$Add(filer1OIRADATA!Projects!RequestsAcademic AffairsTeacher Edmyfile.xlsx)

# Now, you have two choices, you can open the message in Outlook, to review and send manually
Email$Display()

# Or, send it directly from R without looking at it first. It will appear in your Outbox
Email$Send()