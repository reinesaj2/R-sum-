#!/bin/bash -f

### wind_v6_19b.sh
### This script calls for xstar
### author: Keigo Fukumura
### help from T. Sakamoto, J. Garcia, D. Kazanas, T. Kallman
### ---------------------------------------------------------
### last updated 8/11/2017

###--- boundary conditions ---###

logxi0=7.44907
xi30=28123.5
Cf=0.

#redz=2.9
#alpha=-1.5
###############################################

### compile integral.f
#g77 integral.f -o integral.x

### remove pre-existing slab-spec files
find . -type f -name "slab_spec_*.txt" -exec rm -f {} \;
find . -type f -name "slab_spec_*.fits" -exec rm -f {} \;

rm -f abund2.txt
rm -f c_state2.txt
rm -f o_state2.txt
rm -f ne_state2.txt
rm -f mg_state2.txt
rm -f si_state2.txt
rm -f s_state2.txt
rm -f ar_state2.txt
rm -f ca_state2.txt
rm -f cr_state2.txt
rm -f mn_state2.txt
rm -f fe_state2.txt

# For Mac OS; use "echo '2.34*10^3*4.56*10^2' | bc -l" notation

filename=$1
nl=`wc -l $filename | awk '{print $1}'`
###nl=`wc -l table1.txt | awk '{print $1}'`

### 1st slab (outside while loop)

num=1
dist0=`awk '{if (NR == '$num') print $2}' $filename`
den=`awk '{if (NR == '$num') print $3}' $filename`
col=`awk '{if (NR == '$num') print $4}' $filename`
vi0=`awk '{if (NR == '$num') print $5}' $filename`
lineblueshift0=`awk '{if (NR == '$num') print $9}' $filename`
vturb0=`awk '{if (NR == '$num') print $6}' $filename`

#vturb00=$(echo "$vturb0*(3*(10^5))" | bc -l) 
vturb00=$(echo "$vturb0*(3*(10^5))" | sed 's/e/\*10\^/' | sed 's/+//' | bc -l)

dist14b=$(echo "$dist0/(10^14)" | sed 's/e/\*10\^/' | sed 's/+//' | bc -l)
den7b=$(echo "$den/(10^7)" | sed 's/e/\*10\^/' | sed 's/+//' | bc -l)
col20b=$(echo "$col/(10^20)" | sed 's/e/\*10\^/' | sed 's/+//' | bc -l)
deltaR13=$(echo "$col20b/$den7b" | bc -l)

L38ini=$(echo "$den7b*($dist14b^2)*($xi30)" | bc -l)

echo "("$num") Distance = "$dist0", Density = " $den ", Column = " $col
echo "    Luminosity (in units of 10^38 erg/sec) = " $L38ini 
echo "blueshift = "$lineblueshift0", vturb = " $vturb0", vi = " $vi0
echo "vturb00="$vturb00

abundfact=1.0

xstar cfrac="$Cf"  trad=0. temperature=400. pressure=0.03 density="$den" spectrum='file' rlrad38="$L38ini" column="$col" rlogxi="$logxi0" lcpres=0.0 habund=$abundfact heabund=$abundfact liabund=0.0 beabund=0.0 babund=0.0 cabund=$abundfact nabund=$abundfact oabund=$abundfact fabund=0.0 neabund=$abundfact naabund=0.0 mgabund=$abundfact alabund=$abundfact siabund=$abundfact pabund=0.0 sabund=$abundfact clabund=0.0 arabund=$abundfact kabund=0.0 caabund=$abundfact scabund=0.0 tiabund=0.0 vabund=0.0 crabund=$abundfact mnabund=$abundfact feabund=$abundfact coabund=$abundfact niabund=$abundfact cuabund=0.0 znabund=0.0 modelname="slab_spec_"$num""  vturbi="$vturb00" spectrum_file="SpectrumFile_G_2.A_-2.5.txt" spectun=0. 


mv xout_spect1.fits slab_spec_"$num".fits
cp -f xout_step.log prev.log
date > prev.log


### extract xstar's calculated spectral components

echo 9999 > slab_spec_"$num".txt
ftlist slab_spec_"$num".fits T columns="energy,incident,transmitted,emit_outward" rownum=no colheader=no >> slab_spec_"$num".txt


### read xstar's abundance table and compute total densities for each species
### with column_sum.sh
### n_H(ion) will be written into each element's txt file 

#echo "total ionic column density..."

ftlist xout_abund1.fits+2 T columns="h_*" rownum=no colheader=no > h.txt
ftlist xout_abund1.fits+2 T columns="he_*" rownum=no colheader=no > he.txt
ftlist xout_abund1.fits+2 T columns="c_*" rownum=no colheader=no > c.txt
ftlist xout_abund1.fits+2 T columns="n_*" rownum=no colheader=no > n.txt
ftlist xout_abund1.fits+2 T columns="o_*" rownum=no colheader=no > o.txt
ftlist xout_abund1.fits+2 T columns="ne_*" rownum=no colheader=no > ne.txt
ftlist xout_abund1.fits+2 T columns="mg_*" rownum=no colheader=no > mg.txt
ftlist xout_abund1.fits+2 T columns="si_*" rownum=no colheader=no > si.txt
ftlist xout_abund1.fits+2 T columns="s_*" rownum=no colheader=no > s.txt
ftlist xout_abund1.fits+2 T columns="ar_*" rownum=no colheader=no > ar.txt
ftlist xout_abund1.fits+2 T columns="ca_*" rownum=no colheader=no > ca.txt
ftlist xout_abund1.fits+2 T columns="cr_*" rownum=no colheader=no > cr.txt
ftlist xout_abund1.fits+2 T columns="mn_*" rownum=no colheader=no > mn.txt
ftlist xout_abund1.fits+2 T columns="fe_*" rownum=no colheader=no > fe.txt


