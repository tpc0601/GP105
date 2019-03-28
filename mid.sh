out_ps=mid.ps
input_list=useq.list
  
cpt=mid.cpt

gmt set PS_MEDIA A4

gmt makecpt -T7/8/0.1 -Crainbow -Z > $cpt
  
# start gmt session
gmt psxy -R0/1/0/1 -JX1c -T -K > $out_ps
  
# Main map
gmt psbasemap -R-130/-60/24/50 -Jm0.3 -B5 -G0/250/250 -X-0.5 -Y5 -O -K >> $out_ps
gmt pscoast -R -J -B -W1 -G250/250/0 -Df -Ia -O -K >> $out_ps
awk '{print $2, $1, $4}' $input_list | gmt psxy -R -J -Sc0.3 -C$cpt -O -K >> $out_ps
echo "-100 55 earthquakes in the USA which magnitudes are above 7" | gmt pstext -R -N -J -F+f,Helvetica-Bold,black -O -K >> $out_ps
 
  
# Bottom map
gmt psbasemap -R-130/-60/0/120 -Jx0.3/-0.01 -B50 -X0 -Y-5 -O -K >> $out_ps
awk '{print $2, $3, $4}' $input_list | gmt psxy -R -J -Sc0.3 -C$cpt -O -K >> $out_ps
  
# Right map
gmt psbasemap -R0/100/24/50 -Jx0.03/0.4 -B50 -X23 -Y5 -O -K >> $out_ps
awk '{print $3, $1, $4}' $input_list | gmt psxy -R -J -Sc0.3 -C$cpt -O -K >> $out_ps
gmt psscale -C$cpt -Dx-17c/-1c+w12c/0.5c+jTC+h -Bxaf+l"topography" -By+lkm -O -K >> $out_ps
# end gmt session
gmt psxy -R -J -O -T >> $out_ps
  
# convert to pdf
gmt psconvert $out_ps -P -Tf
# convert to png
gmt psconvert $out_ps -P -Tg