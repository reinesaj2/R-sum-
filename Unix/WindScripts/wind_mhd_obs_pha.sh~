#!/bin/bash -f

### wind4c_obs.sh

### author: Keigo Fukumura
### help from T. Sakamoto, J. Garcia, D. Kazanas, T. Kallman
### ---------------------------------------------------------
### last updated 11/5/2019

###--- boundary conditions ---###
# for 50deg
#logxi0=6.5093
#xi30=3230.72
#Cf=1.

logxi0=6.88755
Cf=0.0

#redz=2.9
#alpha=-1.5
###############################################

### compile integral.f
# gfortran-mp-4.9 integral.f -o integral.x
#g95 integral.f -o integral.x

### remove pre-existing slab-spec files
find . -type f -name "slab_spec_*.txt" -exec rm -f {} \;
find . -type f -name "slab_spec_*.fits" -exec rm -f {} \;
find . -type f -name "slab_Fnu_*.txt" -exec rm -f {} \;
find . -type f -name "slab_cont_*.txt" -exec rm -f {} \;

rm -f abund2.txt
rm -f fe_state2.txt
rm -f o_state2.txt
rm -f c_state2.txt

# make sure to compile integral.f file 
# gfortran-mp-8 -c integral.f 
# gfortran-mp-8 integral.f -o integral.x

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
vturb0=`awk '{if (NR == '$num') print $7}' $filename`

#vturb00=$(echo "$vturb0*(3*(10^5))" | bc -l)
vturb00=$(echo "$vturb0*(3*(10^5))" | sed 's/e/\*10\^/' | sed 's/+//' | bc -l)
#echo $vturb00 

dist14b=$(echo "$dist0/(10^14)" | sed 's/e/\*10\^/' | sed 's/+//' | bc -l)
den7b=$(echo "$den/(10^7)" | sed 's/e/\*10\^/' | sed 's/+//' | bc -l)
col20b=$(echo "$col/(10^20)" | sed 's/e/\*10\^/' | sed 's/+//' | bc -l)
deltaR13=$(echo "$col20b/$den7b" | bc -l)

factxi=$(echo $logxi0 | awk '{print 10^($0-3.0)}')
L38ini=$(echo $den7b $dist14b $factxi | awk '{print $1*($2^2)*$3}')
#L38ini=$(echo "$den7b*($dist14b^2)*($xi30)" | bc -l)

echo "("$num") Distance = "$dist0", Density = " $den ", Column = " $col
echo "    Luminosity (in units of 10^38 erg/sec) = " $L38ini 
echo "blueshift = "$lineblueshift0", vturb = " $vturb0", vi = " $vi0

ab=1.0

xstar cfrac="$Cf"  trad=0. temperature=400. pressure=0.03 density="$den" spectrum='file' rlrad38="$L38ini" column="$col" rlogxi="$logxi0" lcpres=0 habund=1. heabund="$ab" liabund=0. beabund=0. babund=0. cabund="$ab" nabund="$ab" oabund="$ab" fabund=0. neabund="$ab" naabund=0. mgabund="$ab" alabund="$ab" siabund="$ab" pabund=0. sabund="$ab" clabund="$ab" arabund="$ab" kabund=0. caabund="$ab" scabund=0. tiabund=0. vabund=0. crabund="$ab" mnabund="$ab" feabund="$ab" coabund="$ab" niabund="$ab" cuabund=0. znabund=0. modelname="slab_cont_"$num""  vturbi="$vturb00" spectrum_file="SpectrumFile_G_1.5A_-1.5.txt" spectun=0. lprint=0


cp xout_spect1.fits slab_spec_"$num".fits
cp xout_cont1.fits slab_cont_"$num".fits
cp -f xout_step.log prev.log
date > prev.log

### extract xstar's calculated spectral components

echo 9999 > slab_spec_"$num".txt
echo 9999 > slab_cont_"$num".txt

ftlist slab_spec_"$num".fits T columns="energy,incident,transmitted,emit_outward" rownum=no colheader=no >> slab_spec_"$num".txt