sum_h=`./column_sum.sh h.txt | tail -1`
sum_he=`./column_sum.sh he.txt | tail -1`
sum_c=`./column_sum.sh c.txt | tail -1`
sum_n=`./column_sum.sh n.txt | tail -1`
sum_o=`./column_sum.sh o.txt | tail -1`
sum_ne=`./column_sum.sh ne.txt | tail -1`
sum_mg=`./column_sum.sh mg.txt | tail -1`
sum_si=`./column_sum.sh si.txt | tail -1`
sum_s=`./column_sum.sh s.txt | tail -1`
sum_ar=`./column_sum.sh ar.txt | tail -1`
sum_ca=`./column_sum.sh ca.txt | tail -1`
sum_cr=`./column_sum.sh cr.txt | tail -1`
sum_mn=`./column_sum.sh mn.txt | tail -1`
sum_fe=`./column_sum.sh fe.txt | tail -1`

#echo "H:"$sum_h "He:"$sum_he "C:"$sum_c "O:"$sum_o "Ca:"$sum_ca "Fe:"$sum_fe 
#echo "$num H:$sum_h He:$sum_he C:$sum_c O:$sum_o Ca:$sum_ca Fe:$sum_fe" > abund#1.txt

### keep track with each ionization state

#ftlist xout_abund1.fits+2 T columns="radius,fe_*" rownum=no colheader=no > fe_state.txt


### compute corresponding average temperature with aveT.sh
temp=$(./aveT.sh xout_step.log)

### compute corresponding average dist. with aveR.sh
logR=$(./aveR.sh xout_step.log)


### compute hardness ratio (HR)
HR=$(./integral.x < slab_spec_"$num".txt | awk '{print $4}' | xargs echo)


### compute corresponding average log(xi) with avexi.sh
avelogxi=$(./avexi.sh xout_step.log)


# nitrogen/N
ftlist xout_abund1.fits+2 T columns="n_*" rownum=no colheader=no | awk '{print '$logxi0', $0, '$vi0', '$logR', '$vturb0', '$temp'}' > n_state1.txt

# carbon/C
ftlist xout_abund1.fits+2 T columns="c_*" rownum=no colheader=no | awk '{print '$logxi0', $0, '$vi0', '$logR', '$vturb0', '$temp'}' > c_state1.txt


# oxygen/O
ftlist xout_abund1.fits+2 T columns="o_*" rownum=no colheader=no | awk '{print '$logxi0', $0, '$vi0','$logR', '$vturb0', '$temp'}' > o_state1.txt

# neon/Ne
ftlist xout_abund1.fits+2 T columns="ne_*" rownum=no colheader=no | awk '{print '$logxi0', $0, '$vi0', '$logR', '$vturb0', '$temp'}' > ne_state1.txt

# magnesium/Mg
ftlist xout_abund1.fits+2 T columns="mg_*" rownum=no colheader=no | awk '{print '$logxi0', $0, '$vi0', '$logR', '$vturb0', '$temp'}' > mg_state1.txt

# silicon/Si
ftlist xout_abund1.fits+2 T columns="si_*" rownum=no colheader=no | awk '{print '$logxi0', $0, '$vi0', '$logR', '$vturb0', '$temp'}' > si_state1.txt

# sulpher/S
ftlist xout_abund1.fits+2 T columns="s_*" rownum=no colheader=no | awk '{print '$logxi0', $0, '$vi0', '$logR', '$vturb0', '$temp'}' > s_state1.txt

# argon/Ar
ftlist xout_abund1.fits+2 T columns="ar_*" rownum=no colheader=no | awk '{print '$logxi0', $0, '$vi0', '$logR', '$vturb0', '$temp'}' > ar_state1.txt

# calcium/Ca
ftlist xout_abund1.fits+2 T columns="ca_*" rownum=no colheader=no | awk '{print '$logxi0', $0, '$vi0', '$logR', '$vturb0', '$temp'}' > ca_state1.txt

# chormium/Cr
ftlist xout_abund1.fits+2 T columns="cr_*" rownum=no colheader=no | awk '{print '$logxi0', $0, '$vi0', '$logR', '$vturb0', '$temp'}' > cr_state1.txt

# mangan/Mn
ftlist xout_abund1.fits+2 T columns="mn_*" rownum=no colheader=no | awk '{print '$logxi0', $0, '$vi0', '$logR', '$vturb0', '$temp'}' > mn_state1.txt

# iron/Fe
ftlist xout_abund1.fits+2 T columns="fe_*" rownum=no colheader=no | awk '{print '$logxi0', $0, '$vi0', '$logR', '$vturb0', '$temp'}' > fe_state1.txt


