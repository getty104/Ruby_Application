
require 'tk'

Tk.root.title("MoneyNote")
Tk.root.iconname("MoneyNote")
Tk.root.resizable(0, 0)
money = 0
addmoney =0
usemoney = 0


l1 = TkListbox.new{
	
	width 10
	height 5
	
	pack('fill'=>'x','side'=>'left')
}

l2 = TkListbox.new{
	
	width 10
	height 5
	
	pack('fill'=>'x','side'=>'left')
}

l3 = TkListbox.new{
	width 10
	height 5
	
	pack('fill'=>'x','side'=>'left')
}

l1.insert('end',"保存するためのファイルを選択してください")
f = Tk.getOpenFile
file = open(f,"w")
l1.delete(0)


add = TkLabel.new{
	width 30
	height 1
	pack('fill'=>'x','side'=>'top')
	text "総収入:#{addmoney}"
}

use = TkLabel.new{
	width 30
	height 1
	pack('fill'=>'x','side'=>'top')
	text "総支出:#{usemoney}"
}

all = TkLabel.new{
	width 30
	height 1
	pack('fill'=>'x','side'=>'top')
	text "残金:#{money}"

}




entry1 = TkEntry.new {
	width 10
	pack('fill'=>'x','side'=>'left')
}

entry2 = TkEntry.new {
	bind 'KeyPress', proc { |e|
		if e.to_s !~ /[0-9\b]/
			Tk.bell
			Tk.callback_break
		end
		}, "%A"

		pack('fill'=>'x','side'=>'left')
	}

	TkButton.new{
		width 5
		text "収入"
		pack('fill'=>'x','side'=>'left')
		command{
			l1.insert('end',"収入")
			l2.insert('end',entry1.value)
			l3.insert('end',entry2.value)
			addmoney += entry2.value.to_i
			money += entry2.value.to_i
			file.puts("収入:#{entry2.value}")
			add.text = "収入総額:#{addmoney}"
			all.text = "残金:#{money}"
			entry1.value = ""
			entry2.value = ""

			pack('fill'=>'both')
		}
	}

	TkButton.new{

		text "支出"
		width 5
		pack('fill'=>'x','side'=>'left')
		command{
			if money - entry2.value.to_i<0
				Tk.bell
			else
				l1.insert('end',"支出")
				l2.insert('end',entry1.value)
				l3.insert('end',entry2.value)
				usemoney += entry2.value.to_i
				money -= entry2.value.to_i
				file.puts("支出:#{entry2.value}")
				use.text ="支出総額:#{usemoney}"
				all.text = "残金:#{money}"
				entry1.value =""
				entry2.value = ""

				text "引き出し"
				width 14
				pack('fill'=>'both','side'=>'left')
			end
		}
	}





	Tk.mainloop
	file.puts("")
	file.puts("入金総額:#{addmoney}")
	file.puts("引き出し総額:#{usemoney}")
	file.puts("残金:#{money}")
	file.close


