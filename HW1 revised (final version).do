*Joel Cabrera
*Advanced Cross-Sectional and Panel Econometrics (01:220:401)
*Professor Piehl
*September 29, 2019

#1. 

*"Short" equation
regress hlth age
*We hypothesize that age, having family size omitted, has an upward 
*bias alone. This is because, as age increases, family size will 
*also increase (e.g. a family may have many older and younger 
*siblings). Having a larger family would mean more relatives to 
*exert more social *pressure on you (e.g. do well in school, do 
*many extra-curriculars, etc.). This could, then, lead to high 
*stress levels, resulting in lower health values.

*"Long" equation
regress hlth age if famsize != .
regress age if famsize != .
regress hlth age if famsize != .
*The coefficient on age in the "short" equation is a (-) 
*The coefficient on famsize when age age is regressed on famsize is
*a (-) #. Thus, the sign of the omitted variable, famsize, is (+). 
*Due to this, the coefficient on age in the "short" equation is too 
*high, which was predicted by our hypothesis.

#2.

gen age_famsize = age*famsize 
#Q: shouldn't we use use if famsize != . variable instead?"
regress hlth age famsize age_famsize
*Interacting age and family size: the association between a change
*in age and a change in health depends on family size; conversely,
*the association between a change in family size and a change in 
*health depends on age. Performing the regression above, and, given 
*Stata's output of it, it seems that family size has a small effect 
*on how age affects health; family size increases this association 
*by a very small amount.

#3.

*Generating variable "seniorcitizen" based on the age variable
gen seniorcitizen = 0
replace seniorcitizen = 1 if age >= 60

*Testing new variable
regress hlth famsize if seniorcitizen == 1

#4.
*Splitting "seniorcitizen" variable
regress hlth famsize seniorcitizen if seniorcitizen != .
regress hlth famsize seniorcitizen if seniorcitizen == 0
regress hlth famsize seniorcitizen if seniorcitizen == 1
*As shown by the Stata output, the "seniorcitizen" variable - the 
*dummy variable, is predictably omitted. This is a result of Stata's
*programmed ability to account for multicollinerity. Another result 
*to consider is that people over the age of 60 (when seniorcitizen 
*== 1) has a negative coefficient on family size. 