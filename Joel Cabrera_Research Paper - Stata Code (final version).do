// Joel Cabrera
// Advanced Cross-Sectional and Panel Data (01:220:401)
// Professor Piehl
// December 9, 2019

// 1. Preliminaries & Summary Statitics
// Packages
describe
// ssc install outreg2
// ssc install asdoc, replace // do "asdoc reg y x's" to obtain file with stars denoting statistical significance
des // checks variable names
// Note: When using asdoc, be sure to close doc every time to update asdoc file
// Configuring data & new variables
xtset code year // setting as panel data; code = country
generate lgdp = log(gdpgrowth) // Replaces negative values
gen laggdp = L.gdpgrowth
generate llaggdp = log(laggdp)
generate authoritarian = 0 if (democracyscale >= 6 & democracyscale ~=.)
replace authoritarian = 1 if democracyscale < 6
list authoritarian
// Table 1: Descriptive Statistics
asdoc summarize authoritarian code year llaggdp inflation capitalopenness realexchangerate popularlybasedgovernments percapitahealthandeducation percapitasocialexpenditures lgdp // can also add ", separator(4)" to separate rows by 4 in Stata
// Figure 1: Histogram
// twoway histogram year, discrete freq by(code, total) ***ignore, meant to produce graph containing multiple histograms, but was unable to add authoritarian to y-axis
twoway histogram year, discrete freq by(authoritarian) xlabel(1973(1)1997) ylabel(1(1)12)

// 2. Pooled OLS Regression (+ figures/tables) (stat. sign = F-test)
// Table 2a: Regression Models
asdoc reg lgdp authoritarian, robust // 1
asdoc reg lgdp authoritarian code year llaggdp, robust // 2
asdoc reg lgdp authoritarian code year llaggdp inflation capitalopenness realexchangerate, robust // 3
asdoc reg lgdp authoritarian code year llaggdp inflation capitalopenness realexchangerate popularlybasedgovernments percapitahealthandeducation percapitasocialexpenditures, robust // 4

// 3. Fixed Effects Regression (extremely useful to count for unbalanced panel) (+ figures/tables) (stat. sign = F-test) // llaggdp = dropped
// Table 3: Regression Models
asdoc reg lgdp authoritarian, robust // 1, no country or year FEs (no i.year or fe)
asdoc xtreg lgdp authoritarian i.year, fe // 2, country & year FEs (FE within regression) (both i.year and fe)
asdoc xtreg lgdp authoritarian, fe // 3, country FEs (no i.year, only fe), linear year
asdoc reg lgdp authoritarian i.year // 4, year FEs (no fe, only i.year)
asdoc xtreg lgdp authoritarian i.year inflation capitalopenness realexchangerate popularlybasedgovernments percapitahealthandeducation percapitasocialexpenditures, fe //5, country & year FEs (both i.year and fe)
// Figure 2: Residual plot of 2nd model
// 2 ways
/* 1st way
xtreg lgdp i.year, fe // get demeaned y
predict y_resfe, e
xtreg authoritarian i.year, fe // get demeaned x
predict x_resfe, e
scatter y_resfe x_resfe || lfit y_resfe x_resfe
*/
// 2nd way
reg lgdp authoritarian i.year i.code
avplot authoritarian, name(avplot1) 