# grab elementary abundance relative H [Z/H]
abd_He=$((./IonAbund.sh xout_step.log) | awk '{print $1}')
abd_N=$((./IonAbund.sh xout_step.log) | awk '{print $2}')
abd_C=$((./IonAbund.sh xout_step.log) | awk '{print $3}')
abd_O=$((./IonAbund.sh xout_step.log) | awk '{print $4}')
abd_Ne=$((./IonAbund.sh xout_step.log) | awk '{print $5}')
abd_Mg=$((./IonAbund.sh xout_step.log) | awk '{print $6}')
abd_Si=$((./IonAbund.sh xout_step.log) | awk '{print $7}')
abd_S=$((./IonAbund.sh xout_step.log) | awk '{print $8}')
abd_Ar=$((./IonAbund.sh xout_step.log) | awk '{print $9}')
abd_Ca=$((./IonAbund.sh xout_step.log) | awk '{print $10}')
abd_Cr=$((./IonAbund.sh xout_step.log) | awk '{print $11}')
abd_Mn=$((./IonAbund.sh xout_step.log) | awk '{print $12}')
abd_Fe=$((./IonAbund.sh xout_step.log) | awk '{print $13}')

# convert to equivalent-H abundances

# N
awk '{print $1, $2/('$abd_N'), $3/('$abd_N'), $4/('$abd_N'), $5/('$abd_N'), $6/('$abd_N'), $7/('$abd_N'), $8/('$abd_N'), $9, $10, $11}' n_state1.txt > n_state2.txt

# C
awk '{print $1, $2/('$abd_C'), $3/('$abd_C'), $4/('$abd_C'), $5/('$abd_C'), $6/('$abd_C'), $7/('$abd_C'), $8, $9, $10}' c_state1.txt > c_state2.txt

# O
awk '{print $1, $2/('$abd_O'), $3/('$abd_O'), $4/('$abd_O'), $5/('$abd_O'), $6/('$abd_O'), $7/('$abd_O'), $8/('$abd_O'), $9/('$abd_O'), $10, $11, $12}' o_state1.txt > o_state2.txt

# Ne
awk '{print $1, $2/('$abd_Ne'), $3/('$abd_Ne'), $4/('$abd_Ne'), $5/('$abd_Ne'), $6/('$abd_Ne'), $7/('$abd_Ne'), $8/('$abd_Ne'), $9/('$abd_Ne'), $10/('$abd_Ne'), $11/('$abd_Ne'), $12, $13, $14}' ne_state1.txt > ne_state2.txt

# Mg
awk '{print $1, $2/('$abd_Mg'), $3/('$abd_Mg'), $4/('$abd_Mg'), $5/('$abd_Mg'), $6/('$abd_Mg'), $7/('$abd_Mg'), $8/('$abd_Mg'), $9/('$abd_Mg'), $10/('$abd_Mg'), $11/('$abd_Mg'), $12/('$abd_Mg'), $13/('$abd_Mg'), $14, $15, $16}' mg_state1.txt > mg_state2.txt

# Si
awk '{print $1, $2/('$abd_Si'), $3/('$abd_Si'), $4/('$abd_Si'), $5/('$abd_Si'), $6/('$abd_Si'), $7/('$abd_Si'), $8/('$abd_Si'), $9/('$abd_Si'), $10/('$abd_Si'), $11/('$abd_Si'), $12/('$abd_Si'), $13/('$abd_Si'), $14/('$abd_Si'), $15/('$abd_Si'), $16, $17, $18}' si_state1.txt > si_state2.txt

# S
awk '{print $1, $2/('$abd_S'), $3/('$abd_S'), $4/('$abd_S'), $5/('$abd_S'), $6/('$abd_S'), $7/('$abd_S'), $8/('$abd_S'), $9/('$abd_S'), $10/('$abd_S'), $11/('$abd_S'), $12/('$abd_S'), $13/('$abd_S'), $14/('$abd_S'), $15/('$abd_S'), $16/('$abd_S'), $17/('$abd_S'), $18, $19, $20}' s_state1.txt > s_state2.txt

# Ar
awk '{print $1, $2/('$abd_Ar'), $3/('$abd_Ar'), $4/('$abd_Ar'), $5/('$abd_Ar'), $6/('$abd_Ar'), $7/('$abd_Ar'), $8/('$abd_Ar'), $9/('$abd_Ar'), $10/('$abd_Ar'), $11/('$abd_Ar'), $12/('$abd_Ar'), $13/('$abd_Ar'), $14/('$abd_Ar'), $15/('$abd_Ar'), $16/('$abd_Ar'), $17/('$abd_Ar'), $18/('$abd_Ar'), $19/('$abd_Ar'), $20, $21, $22}' ar_state1.txt > ar_state2.txt

