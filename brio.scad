
th=12;
tw=40.2;

rs=25.1;
rd=3.2;
rw=6;

xd=11.815;
xdia=12.375;
xw=6.875;

gap=1.5;

fd=xd-gap/2;
fdia=xdia+gap/2;
fw=xw+gap/2;
fc=1.5;

md=xd+gap/2;
mdia=xdia-gap/2;
mw=xw-gap/2;

module railpeg (h=th, xover=1){

	translate([-md,0,0])
	union(){
		cylinder(r=mdia/2, h=h, center=true);

		translate([0,-mw/2,-h/2])
		cube([md+xover, mw, h]);

	}

}




module negativerailhole (h=th, xover=1){

	difference(){
		union(){
			translate([-fd,0,0])
			union(){
				cylinder(r=fdia/2, h=h, center=true);

				translate([0,-fw/2,-h/2])
				cube([fd, fw, h]);

			}
				translate([-fw/2-fc, 0,-h/2])
				rotate([0,0,-45])
				cube([fw*2, fw*2, h]);
		}

		translate([fw*3+xover, 0,0])
		cube([fw*6, fw*6, h*2], center=true);

	}
}



module rail (l=100, typea="M", typeb="F", edget=0, edgew=0){

	translate([0,0,th/2])
	difference(){
		union(){
			cube([l, tw, th], center=true);

			if(typea == "M" || typea == "m")
			{
				translate([-l/2,0,0])
				railpeg(h=th);

				translate([l/2-1,-tw/2,-th/2-edget])
				cube([1+edgew,tw,edget+.1]);
			}

			if(typeb == "M" || typeb == "m")
			{
				mirror([1,0,0])
				translate([-l/2,0,0])
				railpeg(h=th);

				translate([-l/2-edgew,-tw/2,-th/2-edget])
				cube([1+edgew,tw,edget+.1]);
			}
		}
		for(y=[-rs/2, rs/2])
			translate([0,y,th/2-rd/2]){
				translate([0,0,.5])
				cube([l+1, rw, rd+1], center=true);
				for(r=[0,180])
					rotate([0,0,r])
					translate([0,rw/2,rd/4])
					rotate([45,0,0])
					translate([-l/2-.5,-rd*sqrt(2)/2,0])
					cube([l+1, rd*sqrt(2), rd/3]);
			}

		if(typea == "F" || typea == "F")
		{
			mirror([1,0,0])
			translate([l/2,0,0])
			negativerailhole(h=th+1);
		
			translate([-l/2-edgew,-tw/2,-th/2-edget])
			cube([20+edgew,tw,edget+.1]);
		}
		
		
		if(typeb == "F" || typeb == "F")
		{
			translate([l/2,0,0])
			negativerailhole(h=th+1);

			translate([l/2-20,-tw/2,-th/2-edget])
			cube([20+edgew,tw,edget+.1]);
		}
	}
}
//negativerailhole();
//railpeg();

//rail(40);
rail (l=130, typea="M", typeb="M");

