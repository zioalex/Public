# Intro

Following the [Springer free offer](https://www.springernature.com/de/librarians/news-events/all-news-articles/industry-news-initiatives/free-access-to-textbooks-for-institutions-affected-by-coronaviru/17855960r)  during Corona time I created a script to download all the ebook in such libraries.

Based on [ITler Gist](https://gist.github.com/ITler/0a82f3ff858b366c9a9344e07c3d206c)

# Prerequisites
Input file should be based on downloadable Excel sheets, but saved as CSV file setting field delimiter ; and string delimiter empty)
Remove books you do not want to download by deleting entire line in CSV file
DO NOT remove columns

# Usage
Download the script

Call this script

    bash download-springer.sh your_selection.csv

Dowloaded files are named by ISBN-TITLE-AUTHOR-BOOK_YEAR.pdf, which is parsed from the input file

 