# Ca
awk '{print $1, $2/('$abd_Ca'), $3/('$abd_Ca'), $4/('$abd_Ca'), $5/('$abd_Ca'), $6/('$abd_Ca'), $7/('$abd_Ca'), $8/('$abd_Ca'), $9/('$abd_Ca'), $10/('$abd_Ca'), $11/('$abd_Ca'), $12/('$abd_Ca'), $13/('$abd_Ca'), $14/('$abd_Ca'), $15/('$abd_Ca'), $16/('$abd_Ca'), $17/('$abd_Ca'), $18/('$abd_Ca'), $19/('$abd_Ca'), $20/('$abd_Ca'), $21/('$abd_Ca'), $22, $23, $24}' ca_state1.txt > ca_state2.txt

# Cr
awk '{print $1, $2/('$abd_Cr'), $3/('$abd_Cr'), $4/('$abd_Cr'), $5/('$abd_Cr'), $6/('$abd_Cr'), $7/('$abd_Cr'), $8/('$abd_Cr'), $9/('$abd_Cr'), $10/('$abd_Cr'), $11/('$abd_Cr'), $12/('$abd_Cr'), $13/('$abd_Cr'), $14/('$abd_Cr'), $15/('$abd_Cr'), $16/('$abd_Cr'), $17/('$abd_Cr'), $18/('$abd_Cr'), $19/('$abd_Cr'), $20/('$abd_Cr'), $21/('$abd_Cr'), $22/('$abd_Cr'), $23/('$abd_Cr'), $24/('$abd_Cr'), $25/('$abd_Cr'), $26, $27, $28}' cr_state1.txt > cr_state2.txt

# Mn
awk '{print $1, $2/('$abd_Mn'), $3/('$abd_Mn'), $4/('$abd_Mn'), $5/('$abd_Mn'), $6/('$abd_Mn'), $7/('$abd_Mn'), $8/('$abd_Mn'), $9/('$abd_Mn'), $10/('$abd_Mn'), $11/('$abd_Mn'), $12/('$abd_Mn'), $13/('$abd_Mn'), $14/('$abd_Mn'), $15/('$abd_Mn'), $16/('$abd_Mn'), $17/('$abd_Mn'), $18/('$abd_Mn'), $19/('$abd_Mn'), $20/('$abd_Mn'), $21/('$abd_Mn'), $22/('$abd_Mn'), $23/('$abd_Mn'), $24/('$abd_Mn'), $25/('$abd_Mn'), $26/('$abd_Mn'), $27, $28, $29}' mn_state1.txt > mn_state2.txt

# Fe
awk '{print $1, $2/('$abd_Fe'), $3/('$abd_Fe'), $4/('$abd_Fe'), $5/('$abd_Fe'), $6/('$abd_Fe'), $7/('$abd_Fe'), $8/('$abd_Fe'), $9/('$abd_Fe'), $10/('$abd_Fe'), $11/('$abd_Fe'), $12/('$abd_Fe'), $13/('$abd_Fe'), $14/('$abd_Fe'), $15/('$abd_Fe'), $16/('$abd_Fe'), $17/('$abd_Fe'), $18/('$abd_Fe'), $19/('$abd_Fe'), $20/('$abd_Fe'), $21/('$abd_Fe'), $22/('$abd_Fe'), $23/('$abd_Fe'), $24/('$abd_Fe'), $25/('$abd_Fe'), $26/('$abd_Fe'), $27/('$abd_Fe'), $28, $29, $30, '$temp'}' fe_state1.txt > fe_state2.txt

# saving ionic columns
#./calc_tau_experimental.sh | awk '{print $0, '$avelogxi', '$vi0', '$logR', '$vturb0', '$temp'}' > line_tau.txt

./calc_tau_xstar_2017.sh | awk '{print $0, '$avelogxi', '$vi0', '$logR', '$vturb0', '$temp'}' > line_tau.txt

#echo > line_tau0.txt
#optical_depth=$(./calc_tau_experimental.sh)
#awk '{print $0, '$optical_depth'}' line_tau0.txt > line_tau.txt

#echo $optical_depth
#awk '{print $optical_depth}' > line_tau.txt
#./calc_tau.sh | awk '{print $0}' > line_tau.txt


### write log[T](ave), log(xi) and n_H(ion) into abund1.txt

rm -f abund1.txt

echo $num $logR $temp $logxi0 $sum_h $sum_he $sum_c $sum_n $sum_o $sum_ne $sum_mg $sum_si $sum_s $sum_ar $sum_ca $sum_cr $sum_mn $sum_fe $vi0 $L38ini > abund1.txt

# correct to elementary abundances

awk '{print $1, $2, $3, $4, $5/(1.0), $6/('$abd_He'), $7/('$abd_C'), $8/('$abd_N'), $9/('$abd_O'), $10/('$abd_Ne'), $11/('$abd_Mg'), $12/('$abd_Si'), $13/('$abd_S'), $14/('$abd_Ar'), $15/('$abd_Ca'), $16/('$abd_Cr'), $17/('$abd_Mn'), $18/('$abd_Fe'), $19, $20}' abund1.txt > abund2.txt


## find line luminosity [erg/sec] for Halpha and Hbeta
#lineL0=$(./LineLuminosity.sh xout_step.log)

#echo "hi 1"

# find line emissivity in [erg/sec/cm^3]
#line_para0a=$(./do_line.sh xout_detal2.fits)


# find line luminosity in [erg/sec/10**38] & optical depth
line_para0b=$(./do_line2.sh xout_lines1.fits)

