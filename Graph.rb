require 'tkextlib/tcllib/plotchart'
include Tk::Tcllib::Plotchart

Plot3D.new([0,10,3],[-10,10,10],[0,7.5,2.5],width:500,height:400){
  title "3D Plot3"
  grid_size(80,80)
  color(:red,:orange)
  plot_function{|x,y|
  	x2=x.to_f/9.0
  	y2=y.to_f/9.0
  	(x2+y2)*(x2+y2)
  }
}.pack(side: :left)

Tk.mainloop


