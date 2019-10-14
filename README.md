# junk-drawer

This is a very simple web app for uploading files to a server.

## but why?

I wanted a way to upload files (well, screenshots) from my Wii U. The services Nintendo originally provided for this
have, to my knowledge, been shut down.

At first I tried simply signing in at photos.google.com and uploading there, but that didn't work for unknown reasons.

Then, I wrote a simple file upload page into my personal web app. But that app is served over SSL with a certificate 
from Let's Encrypt, and the Wii U Internet browser doesn't support those certificates!

So, I wrote this simple web app so I could run it without SSL (sadly).