# find continuum optical depth over energy 
#./depth.sh

#echo $num $logR $logxi0 $line_para0a $line_para0b $L38ini $temp > ems_list.txt


############################################
### from 2nd slab on (entering while loop)
############################################

num=2

dist=$dist0
distb=$(echo "$dist" | sed 's/e/\*10\^/' | sed 's/+//' | bc -l)

while (( $num <= $nl ))
do

prevnum=$(echo "$num-1" | bc -l)

den=`awk 'NR == '$num' {print $3}' $filename`
col=`awk 'NR == '$num' {print $4}' $filename`
vi=`awk 'NR == '$num' {print $5}' $filename`
lineblueshift=`awk '{if (NR == '$prevnum') print $9}' $filename`
#kcorrect=`awk 'NR == '$prevnum' {print $8}' $filename`
vturb=`awk '{if (NR == '$num') print $6}' $filename`
#vturb=600
#lineblueshift=1
kcorrect=1

vturb1a=$(echo "$vturb" | sed 's/e/\*10\^/' | sed 's/+//' | bc -l)
vturb1=$(echo "$vturb1a*(3*(10^5))" | bc -l)

### update luminosity (in units of 10**38) for next calculation with xstar

rm -f specfile0.txt

# lum38=$(./integral.x < slab_spec_"$prevnum".txt | xargs echo)
lum38=$(./integral.x < slab_spec_"$prevnum".txt | awk '{print $1}' | xargs echo)
# lum38new=$(echo "$lum38*$kcorrect" | bc -l)

lum38new=$(echo "$lum38*$kcorrect" | sed -e 's/[eE]+*/\*10\^/' | bc -l)

### compute hardness ratio (HR)
HR=$(./integral.x < slab_spec_"$prevnum".txt | awk '{print $4}' | xargs echo)

### generate a new input file for total spectrum to be used next

rm -f specfile.txt
echo "9999" > specfile.txt
awk 'NR>1 {print $1*'$lineblueshift', $2*'$kcorrect'}' specfile0.txt >> specfile.txt
#awk 'NR>1 {print $1, $2/(4*3.14159*(($distb)**2))}' specfile0.txt >> specfile.txt`

#echo "lum38new=" $lum38new 


### conversion of expression for "bc"

lum38b=$(echo "$lum38new" | sed 's/e/\*10\^/' | sed 's/+//' | bc -l)
den7b=$(echo "$den/(10^7)" | sed 's/e/\*10\^/' | sed 's/+//' | bc -l)
col20b=$(echo "$col/(10^20)" | sed 's/e/\*10\^/' | sed 's/+//' | bc -l)

newdist=$(echo "($distb+$deltaR13*(10^13))" | bc -l)
dist14=$(echo "$newdist/(10^14)" | bc -l)
xi3=$(echo "$lum38b/$den7b/$dist14^2" | bc -l)
#newdist=$(echo "sqrt($lum38b/$den7b/$xi3)*(10^14)+$deltaR13*10^13" | bc -l)
logxi=$(echo "3.+l($xi3)/l(10.0)" | bc -l)
deltaR13=$(echo "$col20b/$den7b" | bc -l)


echo "("$num") Distance = "$newdist", Density = " $den ", Column = " $col
echo "    Luminosity (in units of 10^38 erg/sec) = " $lum38new 
echo "blueshift = "$lineblueshift", vturb = " $vturb ", vi = " $vi
echo "vturb1 = " $vturb1 ", Cf = " $Cf 

#echo "Cf="$Cf 
#echo "den="$den 
#echo "lum38new="$lum38new
#echo "col="$col 
#echo "logxi="$logxi
#echo "num="$num
#echo "vturb1="$vturb1


xstar cfrac="$Cf"  temperature=400.0 pressure=0.03 density="$den" spectrum='file' trad=0. spectun=0. spectrum_file="specfile.txt"  rlrad38="$lum38new"  column="$col" rlogxi="$logxi" lcpres=0. habund=$abundfact heabund=$abundfact liabund=0.0 beabund=0.0 babund=0.0 cabund=$abundfact nabund=$abundfact oabund=$abundfact fabund=0.0 neabund=$abundfact naabund=0.0 mgabund=$abundfact alabund=$abundfact siabund=$abundfact pabund=0.0 sabund=$abundfact clabund=0.0 arabund=$abundfact kabund=0.0 caabund=$abundfact scabund=0.0 tiabund=0.0 vabund=0.0 crabund=$abundfact mnabund=$abundfact feabund=$abundfact coabund=$abundfact niabund=$abundfact cuabund=0.0 znabund=0.0 modelname="slab_spec_"$num""  vturbi="$vturb1" 

mv xout_spect1.fits slab_spec_"$num".fits
#cp xout_detal2.fits pseudo.fits


### read xstar's abundance table and compute total densities for each species

#echo "total ionic column density..."

