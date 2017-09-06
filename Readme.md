# Estimating lifetime value and customer equity for non-profit donors

Estimation of total customer equity and lifetime value are essential components for developing a successful Customer Relationship Management (CRM) strategy. Indeed, in many ways the CRM strategy should be designed to increase customer equity over time.  This is also true for nonprofit organizations, since much of their revenue is based on continued contribution of their active donors. This project attempts to improve the estimation of customer equity and lifetime value for a leading US nonprofit organization [1] based on previous transaction and contact history. 

Customer equity is the aggregate value of customers to a business, or in our case the total value of donations from all donors, during a transactional period. The ability to predict customer equity into the future allows the management team to plan for potential revenue changes and to balance efforts for gaining new customers vs increasing value from current costomers. Remarkable growth in the amount and kinds of customer data has also allowed for more granular examination of customer value. Lifetime value is an estimate on the total and future value that each individual customer has for the company. Demographic data and individual customer transaction history can be used to cluster and categorize customers in order to optimally target marketing campaigns to specific customers. 


## Data files

1. appeal from appeal.sas7bdat. 
2. trans from trans.sas7bdat.  This might correspond to "History Final.txt" but that file appears poorly formatted. 
3. donor from donor.sas7bdat, which is identical to "First Gift Final.txt" file. 
4. source from source.sas7bdat, which is identical to "Appeal Cost.txt" file. 
5. infocode from "InfoCode.txt" - appears to have donor id and three letter code. 
6. promo from "Promo Final.txt" appears to have donor id, date, and source which is same variables as appeal

### Variables in SAS files

| Variable name | Description | Files
|---------------|------------------------|----------------|
| id | Donor ID | appeal, donor, trans |
| source | Donor Zip Code | 
| amt | amount of gift | trans |
| giftdate | date of gift | trans |
| cost | ? | source |
| firstgift | date of first gift of donor | donor |
| appdate | appeal date | appeal |




[1]: The data set was provided by Marketing EDGE. The raw data can be purchased for academic and research purposes at [Marketing EDGE Data Set 7](http://www.marketingedge.org/marketing-programs/data-set-library). 