ftlist slab_cont_"$num".fits T columns="energy,incident,transmitted,emit_outward" rownum=no colheader=no >> slab_cont_"$num".txt


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
ftlist xout_abund1.fits+2 T columns="fe_*" rownum=no colheader=no > fe.txt

sum_h=`./column_sum.sh h.txt | tail -1`
sum_he=`./column_sum.sh he.txt | tail -1`
sum_c=`./column_sum.sh c.txt | tail -1`
sum_n=`./column_sum.sh n.txt | tail -1`
sum_o=`./column_sum.sh o.txt | tail -1`
sum_ne=`./column_sum.sh ne.txt | tail -1`
sum_mg=`./column_sum.sh mg.txt | tail -1`
sum_si=`./column_sum.sh si.txt | tail -1`
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
HR=$(./integral.x < slab_cont_"$num".txt | awk '{print $4}' | xargs echo)

### compute corresponding average log(xi) with avexi.sh
avelogxi=$(./avexi.sh xout_step.log)

ftlist xout_abund1.fits+2 T columns="fe_*" rownum=no colheader=no | awk '{print '$logxi0', $0, '$vi0', '$logR', '$vturb0'}' > fe_state1.txt

ftlist xout_abund1.fits+2 T columns="o_*" rownum=no colheader=no | awk '{print '$logxi0', $0, '$vi0','$logR', '$vturb0'}' > o_state1.txt

ftlist xout_abund1.fits+2 T columns="c_*" rownum=no colheader=no | awk '{print '$logxi0', $0, '$vi0', '$logR', '$vturb0'}' > c_state1.txt

# correct to atomic abundances

awk '{print $1, $2*(3.16e4), $3*(3.16e4), $4*(3.16e4), $5*(3.16e4), $6*(3.16e4), $7*(3.16e4), $8*(3.16e4), $9*(3.16e4), $10*(3.16e4), $11*(3.16e4), $12*(3.16e4), $13*(3.16e4), $14*(3.16e4), $15*(3.16e4), $16*(3.16e4), $17*(3.16e4), $18*(3.16e4), $19*(3.16e4), $20*(3.16e4), $21*(3.16e4), $22*(3.16e4), $23*(3.16e4), $24*(3.16e4), $25*(3.16e4), $26*(3.16e4), $27*(3.16e4), $28, $29, $30}' fe_state1.txt > fe_state2.txt

awk '{print $1, $2*(1.35e3), $3*(1.35e3), $4*(1.35e3), $5*(1.35e3), $6*(1.35e3), $7*(1.35e3), $8*(1.35e3), $9*(1.35e3), $10, $11, $12}' o_state1.txt > o_state2.txt

awk '{print $1, $2*(2.82e3), $3*(2.82e3), $4*(2.82e3), $5*(2.82e3), $6*(2.82e3), $7*(2.82e3), $8, $9, $10}' c_state1.txt > c_state2.txt


### write log[T](ave), log(xi) and n_H(ion) into abund1.txt

rm -f abund1.txt

echo $num $logR $temp $logxi0 $sum_h $sum_he $sum_c $sum_n $sum_o $sum_ne $sum_mg $sum_si $sum_fe $vi0 > abund1.txt

# correct to elementary abundances

awk '{print $1, $2, $3, $4, $5*1, $6*1.02, $7*(2.82e3), $8*(1.07e4), $9*(1.35e3), $10*(8.32e3), $11*(2.63e4), $12*(2.82e4), $13*(3.16e4), $14}' abund1.txt > abund2.txt

# find Fe line emissivity in [erg/sec/cm^3]
fe_xxvi_L38=$(./do_line3.sh xout_lines1.fits)
echo $num $logR $logxi0 $avelogxi $temp $fe_xxvi_L38 $L38ini > fe_xxvi_L38.txt

# find line emissivity in [erg/sec/cm^3]
#line_para0a=$(./do_line.sh xout_detal2.fits)

# find line luminosity in [erg/sec/10**38] & optical depth
#line_para0b=$(./do_line2.sh xout_lines1.fits)

#echo $num $logR $logxi0 $line_para0a $line_para0b $L38ini $temp > ems_list.txt


#########################################
### from 2nd slab on (entering while loop)

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
vturb=`awk '{if (NR == '$num') print $7}' $filename`
#vturb=600
#lineblueshift=1
kcorrect=1