ftlist xout_abund1.fits+2 T columns="h_*" rownum=no colheader=no > h.txt
ftlist xout_abund1.fits+2 T columns="he_*" rownum=no colheader=no > he.txt
ftlist xout_abund1.fits+2 T columns="c_*" rownum=no colheader=no > c.txt
ftlist xout_abund1.fits+2 T columns="n_*" rownum=no colheader=no > n.txt
ftlist xout_abund1.fits+2 T columns="o_*" rownum=no colheader=no > o.txt
ftlist xout_abund1.fits+2 T columns="ne_*" rownum=no colheader=no > ne.txt
ftlist xout_abund1.fits+2 T columns="mg_*" rownum=no colheader=no > mg.txt
ftlist xout_abund1.fits+2 T columns="si_*" rownum=no colheader=no > si.txt
ftlist xout_abund1.fits+2 T columns="s_*" rownum=no colheader=no > s.txt
ftlist xout_abund1.fits+2 T columns="ar_*" rownum=no colheader=no > ar.txt
ftlist xout_abund1.fits+2 T columns="ca_*" rownum=no colheader=no > ca.txt
ftlist xout_abund1.fits+2 T columns="cr_*" rownum=no colheader=no > cr.txt
ftlist xout_abund1.fits+2 T columns="mn_*" rownum=no colheader=no > mn.txt
ftlist xout_abund1.fits+2 T columns="fe_*" rownum=no colheader=no > fe.txt

sum_h=`./column_sum.sh h.txt | tail -1`
sum_he=`./column_sum.sh he.txt | tail -1`
sum_c=`./column_sum.sh c.txt | tail -1`
sum_n=`./column_sum.sh n.txt | tail -1`
sum_o=`./column_sum.sh o.txt | tail -1`
sum_ne=`./column_sum.sh ne.txt | tail -1`
sum_mg=`./column_sum.sh mg.txt | tail -1`
sum_si=`./column_sum.sh si.txt | tail -1`
sum_s=`./column_sum.sh s.txt | tail -1`
sum_ar=`./column_sum.sh ar.txt | tail -1`
sum_ca=`./column_sum.sh ca.txt | tail -1`
sum_cr=`./column_sum.sh cr.txt | tail -1`
sum_mn=`./column_sum.sh mn.txt | tail -1`
sum_fe=`./column_sum.sh fe.txt | tail -1`

#echo "H:"$sum_h "He:"$sum_he "C:"$sum_c "O:"$sum_o "Ca:"$sum_ca "Fe:"$sum_fe 

### compute corresponding average temperature with aveT.sh
temp=$(./aveT.sh xout_step.log)

### compute corresponding average log(xi) with avexi.sh
avelogxi=$(./avexi.sh xout_step.log)

### compute corresponding average dist. with aveR.sh
logR=$(./aveR.sh xout_step.log)


# saving ionic columns
#./calc_tau_experimental.sh | awk '{print $0, '$avelogxi', '$vi', '$logR', '$vturb', '$temp'}' >> line_tau.txt

./calc_tau_xstar_2017.sh | awk '{print $0, '$avelogxi', '$vi0', '$logR', '$vturb0', '$temp'}' > line_tau.txt

### update fe.txt

#ftlist xout_abund1.fits+2 T columns="radius,fe_*" rownum=no colheader=no >> fe_#state.txt

ftlist xout_abund1.fits+2 T columns="n_*" rownum=no colheader=no | awk '{print '$avelogxi', $0, '$vi', '$logR', '$vturb'}' > n_tmp1.txt

ftlist xout_abund1.fits+2 T columns="c_*" rownum=no colheader=no | awk '{print '$avelogxi', $0, '$vi', '$logR', '$vturb'}' > c_tmp1.txt

ftlist xout_abund1.fits+2 T columns="o_*" rownum=no colheader=no | awk '{print '$avelogxi', $0, '$vi','$logR', '$vturb'}'  > o_tmp1.txt

ftlist xout_abund1.fits+2 T columns="ne_*" rownum=no colheader=no | awk '{print '$avelogxi', $0, '$vi', '$logR', '$vturb'}' > ne_tmp1.txt

ftlist xout_abund1.fits+2 T columns="mg_*" rownum=no colheader=no | awk '{print '$avelogxi', $0, '$vi', '$logR', '$vturb'}' > mg_tmp1.txt

ftlist xout_abund1.fits+2 T columns="si_*" rownum=no colheader=no | awk '{print '$avelogxi', $0, '$vi', '$logR', '$vturb'}' > si_tmp1.txt

ftlist xout_abund1.fits+2 T columns="s_*" rownum=no colheader=no | awk '{print '$avelogxi', $0, '$vi', '$logR', '$vturb'}' > s_tmp1.txt

ftlist xout_abund1.fits+2 T columns="ar_*" rownum=no colheader=no | awk '{print '$avelogxi', $0, '$vi', '$logR', '$vturb'}' > ar_tmp1.txt

ftlist xout_abund1.fits+2 T columns="ca_*" rownum=no colheader=no | awk '{print '$avelogxi', $0, '$vi', '$logR', '$vturb'}' > ca_tmp1.txt

ftlist xout_abund1.fits+2 T columns="cr_*" rownum=no colheader=no | awk '{print '$avelogxi', $0, '$vi', '$logR', '$vturb'}' > cr_tmp1.txt

ftlist xout_abund1.fits+2 T columns="mn_*" rownum=no colheader=no | awk '{print '$avelogxi', $0, '$vi', '$logR', '$vturb'}' > mn_tmp1.txt

