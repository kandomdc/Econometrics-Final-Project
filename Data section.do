* setup
clear all
set more off
cd "C:\Users\kdeso\OneDrive\Documents\ECON 381\Final Project"

* load data
import delimited data_initial.csv,
drop v1 v2

* labels
label variable log_price "Log Stock Price"
label variable total_score "ESG Score"
label variable after_shock "After Midterm Election?"

* summary stats
asdoc tabstat log_price total_score day after_shock industrials healthcare informationtechnology utilities financials materials consumerdiscretionary realestate communicationservices consumerstaples energy, statistics(mean sd N min max) replace label title(Table 1)

* naive regression
reg log_price total_score
outreg2 using NaiveReg, dec(3) tex(frag) title(Table 2) ctitle("Interaction") replace addstat("Adjusted R-squared",e(r2_a)) label

* regression
reg log_price total_score after_shock day industrials healthcare informationtechnology utilities financials materials consumerdiscretionary realestate communicationservices consumerstaples energy, noc

outreg2 using ResultsTable, dec(3) tex(frag) title(Table 3) ctitle("No Interaction") replace addstat("Adjusted R-squared",e(r2_a)) label

* Robust Regression
reg log_price total_score after_shock day industrials healthcare informationtechnology utilities financials materials consumerdiscretionary realestate communicationservices consumerstaples energy, noc robust

outreg2 using Robust, dec(3) tex(frag) title(Table 4) ctitle("No Interaction") replace addstat("Adjusted R-squared",e(r2_a)) label

reg log_price c.total_score##i.after_shock day industrials healthcare informationtechnology utilities financials materials consumerdiscretionary realestate communicationservices consumerstaples energy, noc robust

outreg2 using Robust, dec(3) tex(frag) title(Table 4) append ctitle("Interaction") addstat("Adjusted R-squared",e(r2_a)) label

* plot
twoway (line log_price day, title("Figure 1") xtitle(day) ytitle("Log Price") colorvar(total_score) colorrule(%30))
	   
graph export "line.png",replace