#vturb1=$(echo "$vturb*(3*(10^5))" | bc -l)
vturb1=$(echo "$vturb*(3*(10^5))" | sed 's/e/\*10\^/' | sed 's/+//' | bc -l)

### update luminosity (in units of 10**38) for next calculation with xstar
rm -f specfile0.txt
lum38list=$(./integral2.x < slab_spec_"$prevnum".txt | xargs echo)
lum38=$(./integral2.x < slab_spec_"$prevnum".txt | awk '{print $1}' | xargs echo)
lum38new=$(echo "$lum38*$kcorrect" | bc -l)

#echo "integrals: " $lum38list


### compute hardness ratio (HR)
HR=$(./integral2.x < slab_spec_"$prevnum".txt | awk '{print $4}' | xargs echo)

### generate a new input file for total spectrum to be used next

rm -f specfile.txt
echo "9999" > specfile.txt
awk 'NR>1 {print $1*'$lineblueshift', $2*'$kcorrect'}' specfile0.txt >> specfile.txt

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

### convert luminosity spectrum (erg/s/erg) to flux spectrum (erg/s/erg/cm^2)
echo "this is fluxed spectrum!" > slab_Fnu_"$num".txt

#slab_area=$(echo "4*3.1415*($newdist)^2" | bc -l)
#echo "slab area=" $slab_area
awk -v var="$slab_area" 'NR>1 {print $1, $2}' specfile.txt  >> slab_Fnu_"$num".txt

#echo "distb=" $distb
#echo "dist14=" $dist14 
#echo "deltaR13=" $deltaR13
#echo "density=" $den7b 
#echo "col=" $col20b 
#echo "logxi=" $logxi 

xstar cfrac="$Cf"  temperature=400. pressure=0.03 density="$den" spectrum='file' trad=0. spectun=0. spectrum_file="specfile.txt"  rlrad38="$lum38new"  column="$col" rlogxi="$logxi" lcpres=0. habund=1. heabund=1. liabund=0. beabund=0. babund=0. cabund="$ab" nabund="$ab" oabund="$ab" fabund=0. neabund="$ab" naabund=0. mgabund="$ab" alabund="$ab" siabund="$ab" pabund=0. sabund="$ab" clabund="$ab" arabund="$ab" kabund=0. caabund="$ab" scabund=0. tiabund=0. vabund=0. crabund="$ab" mnabund="$ab" feabund="$ab" coabund="$ab" niabund="$ab" cuabund=0. znabund=0. modelname="slab_cont_"$num""  vturbi="$vturb1" lprint=0

cp xout_spect1.fits slab_spec_"$num".fits
cp xout_cont1.fits slab_cont_"$num".fits

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
ftlist xout_abund1.fits+2 T columns="fe_*" rownum=no colheader=no > fe.txt

sum_h=`./column_sum.sh h.txt | tail -1`
sum_he=`./column_sum.sh he.txt | tail -1`
sum_c=`./column_sum.sh c.txt | tail -1`
sum_n=`./column_sum.sh n.txt | tail -1`
sum_o=`./column_sum.sh o.txt | tail -1`
sum_ne=`./column_sum.sh ne.txt | tail -1`
sum_mg=`./column_sum.sh mg.txt | tail -1`
sum_si=`./column_sum.sh si.txt | tail -1`
sum_fe=`./column_sum.sh fe.txt | tail -1`

#echo "H:"$sum_h "He:"$sum_he "C:"$sum_c "O:"$sum_o "Ca:"$sum_ca "Fe:"$sum_fe 

### compute corresponding average temperature with aveT.sh
temp=$(./aveT.sh xout_step.log)

### compute corresponding average log(xi) with avexi.sh
avelogxi=$(./avexi.sh xout_step.log)

### compute corresponding average dist. with aveR.sh
logR=$(./aveR.sh xout_step.log)

### update fe.txt

#ftlist xout_abund1.fits+2 T columns="radius,fe_*" rownum=no colheader=no >> fe_#state.txt

ftlist xout_abund1.fits+2 T columns="fe_*" rownum=no colheader=no | awk '{print '$avelogxi', $0, '$vi','$logR','$vturb'}' > fe_tmp1.txt