ftlist xout_abund1.fits+2 T columns="fe_*" rownum=no colheader=no | awk '{print '$avelogxi', $0, '$vi','$logR','$vturb'}' > fe_tmp1.txt


# convert to hydrogen-equivalent abundances

# N
awk '{print $1, $2/('$abd_N'), $3/('$abd_N'), $4/('$abd_N'), $5/('$abd_N'), $6/('$abd_N'), $7/('$abd_N'), $8/('$abd_N'), $9, $10, $11, '$temp'}' n_tmp1.txt >> n_state2.txt

# C
awk '{print $1, $2/('$abd_C'), $3/('$abd_C'), $4/('$abd_C'), $5/('$abd_C'), $6/('$abd_C'), $7/('$abd_C'), $8, $9, $10, '$temp'}' c_tmp1.txt >> c_state2.txt

# O
awk '{print $1, $2/('$abd_O'), $3/('$abd_O'), $4/('$abd_O'), $5/('$abd_O'), $6/('$abd_O'), $7/('$abd_O'), $8/('$abd_O'), $9/('$abd_O'), $10, $11, $12, '$temp'}' o_tmp1.txt >> o_state2.txt

# Ne
awk '{print $1, $2/('$abd_Ne'), $3/('$abd_Ne'), $4/('$abd_Ne'), $5/('$abd_Ne'), $6/('$abd_Ne'), $7/('$abd_Ne'), $8/('$abd_Ne'), $9/('$abd_Ne'), $10/('$abd_Ne'), $11/('$abd_Ne'), $12, $13, $14, '$temp'}' ne_tmp1.txt >> ne_state2.txt

# Mg
awk '{print $1, $2/('$abd_Mg'), $3/('$abd_Mg'), $4/('$abd_Mg'), $5/('$abd_Mg'), $6/('$abd_Mg'), $7/('$abd_Mg'), $8/('$abd_Mg'), $9/('$abd_Mg'), $10/('$abd_Mg'), $11/('$abd_Mg'), $12/('$abd_Mg'), $13/('$abd_Mg'), $14, $15, $16, '$temp'}' mg_tmp1.txt >> mg_state2.txt

# Si
awk '{print $1, $2/('$abd_Si'), $3/('$abd_Si'), $4/('$abd_Si'), $5/('$abd_Si'), $6/('$abd_Si'), $7/('$abd_Si'), $8/('$abd_Si'), $9/('$abd_Si'), $10/('$abd_Si'), $11/('$abd_Si'), $12/('$abd_Si'), $13/('$abd_Si'), $14/('$abd_Si'), $15/('$abd_Si'), $16, $17, $18, '$temp'}' si_tmp1.txt >> si_state2.txt

# S
awk '{print $1, $2/('$abd_S'), $3/('$abd_S'), $4/('$abd_S'), $5/('$abd_S'), $6/('$abd_S'), $7/('$abd_S'), $8/('$abd_S'), $9/('$abd_S'), $10/('$abd_S'), $11/('$abd_S'), $12/('$abd_S'), $13/('$abd_S'), $14/('$abd_S'), $15/('$abd_S'), $16/('$abd_S'), $17/('$abd_S'), $18, $19, $20, '$temp'}' s_tmp1.txt >> s_state2.txt

# Ar
awk '{print $1, $2/('$abd_Ar'), $3/('$abd_Ar'), $4/('$abd_Ar'), $5/('$abd_Ar'), $6/('$abd_Ar'), $7/('$abd_Ar'), $8/('$abd_Ar'), $9/('$abd_Ar'), $10/('$abd_Ar'), $11/('$abd_Ar'), $12/('$abd_Ar'), $13/('$abd_Ar'), $14/('$abd_Ar'), $15/('$abd_Ar'), $16/('$abd_Ar'), $17/('$abd_Ar'), $18/('$abd_Ar'), $19/('$abd_Ar'), $20, $21, $22, '$temp'}' ar_tmp1.txt >> ar_state2.txt

# Ca
awk '{print $1, $2/('$abd_Ca'), $3/('$abd_Ca'), $4/('$abd_Ca'), $5/('$abd_Ca'), $6/('$abd_Ca'), $7/('$abd_Ca'), $8/('$abd_Ca'), $9/('$abd_Ca'), $10/('$abd_Ca'), $11/('$abd_Ca'), $12/('$abd_Ca'), $13/('$abd_Ca'), $14/('$abd_Ca'), $15/('$abd_Ca'), $16/('$abd_Ca'), $17/('$abd_Ca'), $18/('$abd_Ca'), $19/('$abd_Ca'), $20/('$abd_Ca'), $21/('$abd_Ca'), $22, $23, $24, '$temp'}' ca_tmp1.txt >> ca_state2.txt

# Cr
awk '{print $1, $2/('$abd_Cr'), $3/('$abd_Cr'), $4/('$abd_Cr'), $5/('$abd_Cr'), $6/('$abd_Cr'), $7/('$abd_Cr'), $8/('$abd_Cr'), $9/('$abd_Cr'), $10/('$abd_Cr'), $11/('$abd_Cr'), $12/('$abd_Cr'), $13/('$abd_Cr'), $14/('$abd_Cr'), $15/('$abd_Cr'), $16/('$abd_Cr'), $17/('$abd_Cr'), $18/('$abd_Cr'), $19/('$abd_Cr'), $20/('$abd_Cr'), $21/('$abd_Cr'), $22/('$abd_Cr'), $23/('$abd_Cr'), $24/('$abd_Cr'), $25/('$abd_Cr'), $26, $27, $28, '$temp'}' cr_tmp1.txt >> cr_state2.txt

