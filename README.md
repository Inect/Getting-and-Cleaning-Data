# Getting-and-Cleaning-Data
part 1
The code starts by download and assigning the data files to vaiables
The names stored in feautes are applied to the testX and trainX vaiables
next the data from testY, train Y, and sujects are added to the testX and Train X variable
rbind is used next to create the master data file
duplicate enteries are removed to create one data set

part 2
I create a table and asign it to the vaiable mean using grep and then extract the mean data
I create a table and asign it to the vaiable std using grep and then extract the standerad devation



part 3
i apply the discriptive names to activites found in the activity lable.txt and apply the names to the corect numbers

Part 4
i cleaned up the names making it easier to read and understand the lables
I change "t" to "time." 
and chaned "f" to "freq." I find this makes it easier to read the lables without making the lable to long

I also change "-" to "_" to make the data readalbe by all programs
removed ",()" from lables

Part 4
I took the data and apllyed it to a data table
i used lapply for the SD and the Mean
the file is then wrien to tidy.txt for record keeping 