### WindScriptMachine.sh

### author: Abraham Reines & Keigo Fukumura
### ----------------------------------------------
### last update 03/3/2022

Ndensity=2 #i
#Density[1]=10
#Density[1]=25
#Density[2]=50
#Density[1]=75
Density[1]=100

Nxi=2 #i
#xi[1]=7.65081
#xi[1]=7.25287
#xi[2]=6.95184
#xi[1]=6.77575
xi[1]=6.65081

NL=9 #j
L[1]=42
L[2]=42.5
L[3]=43
L[4]=43.5
L[5]=44
L[6]=44.5
L[7]=45
L[8]=45.5
L[9]=46

NL44=9 #j
L44[1]=0.01
L44[2]=0.05
L44[3]=0.1
L44[4]=0.5
L44[5]=1.
L44[6]=5.
L44[7]=10.
L44[8]=50.
L44[9]=100.


basedir=/Users/Documents/AJR/Abraham2022Research/

i=1
while (( $i <=$Ndensity )) # changes density and xi
do
    j=1
    while (( $j <= $NL44 )) # changes both luminosity parameters
    do   
	
	cd "ObservationAngle60/Density"${Density[$i]}"L"${L[$j]}"/Gamma2.0_Alpha1.5/"
	pwd
	rm *.fits
	rm xout_step.log
	./wind_mhd_obs_pha.sh WindSolution_60deg_w_${Density[$i]}_L44_${L44[$j]}_M_1._xi_${xi[$i]}.txt
	pwd
	cd "../../.."
	
	j=$(($j+1))
    done
    i=$(($i+1))
done