# Mn
awk '{print $1, $2/('$abd_Mn'), $3/('$abd_Mn'), $4/('$abd_Mn'), $5/('$abd_Mn'), $6/('$abd_Mn'), $7/('$abd_Mn'), $8/('$abd_Mn'), $9/('$abd_Mn'), $10/('$abd_Mn'), $11/('$abd_Mn'), $12/('$abd_Mn'), $13/('$abd_Mn'), $14/('$abd_Mn'), $15/('$abd_Mn'), $16/('$abd_Mn'), $17/('$abd_Mn'), $18/('$abd_Mn'), $19/('$abd_Mn'), $20/('$abd_Mn'), $21/('$abd_Mn'), $22/('$abd_Mn'), $23/('$abd_Mn'), $24/('$abd_Mn'), $25/('$abd_Mn'), $26/('$abd_Mn'), $27, $28, $29, '$temp'}' mn_tmp1.txt >> mn_state2.txt

# Fe
awk '{print $1, $2/('$abd_Fe'), $3/('$abd_Fe'), $4/('$abd_Fe'), $5/('$abd_Fe'), $6/('$abd_Fe'), $7/('$abd_Fe'), $8/('$abd_Fe'), $9/('$abd_Fe'), $10/('$abd_Fe'), $11/('$abd_Fe'), $12/('$abd_Fe'), $13/('$abd_Fe'), $14/('$abd_Fe'), $15/('$abd_Fe'), $16/('$abd_Fe'), $17/('$abd_Fe'), $18/('$abd_Fe'), $19/('$abd_Fe'), $20/('$abd_Fe'), $21/('$abd_Fe'), $22/('$abd_Fe'), $23/('$abd_Fe'), $24/('$abd_Fe'), $25/('$abd_Fe'), $26/('$abd_Fe'), $27/('$abd_Fe'), $28, $29, $30, '$temp'}' fe_tmp1.txt >> fe_state2.txt


### update abund1.txt

echo $num $logR $temp $avelogxi $sum_h $sum_he $sum_c $sum_n $sum_o $sum_ne $sum_mg $sum_si $sum_s $sum_ar $sum_ca $sum_cr $sum_mn $sum_fe $vi $lum38new > abund1_tmp.txt

# correct to elementary abundances

awk '{print $1, $2, $3, $4, $5/(1.0), $6/('$abd_He'), $7/('$abd_C'), $8/('$abd_N'), $9/('$abd_O'), $10/('$abd_Ne'), $11/('$abd_Mg'), $12/('$abd_Si'), $13/('$abd_S'), $14/('$abd_Ar'), $15/('$abd_Ca'), $16/('$abd_Cr'), $17/('$abd_Mn'), $18/('$abd_Fe'), $19, $20}' abund1_tmp.txt >> abund2.txt

### extract xstar's calculated spectral components

echo 9999 > slab_spec_"$num".txt
ftlist slab_spec_"$num".fits T columns="energy,incident,transmitted,emit_outward" rownum=no colheader=no >> slab_spec_"$num".txt

distb=$(echo "$newdist" | bc -l)

# find line luminosity [erg/sec] for Halpha and Hbeta
#lineL1=$(./LineLuminosity.sh xout_step.log)

# find line emissivity in [erg/sec/cm^3]
#line_para1a=$(./do_line.sh xout_detal2.fits)

# find line luminosity in [erg/sec/10**38] & optical depth
#line_para1b=$(./do_line2.sh xout_lines1.fits)

# find continuum optical depth over energy 
#./depth.sh

#echo $num $logR $avelogxi $line_para1a $line_para1b $lum38new $temp >> ems_list.txt

#cp xout_step.log step_"$num".log 

num=$(($num+1))
done

### end of while loop


#lastkcorrect=`awk 'NR == '$nl' {print $8}' $filename`
lastlineblueshift=`awk 'NR == '$nl' {print $9}' $filename`
lastkcorrect=1
#lastlineblueshift=1

# Remove "9999" on top of specfile.txt (total spectrum).

rm -f Fnu.txt
rm -f nuFnu.txt 
awk ' NR>1 {print $1*'$lastlineblueshift', $2*'$lastkcorrect'} ' specfile.txt > Fnu.txt
awk '{print $1*'$lastlineblueshift', $1*$2*'$lastkcorrect'*'$lastlineblueshift'}' Fnu.txt > nuFnu.txt

# stability curve - log(T) vs. log(xi/T)

rm -f stbl.txt
awk '{print $4-$3, $3}' abund2.txt > stbl.txt

echo "--- END of wind slab ---"


### end of the script

# from eV to Angstrom
# wavelength = (6.6261*10^-27)*(2.99*10^10)/(Eev*1.602*10^-12)*10^8
#            = 12382.5/Eev
