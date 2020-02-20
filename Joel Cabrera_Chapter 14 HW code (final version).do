// Joel Cabrera
// Advanced Cross-Sectional and Panel Econometrics (01:220:401)
// Professor Piehl
// November 11, 2019

// C1.
// i.
bcuse rental
reg lrent y90 lpop lavginc pctstu //pooled OLS
// iii.
xtset city year, delta(10)
reg D.(lrent lpop lavginc pctstu y90)
// iv.
xtset city year, delta(10)
xtreg lrent lpop lavginc pctstu y90, fe

// C2.
// i.
pcuse crime4
xtset county year
xtreg crmrte d83 d84 d85 d86 d87 lprbarr lprbconv lprbpris lavgsen lpolpc, fe
// ii.
xtset county year
xtreg crmrte d83 d84 d85 d86 d87 lprbarr lprbconv lprbpris lavgsen lpolpc lwcon lwtuc lwtrd lwfir lwser lwmfg lwfed lwsta lwloc, fe

// C9.
// i.
bcuse pension
reg pctstck choice prftshr female age educ finc25 finc35 finc50 finc75 finc100 finc101 wealth89 stckin89 irain89
// iii.
tab id
preserve 
duplicates drop id, force
count
restore
// iv.
reg pctstck choice prftshr female age educ finc25 finc35 finc50 finc75 finc100 finc101 wealth89 stckin89 irain89, robust
// v.
// xtset city year
// reg D.(pctstck choice prftshr female age educ finc25 finc35 finc50 finc75 finc100 finc101 wealth89 stckin89 irain89)
local regressionvar "pctstck choice prftshr female age educ finc25 finc35 finc50 finc75 finc100 finc101 wealth89 stckin89 irain89"

drop if married != 1
quietly by id: gen id_dup = cond(_N == 1, 0, _n)
drop if id_dup == 0
foreach i of varlist `regressionvar'{
	quietly by id: gen d`i' = cond(id_dup == 2, `i' - `i'[_n - 1],.,.)
}
regress dpctstck dchoice dprftshr dfemale dage deduc dfinc25 dfinc35 dfinc50 dfinc75 dfinc100 dfinc101 dwealth89 dstckin89 dirain89

// C14.
// i.
bcuse airfare
xtset id year
quietly by id: gen id_dup = _n
count if id_dup == 1
summarize id
local regressionvar "y98 y99 y00 concen ldist ldistsq concenbar"
quietly by id: egen concenbar = mean(concen)
mean(concen)
summarize concen
// ii.
// xtreg lfare y98 y99 y00 concen ldist ldistsq concenbar, re //skip, as per //Professor Piehl's in-class instructions, since re is not covered
// iii.(Skip, as per Professor Piehl’s in-class instructions, since random effects is not covered).
// iv. (skip as well? also deals with re)
// v. (skip as well? again, also deals with re; based on C14iv.)