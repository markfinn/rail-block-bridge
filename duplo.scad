mdia=9.43;
mt=1.21;
mh=4.55;

s=16;
h=19.2/2;

fdia=13.15;
ft=1.21;
fover=.00; //measured .05, but didn't fit on my printer
fc=0;
fca=2;

externalundersize=.11;

wt=1.6;

$fn=50;

module duplobottom(nw=2, nl=3, nh=2)
{
	union(){
		difference(){
			translate([0,0,nh*h/2])
			cube([nw*s-2*externalundersize, nl*s-2*externalundersize, nh*h], center=true);

			translate([0,0,nh*h/2-wt])
			cube([nw*s-2*externalundersize-2*wt, nl*s-2*externalundersize-2*wt, nh*h], center=true);
		}


		difference(){
			union(){
				for(x=[0:nw-2])
				for(y=[0:nl-2])
				translate([(x-nw/2+1)*s,(y-nl/2+1)*s,0]){
					translate([0,0,fc])
					cylinder(r=fdia/2, h=nh*h-fc);
					cylinder(r2=fdia/2, r1=fdia/2-fc/fca, h=fc+.01);
				}

				for(x=[0:nw-2])
				translate([(x-nw/2+1)*s-ft/2,-(nl*s-2*externalundersize)/2,mh])
				cube([ft, nl*s-2*externalundersize, nh*h-mh]);

				for(y=[0:nl-2])
				translate([-(nw*s-2*externalundersize)/2, (y-nl/2+1)*s-ft/2,mh])
				cube([nw*s-2*externalundersize, ft, nh*h-mh]);

				for(x=[0:nw-1])
				translate([(x-nw/2+.5)*s-ft/2,-(nl*s-2*externalundersize)/2,0])
				difference(){
					cube([ft, nl*s-2*externalundersize, nh*h]);
					translate([-1,((nl*s-2*externalundersize) - (s*(nl-1)+mdia-2*fover))/2,-1])
					cube([ft+2, s*(nl-1)+mdia-2*fover, nh*h+2]);
				}

				for(y=[0:nl-1])
				translate([-(nw*s-2*externalundersize)/2,(y-nl/2+.5)*s-ft/2,0])
				difference(){
					cube([nw*s-2*externalundersize, ft, nh*h]);
					translate([((nl*s-2*externalundersize) - (s*(nl-1)+mdia-2*fover))/2,-1,-1])
					cube([s*(nw-1)+mdia-2*fover, ft+2, nh*h+2]);
				}
			}

			for(x=[0:nw-2])
			for(y=[0:nl-2])
			translate([(x-nw/2+1)*s,(y-nl/2+1)*s,0]){
				translate([0,0,fc-1])
				cylinder(r=fdia/2-ft, h=nh*h+2);
				translate([0,0,-.01])
				cylinder(r2=fdia/2-ft, r1=fdia/2-ft-fc/fca, h=fc+.02);
			}
		}
	}
}

module duplotop(nw=2, nl=3, nh=2)
{
	difference(){

		union(){
			translate([0,0,wt/2])
			cube([nw*s-2*externalundersize, nl*s-2*externalundersize, wt], center=true);

			for(x=[0:nw-1])
			for(y=[0:nl-1])
			translate([(x-nw/2+.5)*s,(y-nl/2+.5)*s,0])
			cylinder(r=mdia/2, h=mh+wt);
		}

		for(x=[0:nw-1])
		for(y=[0:nl-1])
		translate([(x-nw/2+.5)*s,(y-nl/2+.5)*s,0]){
			translate([0,0,wt])
			cylinder(r=mdia/2-mt, h=mh+wt);
		}
	}

}

module duplo(nw=2, nl=2, nh=1){
	union(){
		translate([0,0,nh*h-wt])
		duplotop(nw=nw, nl=nl, nh=nh);
		duplobottom(nw=nw, nl=nl, nh=nh);
	}
}

//duplobottom(nw=2, nl=2, nh=1);
//duplotop(nw=2, nl=3, nh=1);
duplo(nw=2, nl=2, nh=2);