ftlist xout_abund1.fits+2 T columns="o_*" rownum=no colheader=no | awk '{print '$avelogxi', $0, '$vi','$logR', '$vturb'}'  > o_tmp1.txt

ftlist xout_abund1.fits+2 T columns="c_*" rownum=no colheader=no | awk '{print '$avelogxi', $0, '$vi', '$logR', '$vturb'}' > c_tmp1.txt

# correct to atomic abundances

awk '{print $1, $2*(3.16e4), $3*(3.16e4), $4*(3.16e4), $5*(3.16e4), $6*(3.16e4), $7*(3.16e4), $8*(3.16e4), $9*(3.16e4), $10*(3.16e4), $11*(3.16e4), $12*(3.16e4), $13*(3.16e4), $14*(3.16e4), $15*(3.16e4), $16*(3.16e4), $17*(3.16e4), $18*(3.16e4), $19*(3.16e4), $20*(3.16e4), $21*(3.16e4), $22*(3.16e4), $23*(3.16e4), $24*(3.16e4), $25*(3.16e4), $26*(3.16e4), $27*(3.16e4), $28, $29, $30}' fe_tmp1.txt >> fe_state2.txt

awk '{print $1, $2*(1.35e3), $3*(1.35e3), $4*(1.35e3), $5*(1.35e3), $6*(1.35e3), $7*(1.35e3), $8*(1.35e3), $9*(1.35e3), $10, $11, $12}' o_tmp1.txt >> o_state2.txt

awk '{print $1, $2*(2.82e3), $3*(2.82e3), $4*(2.82e3), $5*(2.82e3), $6*(2.82e3), $7*(2.82e3), $8, $9, $10}' c_tmp1.txt >> c_state2.txt

### update abund1.txt

echo $num $logR $temp $avelogxi $sum_h $sum_he $sum_c $sum_n $sum_o $sum_ne $sum_mg $sum_si $sum_fe $vi > abund1_tmp.txt

# correct to elementary abundances

awk '{print $1, $2, $3, $4, $5, $6*(1.02), $7*(2.82e3), $8*(1.07e4), $9*(1.35e3), $10*(8.32e3), $11*(2.63e4), $12*(2.82e4), $13*(3.16e4), $14}' abund1_tmp.txt >> abund2.txt


### extract xstar's calculated spectral components

echo 9999 > slab_spec_"$num".txt
echo 9999 > slab_cont_"$num".txt

ftlist slab_spec_"$num".fits T columns="energy,incident,transmitted,emit_outward" rownum=no colheader=no >> slab_spec_"$num".txt
ftlist slab_cont_"$num".fits T columns="energy,incident,transmitted,emit_outward" rownum=no colheader=no >> slab_cont_"$num".txt

distb=$(echo "$newdist" | bc -l)

#echo $distb

# stop calculations when outer distance is reached: r_out ~ 1e18cm

diff=$(echo "$distb-1.0*10^18" | bc -l)
#echo $diff
if (( $(bc <<< "$diff > 0") )); then
    echo yes: outer distance reached!!!
    switch=1
    break
else
#    echo no
    switch=0
fi

#echo $switch

# find Fe line emissivity in [erg/sec/cm^3]
fe_xxvi_L38=$(./do_line3.sh xout_lines1.fits)
echo $num $logR $logxi0 $avelogxi $temp $fe_xxvi_L38 $L38ini >> fe_xxvi_L38.txt


# find line emissivity in [erg/sec/cm^3]
#line_para1a=$(./do_line.sh xout_detal2.fits)

# find line luminosity in [erg/sec/10**38] & optical depth
#line_para1b=$(./do_line2.sh xout_lines1.fits)

#echo $num $logR $avelogxi $line_para1a $line_para1b $lum38new $temp >> ems_list.txt

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

echo "--- END of calculations ---"

# MakePhaFile
./MakePhaFile.sh

### end of the script

# from eV to Angstrom
# wavelength = (6.6261*10^-27)*(2.99*10^10)/(Eev*1.602*10^-12)*10^8
#            = 12382.5/Eev


