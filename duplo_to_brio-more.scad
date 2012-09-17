use<duplo.scad>
use<brio.scad>


duploh=19.2/2;
duploexternalundersize=.11;

briow=40.2;
brioh=12;


module briotoduplo(nl=2, nw=2, slope=1/3, edge=6){

	ang=atan(slope);
	l=max(35, 16*nl/cos(ang));
	h=l*abs(sin(ang));

	union(){
		rotate([0,0,90])
		duplobottom(nw=2, nl=nl, nh=1);

		translate([0,0,duploh+h/2])
		rotate([0,ang,0])
//		rail(l-edge*2);
		translate([6,0,0])
		rail(l-edge*2-5);

	//	translate([-16*nl/2,-16*nw/2,duploh])
		difference(){
			hull(){
				translate([0,0,duploh+h/2-1])
				rotate([0,ang,0])
				cube([l,briow,2.2], center=true);

				cube([16*nl,16*nw,.2], center=true);
			}
			translate([0,0,duploh/2-.3])
			cube([16*nl-duploexternalundersize*2-.2,16*nw-duploexternalundersize*2-.2,duploh+.2], center=true);

			}


		intersection(){

			hull(){
			translate([0,0,duploh+h/2])
				rotate([0,ang,0])
		//		rail(l-edge*2);
				translate([6,0,0])
				intersection(){
					rail(l-edge*2-5);

					cube([1000,1000,.2], center=true);
				}

				translate([-((16*nl)/2-duploexternalundersize-1),0,0])
				cylinder(r=1, h=1);
			}

			translate([-100-((16*nl)/2-duploexternalundersize-.1),-50,0])
			cube([100,100,1000]);
	}	


	}


}

module ramp(d=80, slope=1/3, edge=5, typea="F", typeb="M"){

	sign=abs(slope)/slope;
	ang=atan(slope);
	r=d/(ang*3.14159/180);

	lena = typea=="M"?1:20;
	lenb = typeb=="M"?1:20;

	union(){
		rotate([0,0,-90])
		intersection(){

			translate([0,0,r])
			rotate([0,90,0])
			rotate_extrude(convexity = 10, $fn=abs(d*36/ang))
			translate([abs(r), 0, 0])
			projection(cut = true)
			rotate([0,-90*sign,0])
			rail(300);

			translate([-500,0,-abs(r)])
			cube([1000,1000,2*abs(r)]);

			translate([0,0,r])
			rotate([ang,0,0])
			translate([-500,-1000,-r-500])
			cube([1000,1000,1000]);
		}

			translate([-lena/2-.05,0,0])
			rail(l=lena+.1,typea=typea,typeb="");

			translate([0,0,r])
			rotate([0,-ang,0])
			translate([lenb/2+.05,0,-r])
			rail(l=lenb+.1,typeb=typeb,typea="");


			if(sign > 0)//base for sitting on ground
			{


				translate([0,-briow/2,0])
				difference(){
					cube([r*sin(ang)+(lenb+edge)*cos(ang), briow, 1000]);

					translate([0,briow*2,r])
					rotate([90,0,0])
					cylinder(r=r-.1, h=briow*3, $fn=150);
				
					translate([0,-briow,r])
					rotate([0,-ang,0])
					translate([0,0,.1-r])
					cube([1000, briow*3, 1000]);
					}


				if(typeb=="M")//peg support
				{
					hull(){
						translate([0,0,r])
						rotate([0,-ang,0])
						translate([lenb/2+.05,0,-r])
						intersection(){
							rail(l=lenb+.1,typeb=typeb,typea="");

							translate([500+lenb,0,0])
							cube([1000,1000,.2], center=true);
						}

						translate([r*sin(ang)+(lenb+edge)*cos(ang)-1,0,0])
						cylinder(r=1, h=1);
					}
			
				}

			}



	}

}

//rail(40);
//negativerailhole();
//railpeg();


//duplobottom(nw=2, nl=2, nh=1);
//duplotop(nw=2, nl=3, nh=1);
//duplo(nw=2, nl=2, nh=2);


//briotoduplo(nl=2, nw=2, slope=1/3, edge=6);
//briotoduplo(nl=2, nw=2, slope=-1/3, edge=6);

//ramp(d=80, slope=1/3, edge=5, typea="F", typeb="M");
//ramp(d=80, slope=1/3, edge=5, typea="M", typeb="F");

ramp(d=40, slope=-1/3, edge=5, typea="F", typeb="M");

