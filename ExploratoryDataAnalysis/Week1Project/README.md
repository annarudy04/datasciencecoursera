## Introduction

The prompt for this assignment can be found [here](https://github.com/rdpeng/ExData_Plotting1). The goal is to produce a four of graphs using R's base plotting system. The code to produce each plot is found in a separate R file (plot1.R, plot2.R, etc) and each plot is found in a different png (plot1.png, plot2.png, etc). 

## Graph Descriptions
 * plot1: histogram for Global Active Power
 * plot2: line graph for Global Active Power over time 
 * plot3: line graph for sub meterings 1-3 over time
 * plot4: line graphs for global active power, voltage, energy sub metering, and global reactive power over time 

## Data

This assignment uses data from
the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine
Learning Repository</a>, a popular repository for machine learning
datasets. In particular, we will be using the "Individual household
electric power consumption Data Set". The data will be filtered to use only rows
from 2/01/2007 and 2/02/2007. 


* <b>Dataset</b>: <a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip">Electric power consumption</a> [20Mb]

* <b>Description</b>: Measurements of electric power consumption in
one household with a one-minute sampling rate over a period of almost
4 years. Different electrical quantities and some sub-metering values
are available.


The following descriptions of the 9 variables in the dataset are taken
from
the <a href="https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption">UCI
web site</a>:

<ol>
<li><b>Date</b>: Date in format dd/mm/yyyy </li>
<li><b>Time</b>: time in format hh:mm:ss </li>
<li><b>Global_active_power</b>: household global minute-averaged active power (in kilowatt) </li>
<li><b>Global_reactive_power</b>: household global minute-averaged reactive power (in kilowatt) </li>
<li><b>Voltage</b>: minute-averaged voltage (in volt) </li>
<li><b>Global_intensity</b>: household global minute-averaged current intensity (in ampere) </li>
<li><b>Sub_metering_1</b>: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered). </li>
<li><b>Sub_metering_2</b>: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light. </li>
<li><b>Sub_metering_3</b>: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.</li>
</ol>

## Graph Descriptions
 * plot1: histogram for Global Active Power
 * plot2: line graph for Global Active Power over time 
 * plot3: line graph for sub meterings 1-3 over time
 * plot4: line graphs for global active power, voltage, energy sub metering, and global reactive power over time 
 
## Usage

Each plot can be created by sourcing the plot's R code. For example, plot1.png can be created
by running:
`source('plot1.R') `

All plots can be created by running:
`source(create_plots.R)`
Note that this option reloads and reprocesses the data for each plot. This is because the 
assignment requires that each plot's R file contain the code to load the data. 