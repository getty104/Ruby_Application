

require "tk"

Tk.root.title("Clock")
Tk.root.iconname("Clock")
Tk.root.resizable(0, 0)

l1=TkLabel.new{
	width 25
	height 2
	bg "black"
	fg "green"
	text ""

	font TkFont.new("Times 24")

	pack('fill'=>'both')
}
l2=TkLabel.new{
	width 25
	height 2
	bg "black"
	fg "green"
	text ""

	font TkFont.new("Times 24")

	pack('fill'=>'both')
}

day = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
Thread.new{
	loop do
		l1.text("#{Time.now}")
		l2.text("#{day[Time.now.wday]}")
		sleep(1)
		Tk.bell
	end
}



TkCanvas.new { |c|
	width 270
	height 110 
	bg "black"

	
	

  #                    x1  y1  x2   y2

  $arc = TkcArc.new(c, 10, 10, 110, 110, "start" => 0, "extent" => 359)
  $arc.configure("fill" => "black", "outline" => "yellow")
  pack('fill'=>'both')
  
}

def timer
	n = 0
  TkAfter.new(100, -1, proc { # or TkTimer
    $arc.move(30 * Math.sin(Math::PI * (n) / 10), 0) # move
    $arc.configure("start" => n*10 ) # rotate
    n += 1
    }).start
end

timer # start timer

time=TkLabel.new{
	height 2
	bg "black"
	fg "green"
	text "0.00"
	pack('fill'=>'both')
}

start=Time.now.to_f
stop = nil
TkButton.new{
	width 14
	text "start"
	pack('fill'=>'both','side'=>'left')
	command{start = Time.now.to_f}
}


TkButton.new{
	text "stop"
	width 14
	pack('fill'=>'both','side'=>'left')
	command{stop = Time.now.to_f
		time.text(stop-start)
	}

}




Tk.mainloop



